#---------------------------------------------------------------------
package Media::LibMTP::API::Filetypes;
#
# Copyright 2011 Christopher J. Madsen
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
# Created: 18 Dec 2011
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# ABSTRACT: Map extensions & MIME types to libmtp filetypes
#---------------------------------------------------------------------

use 5.010;
use strict;
use warnings;

our $VERSION = '0.01';
# This file is part of {{$dist}} {{$dist_version}} ({{$date}})

use Exporter 5.57 'import';     # exported import method
our @EXPORT_OK = qw(filetype);

use Media::LibMTP::API ':filetypes';

#=====================================================================
sub _f
{
  my $type = shift;
  map { $_ => $type } @_;
} # end _f

our %typemap = (
  _f(LIBMTP_FILETYPE_WAV,        qw(wav audio/vnd.wave)),
  _f(LIBMTP_FILETYPE_MP3,        qw(mp3 audio/mpeg)),
  _f(LIBMTP_FILETYPE_WMA,        qw(wma audio/x-ms-wma)),
  _f(LIBMTP_FILETYPE_OGG,        qw(ogg audio/ogg audio/vorbis)),
  _f(LIBMTP_FILETYPE_AUDIBLE,    qw(aa)),
  _f(LIBMTP_FILETYPE_MP4,        qw(mp4 m4v audio/mp4 video/mp4)),
  _f(LIBMTP_FILETYPE_WMV,        qw(wmv video/x-ms-wmv)),
  _f(LIBMTP_FILETYPE_AVI,        qw(avi)),
  _f(LIBMTP_FILETYPE_MPEG,       qw(mpg mpeg video/mpeg)),
  _f(LIBMTP_FILETYPE_ASF,        qw(asf)),
  _f(LIBMTP_FILETYPE_QT,         qw(qt mov video/quicktime)),
  _f(LIBMTP_FILETYPE_JPEG,       qw(jpg jpeg image/jpeg)),
  _f(LIBMTP_FILETYPE_JFIF,       qw(jfif)),
  _f(LIBMTP_FILETYPE_TIFF,       qw(tiff image/tiff)),
  _f(LIBMTP_FILETYPE_BMP,        qw(bmp)),
  _f(LIBMTP_FILETYPE_GIF,        qw(gif image/gif)),
  _f(LIBMTP_FILETYPE_PICT,       qw(pic pict)),
  _f(LIBMTP_FILETYPE_PNG,        qw(png image/png)),
  _f(LIBMTP_FILETYPE_VCALENDAR1, qw()),
  _f(LIBMTP_FILETYPE_VCALENDAR2, qw(ics)),
  _f(LIBMTP_FILETYPE_VCARD2,     qw()),
  _f(LIBMTP_FILETYPE_VCARD3,     qw(vcf text/vcard)),
  _f(LIBMTP_FILETYPE_WINDOWSIMAGEFORMAT, qw(wmf image/x-wmf)),
  _f(LIBMTP_FILETYPE_WINEXEC,    qw(exe com bat dll sys)),
  _f(LIBMTP_FILETYPE_TEXT,       qw(txt text/plain)),
  _f(LIBMTP_FILETYPE_HTML,       qw(htm html text/html)),
  _f(LIBMTP_FILETYPE_FIRMWARE,   qw(bin)),
  _f(LIBMTP_FILETYPE_AAC,        qw(aac)),
  _f(LIBMTP_FILETYPE_MEDIACARD,  qw()),
  _f(LIBMTP_FILETYPE_FLAC,       qw(flac fla audio/flac)),
  _f(LIBMTP_FILETYPE_MP2,        qw(mp2)),
  _f(LIBMTP_FILETYPE_M4A,        qw(m4a)),
  _f(LIBMTP_FILETYPE_DOC,        qw(doc application/msword)),
  _f(LIBMTP_FILETYPE_XML,        qw(xml text/xml)),
  _f(LIBMTP_FILETYPE_XLS,        qw(xls application/vnd.ms-excel)),
  _f(LIBMTP_FILETYPE_PPT,        qw(ppt application/vnd.ms-powerpoint)),
  _f(LIBMTP_FILETYPE_MHT,        qw(mht)),
  _f(LIBMTP_FILETYPE_JP2,        qw(jp2)),
  _f(LIBMTP_FILETYPE_JPX,        qw(jpx)),
);

sub filetype
{
  my $name = shift;

  $typemap{ lc $name };
} # end filetype

#=====================================================================
# Package Return Value:

1;

__END__
