#---------------------------------------------------------------------
package Media::LibMTP::API;
#
# Copyright 2011 Christopher J. Madsen
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
# Created: 27 Nov 2011
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# ABSTRACT: Low-level interface to libmtp
#---------------------------------------------------------------------

use 5.010;
use strict;
use warnings;

our $VERSION = '0.04';
# This file is part of {{$dist}} {{$dist_version}} ({{$date}})

use Carp qw(croak);
use Exporter ();

our %EXPORT_TAGS;
use Media::LibMTP::API::Constants ();

push @{ $EXPORT_TAGS{'all'} },
  qw(Detect_Raw_Devices Get_Filetype_Description Get_First_Device
     Get_Property_Description
     FILETYPE_IS_AUDIO FILETYPE_IS_VIDEO FILETYPE_IS_AUDIOVIDEO
     FILETYPE_IS_TRACK FILETYPE_IS_IMAGE FILETYPE_IS_ADDRESSBOOK
     FILETYPE_IS_CALENDAR
);

*EXPORT_OK = $EXPORT_TAGS{'all'}; # just alias the arrayref

# This AUTOLOAD is used to 'autoload' constants from the constant()
# XS function.
sub AUTOLOAD
{
  my $constname;
  our $AUTOLOAD;
  ($constname = $AUTOLOAD) =~ s/.*:://;
  croak "&Media::LibMTP::API::$constname not defined"
      unless $constname =~ /^LIBMTP_/;
  my ($error, $val) = constant($constname);
  if ($error) {
    croak $error;
  } else {
    no strict 'refs';
    *$AUTOLOAD = sub () { $val };
  }
  goto &$AUTOLOAD;
} # end AUTOLOAD

sub import
{
  # Force AUTOLOAD of constant subs so they can be inlined:
  my $code;
  for (@_) {
    if (/^LIBMTP_\w+\z/) {
      $code .= "$_();\n";
    } elsif (/^:(\w+)\z/ and exists $EXPORT_TAGS{$1}) {
      for (@{ $EXPORT_TAGS{$1} }) {
        $code .= "$_();\n" if /^LIBMTP_\w+\z/;
      }
    }
  } # end for @_

  if (defined $code) {
    no warnings;
    local $@;
    eval $code;
  } # end if we're exporting constants

  # Now do the actual exporting:
  goto &Exporter::import;
} # end import

#---------------------------------------------------------------------
# Memory management:
#
# libmtp often returns a group of structs in one memory allocation.
# We must keep a pointer to the group until all members of the group
# are no longer being referenced.

{
  package Media::LibMTP::API::SubObject;

  my %parent;

  sub DESTROY { delete $parent{ +shift } }

  sub _wrap_constructor
  {
    my $method = pop;           # This comes at the end
    my $self   = shift;

    my @new = $self->$method(@_);

    foreach my $new (@new) {
      $parent{$new} = $parent{$self} // $self if defined $new;
    }

    return wantarray ? @new : $new[0];
  } # end _wrap_constructor
} # end Media::LibMTP::API::SubObject

#---------------------------------------------------------------------
# Set up inheritance:

BEGIN {
  my $code;

  my $addMethods = sub {
    my $class = shift;

    foreach my $method (@_) { $code .= <<"END METHOD" }
      sub Media::LibMTP::API::${class}::${method} {
        push \@_, '_${method}';
        goto &Media::LibMTP::API::SubObject::_wrap_constructor;
      }
END METHOD
  };

  for my $class (qw(Album File Folder MTPDevice Playlist Track)) {
    $code .= <<"END ISA";
      \@Media::LibMTP::API::${class}::ISA = ('Media::LibMTP::API::SubObject');
      \@Media::LibMTP::API::${class}List::ISA = ('Media::LibMTP::API::$class');
END ISA
    $addMethods->($class, 'next') unless $class eq 'Folder';
  } # end for each $class

  # Other methods that return subobjects:
  $addMethods->(qw(Folder     child sibling Find_Folder));
  $addMethods->(qw(MTPDevice  storage));
  @Media::LibMTP::API::DeviceStorage::ISA = ('Media::LibMTP::API::SubObject');
  $addMethods->(qw(DeviceStorage  next prev));
  @Media::LibMTP::API::RawDevice::ISA = ('Media::LibMTP::API::SubObject');
  $addMethods->(qw(RawDeviceList  device devices));
  #print $code;
  my $err;
  {
    local $@;
    $err = $@ || "UNKNOWN ERROR" unless eval "$code 1"; ## no critic
  }
  die "$code$err" if $err;
}

#---------------------------------------------------------------------
# Helper method for error messages:

sub Media::LibMTP::API::MTPDevice::errstr
{
  my $self = shift;

  my $err = my $errList = $self->Get_Errorstack;

  my @stack;

  while ($err) {
    push @stack, sprintf "%d: %s", $err->errornumber, $err->error_text;
    $err = $err->next;
  }

  join("\n", @stack);
} # end errstr

#---------------------------------------------------------------------
require XSLoader;
XSLoader::load('Media::LibMTP::API', $VERSION);

Init();                         # Only needs to be called once

1;
__END__

=head1 SYNOPSIS

  use Media::LibMTP::API qw(Get_First_Device);
  my $device = Get_First_Device() or die;
  say $device->Get_Friendlyname;

=head1 DESCRIPTION

Media::LibMTP::API provides a low-level interface to
libmtp (L<http://libmtp.sourceforge.net>), which is an Initiator
implementation of the Media Transfer Protocol (MTP) in the form of a
library suitable primarily for POSIX compliant operating systems.

libmtp is not included with Media::LibMTP::API; you must install it
separately.

=for use-when-Media-LibMTP-released
You probably want to use L<Media::LibMTP> instead.  It wraps this
module in a higher-level, more Perl-like interface.
Media::LibMTP::API follows the libmtp API closely, even when that's
not very Perlish.

Media::LibMTP::API is a thin wrapper around libmtp.  It follows the
libmtp API closely, even when that's not very Perlish.  For example,
many functions return 0 on success.  Media::LibMTP will be a
higher-level, more Perl-like interface built on top of
Media::LibMTP::API, but it's not yet ready for release.  You can
follow or help with Media::LibMTP's development at
L<https://github.com/madsen/media-libmtp>.

This module is not well documented.  Consult the libmtp documentation
(which can be generated by Doxygen, and should have been installed
along with libmtp).  All functions that take a pointer to a libmtp
struct as their first parameter are implemented as a method on the
corresponding Perl object.  Not all functions are currently implemented;
consult the source for details.

Many libmtp functions return a linked list of structures.  In
Media::LibMTP::API, this is managed by having two classes for each
type of object.  The initial structure represents the entire list, and
will be one of these subclasses: AlbumList, FileList, FolderList,
MTPDeviceList, PlaylistList, or TrackList.  These are exactly the same
as the non-List types, except that their destructor cleans up the list.
The non-List types keep a hidden reference to their parent List
object, so you don't need to worry about the list being freed too
soon.  No memory is released as long as any object in the list is
still referenced.  (e.g., if you get a 10,000 object list, and keep a
reference to only 1 object, the entire list is kept in memory until
you're done with that 1 object.)

=head1 DEPENDENCIES

libmtp 1.1.0 or later

=head1 SEE ALSO

L<Media::LibMTP>.

L<http://libmtp.sourceforge.net>

L<http://en.wikipedia.org/wiki/Media_Transfer_Protocol>

The libmtp documentation generated by Doxygen.

=for Pod::Coverage
.*

=cut
