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
# ABSTRACT: Low-level interface to LibMTP
#---------------------------------------------------------------------

use 5.010;
use strict;
use warnings;

our $VERSION = '0.01';
# This file is part of {{$dist}} {{$dist_version}} ({{$date}})

use Carp;
use Exporter ();

our %EXPORT_TAGS;
use Media::LibMTP::API::Constants ();

our @EXPORT_OK = (
  qw(Get_Filetype_Description Get_First_Device Get_Property_Description),
  @{ $EXPORT_TAGS{'all'} }
);

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
    local $@;
    eval $code;
  } # end if we're exporting constants

  # Now do the actual exporting:
  goto &Exporter::import;
} # end import

#---------------------------------------------------------------------
# Set up inheritance:
{
  package Media::LibMTP::API::AlbumList;
  our @ISA = ('Media::LibMTP::API::Album');
}
{
  package Media::LibMTP::API::FileList;
  our @ISA = ('Media::LibMTP::API::File');
}
{
  package Media::LibMTP::API::FolderList;
  our @ISA = ('Media::LibMTP::API::Folder');
}
{
  package Media::LibMTP::API::PlaylistList;
  our @ISA = ('Media::LibMTP::API::Playlist');
}
{
  package Media::LibMTP::API::TrackList;
  our @ISA = ('Media::LibMTP::API::Track');
}

#---------------------------------------------------------------------
require XSLoader;
XSLoader::load('Media::LibMTP::API', $VERSION);

Init();

1;
__END__

=head1 SYNOPSIS

  use Media::LibMTP::API qw(Get_First_Device);
  my $device = Get_First_Device() or die;
  say $device->Get_Friendlyname;

=head1 DESCRIPTION

Media::LibMTP::API provides a low-level interface to
LibMTP (L<http://libmtp.sourceforge.net>), which is an Initiator
implementation of the Media Transfer Protocol (MTP) in the form of a
library suitable primarily for POSIX compliant operating systems.

LibMTP is not included with Media::LibMTP::API; you must install it
separately.

You probably want to use L<Media::LibMTP> instead.  It wraps this
module in a higher-level, more Perl-like interface.

=head1 SEE ALSO

L<Media::LibMTP>.

=for Pod::Coverage
.

=cut
