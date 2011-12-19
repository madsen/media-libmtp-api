#! /usr/bin/perl
#---------------------------------------------------------------------

use Test::More 0.88;            # done_testing

use strict;
use warnings;
use 5.010;

use Media::LibMTP::API ':filetypes';

my @tests;
BEGIN {
  @tests = (
    'image/gif'  => LIBMTP_FILETYPE_GIF,
    jpg          => LIBMTP_FILETYPE_JPEG,
    mpg          => LIBMTP_FILETYPE_MPEG,
    'video/mpeg' => LIBMTP_FILETYPE_MPEG,
    ogg          => LIBMTP_FILETYPE_OGG,
  );

  plan tests => 1 + @tests/2;

  use_ok('Media::LibMTP::API::Filetypes', 'filetype');
}

while (@tests) {
  my $name     = shift @tests;
  my $expected = shift @tests;

  is(filetype($name), $expected, $name);
} # end while @tests

done_testing;
