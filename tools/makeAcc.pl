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

    my ($type, $field, $desc) =
        m!^\s*(\w+\b(?:\s*\*)?)\s*(\w+);\s*/\*\*<\s*(.+?)\s*\*/!
        or die "Bad line $.:$_";

    $type = "MLA_\u$1"   if $type =~ /^LIBMTP_(\w+)_t\s*\*$/;
    $type = 'Utf8String' if $type =~ /^char\s*\*$/;

    print <<"";
$type
$field(self)
	$struct	self
   CODE:
	RETVAL = self->$field;
   OUTPUT:
	RETVAL\n

  } # end while <$in>

} # end process_type
