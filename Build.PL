#! /usr/bin/perl
#---------------------------------------------------------------------

use Module::Build;
use ExtUtils::PkgConfig;

my %libmtp = eval { ExtUtils::PkgConfig->find('libmtp') };
exit 0 unless %libmtp;        # bail out if no libmtp

if (eval {require ExtUtils::Constant; 1}) {
  print "Regenerating constants...\n";
  require 'lib/Media/LibMTP/API/Constants.pm';

  my @names = (
    map { /LIBMTP_DEBUG_/ ? $_ : { name => $_, macro => '1' } }
    @{ $Media::LibMTP::API::EXPORT_TAGS{all} }
  );
  ExtUtils::Constant::WriteConstants(
     NAME         => 'Media::LibMTP::API',
     NAMES        => \@names,
     DEFAULT_TYPE => 'IV',
     C_FILE       => 'lib/Media/LibMTP/const-c.inc',
     XS_FILE      => 'lib/Media/LibMTP/const-xs.inc',
  );
} # end if ExtUtils::Constant available

my $build = Module::Build->new(
  dist_name            => 'Media-LibMTP-API',
  dist_version_from    => 'lib/Media/LibMTP/API.pm',
  dist_abstract        => 'Low-level interface to LibMTP',
  dist_author          => 'Christopher J. Madsen <perl@cjmweb.net>',
  module_name          => 'Media::LibMTP::API', # for packlist
  extra_compiler_flags => $libmtp{cflags},
  extra_linker_flags   => $libmtp{libs},
##{ $plugin->get_prereqs ##}
);

$build->create_build_script;
