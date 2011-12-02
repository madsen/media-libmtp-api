#! /usr/bin/perl
#---------------------------------------------------------------------
# makeAcc.pl
# Copyright 2011 Christopher J. Madsen
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# Create accessors for LibMTP structs
#---------------------------------------------------------------------

use strict;
use warnings;
use 5.010;

use autodie ':io';

my $header = '/usr/include/libmtp.h';
my $read_only;

if ($ARGV[0] eq '-r') {
  shift @ARGV;
  $read_only = 1;
}

my @type = @ARGV;

open(my $in, '<', $header);

while (<$in>) {
  next unless /^struct LIBMTP_(\w+)_struct \{/ and $1 ~~ @type;

  process_struct($1, $in);
}

sub process_struct
{
  my ($struct, $in) = @_;

  $struct = "MLA_\u$struct";
  say "\n# $struct\n";

  while (<$in>) {
    last if /^\}/;
    next if /^\s*\/\*/;         # comment
    next if /^\s*\*\s/;         # continued comment
    next if /^\s*\*\//;         # end comment

    my $ro = $read_only;
    my $newValue = 'newValue';
    my ($type, $field) =
        m!^\s*(\w+\b(?:\s*\*)?)\s*(\w+);!
        or die "Bad line $.:$_";

    if ($type =~ /^LIBMTP_(\w+)_t\s*\*$/) {
      $type = "MLA_\u$1";
      $ro = 1;
    } elsif ($type =~ /^char\s*\*$/) {
      $type = 'Utf8String';
      $newValue = "strdup($newValue)";
    }

    if ($ro) {
      print <<"END READ-ONLY";
$type
$field(self)
	$struct	self
   CODE:
	RETVAL = self->$field;
   OUTPUT:
	RETVAL\n
END READ-ONLY
    } else {
      print <<"END READ-WRITE";
$type
$field(self, newValue = NO_INIT)
	$struct	self
	$type	newValue
   CODE:
	if (items > 1)
	  self->$field = $newValue;
	RETVAL = self->$field;
   OUTPUT:
	RETVAL\n
END READ-WRITE
    } # end else read-write accessor
  } # end while <$in>
} # end process_type
