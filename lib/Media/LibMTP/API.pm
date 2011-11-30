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

{
  package Media::LibMTP::API::AlbumList;
  our @ISA = ('Media::LibMTP::API::Album');
}
{
  package Media::LibMTP::API::FolderList;
  our @ISA = ('Media::LibMTP::API::Folder');
}

require XSLoader;
XSLoader::load('Media::LibMTP::API', $VERSION);

Init();

1;
__END__

=head1 SYNOPSIS

  use Media::LibMTP::API;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Media::LibMTP::API, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head2 Exportable constants

  DEBUG_ALL
  DEBUG_DATA
  DEBUG_NONE
  DEBUG_PLST
  DEBUG_PTP
  DEBUG_USB
  HANDLER_RETURN_CANCEL
  HANDLER_RETURN_ERROR
  HANDLER_RETURN_OK
  LIBMTP_DATATYPE_INT16
  LIBMTP_DATATYPE_INT32
  LIBMTP_DATATYPE_INT64
  LIBMTP_DATATYPE_INT8
  LIBMTP_DATATYPE_UINT16
  LIBMTP_DATATYPE_UINT32
  LIBMTP_DATATYPE_UINT64
  LIBMTP_DATATYPE_UINT8
  LIBMTP_ERROR_CANCELLED
  LIBMTP_ERROR_CONNECTING
  LIBMTP_ERROR_GENERAL
  LIBMTP_ERROR_MEMORY_ALLOCATION
  LIBMTP_ERROR_NONE
  LIBMTP_ERROR_NO_DEVICE_ATTACHED
  LIBMTP_ERROR_PTP_LAYER
  LIBMTP_ERROR_STORAGE_FULL
  LIBMTP_ERROR_USB_LAYER
  LIBMTP_EVENT_NONE
  LIBMTP_FILETYPE_AAC
  LIBMTP_FILETYPE_ALBUM
  LIBMTP_FILETYPE_ASF
  LIBMTP_FILETYPE_AUDIBLE
  LIBMTP_FILETYPE_AVI
  LIBMTP_FILETYPE_BMP
  LIBMTP_FILETYPE_DOC
  LIBMTP_FILETYPE_FIRMWARE
  LIBMTP_FILETYPE_FLAC
  LIBMTP_FILETYPE_FOLDER
  LIBMTP_FILETYPE_GIF
  LIBMTP_FILETYPE_HTML
  LIBMTP_FILETYPE_JFIF
  LIBMTP_FILETYPE_JP2
  LIBMTP_FILETYPE_JPEG
  LIBMTP_FILETYPE_JPX
  LIBMTP_FILETYPE_M4A
  LIBMTP_FILETYPE_MEDIACARD
  LIBMTP_FILETYPE_MHT
  LIBMTP_FILETYPE_MP2
  LIBMTP_FILETYPE_MP3
  LIBMTP_FILETYPE_MP4
  LIBMTP_FILETYPE_MPEG
  LIBMTP_FILETYPE_OGG
  LIBMTP_FILETYPE_PICT
  LIBMTP_FILETYPE_PLAYLIST
  LIBMTP_FILETYPE_PNG
  LIBMTP_FILETYPE_PPT
  LIBMTP_FILETYPE_QT
  LIBMTP_FILETYPE_TEXT
  LIBMTP_FILETYPE_TIFF
  LIBMTP_FILETYPE_UNDEF_AUDIO
  LIBMTP_FILETYPE_UNDEF_VIDEO
  LIBMTP_FILETYPE_UNKNOWN
  LIBMTP_FILETYPE_VCALENDAR1
  LIBMTP_FILETYPE_VCALENDAR2
  LIBMTP_FILETYPE_VCARD2
  LIBMTP_FILETYPE_VCARD3
  LIBMTP_FILETYPE_WAV
  LIBMTP_FILETYPE_WINDOWSIMAGEFORMAT
  LIBMTP_FILETYPE_WINEXEC
  LIBMTP_FILETYPE_WMA
  LIBMTP_FILETYPE_WMV
  LIBMTP_FILETYPE_XLS
  LIBMTP_FILETYPE_XML
  LIBMTP_PROPERTY_ActivityAccepted
  LIBMTP_PROPERTY_ActivityBeginTime
  LIBMTP_PROPERTY_ActivityEndTime
  LIBMTP_PROPERTY_ActivityLocation
  LIBMTP_PROPERTY_ActivityOptionalAttendees
  LIBMTP_PROPERTY_ActivityRequiredAttendees
  LIBMTP_PROPERTY_ActivityResources
  LIBMTP_PROPERTY_AlbumArtist
  LIBMTP_PROPERTY_AlbumName
  LIBMTP_PROPERTY_AllowedFolderContents
  LIBMTP_PROPERTY_Artist
  LIBMTP_PROPERTY_AssociationDesc
  LIBMTP_PROPERTY_AssociationType
  LIBMTP_PROPERTY_AudioBitDepth
  LIBMTP_PROPERTY_AudioBitRate
  LIBMTP_PROPERTY_AudioWAVECodec
  LIBMTP_PROPERTY_Birthdate
  LIBMTP_PROPERTY_BitRateType
  LIBMTP_PROPERTY_BodyText
  LIBMTP_PROPERTY_BufferSize
  LIBMTP_PROPERTY_BusinessWebAddress
  LIBMTP_PROPERTY_BuyFlag
  LIBMTP_PROPERTY_ByteBookmark
  LIBMTP_PROPERTY_Composer
  LIBMTP_PROPERTY_CopyrightInformation
  LIBMTP_PROPERTY_CorruptOrUnplayable
  LIBMTP_PROPERTY_CreatedBy
  LIBMTP_PROPERTY_Credits
  LIBMTP_PROPERTY_DRMStatus
  LIBMTP_PROPERTY_DateAdded
  LIBMTP_PROPERTY_DateAuthored
  LIBMTP_PROPERTY_DateCreated
  LIBMTP_PROPERTY_DateModified
  LIBMTP_PROPERTY_Description
  LIBMTP_PROPERTY_DisplayName
  LIBMTP_PROPERTY_Duration
  LIBMTP_PROPERTY_Editor
  LIBMTP_PROPERTY_EffectiveRating
  LIBMTP_PROPERTY_EmailBusiness1
  LIBMTP_PROPERTY_EmailBusiness2
  LIBMTP_PROPERTY_EmailOthers
  LIBMTP_PROPERTY_EmailPersonal1
  LIBMTP_PROPERTY_EmailPersonal2
  LIBMTP_PROPERTY_EmailPrimary
  LIBMTP_PROPERTY_EncodingProfile
  LIBMTP_PROPERTY_EncodingQuality
  LIBMTP_PROPERTY_ExposureIndex
  LIBMTP_PROPERTY_ExposureTime
  LIBMTP_PROPERTY_FamilyName
  LIBMTP_PROPERTY_FaxNumberBusiness
  LIBMTP_PROPERTY_FaxNumberPersonal
  LIBMTP_PROPERTY_FaxNumberPrimary
  LIBMTP_PROPERTY_Fnumber
  LIBMTP_PROPERTY_FramesPerThousandSeconds
  LIBMTP_PROPERTY_Genre
  LIBMTP_PROPERTY_GivenName
  LIBMTP_PROPERTY_Height
  LIBMTP_PROPERTY_Hidden
  LIBMTP_PROPERTY_ImageBitDepth
  LIBMTP_PROPERTY_InstantMessengerAddress
  LIBMTP_PROPERTY_InstantMessengerAddress2
  LIBMTP_PROPERTY_InstantMessengerAddress3
  LIBMTP_PROPERTY_IsColorCorrected
  LIBMTP_PROPERTY_IsCropped
  LIBMTP_PROPERTY_KeyFrameDistance
  LIBMTP_PROPERTY_Keywords
  LIBMTP_PROPERTY_LanguageLocale
  LIBMTP_PROPERTY_LastAccessed
  LIBMTP_PROPERTY_LastBuildDate
  LIBMTP_PROPERTY_Lyrics
  LIBMTP_PROPERTY_MediaGUID
  LIBMTP_PROPERTY_MessageBCC
  LIBMTP_PROPERTY_MessageCC
  LIBMTP_PROPERTY_MessageRead
  LIBMTP_PROPERTY_MessageReceivedTime
  LIBMTP_PROPERTY_MessageSender
  LIBMTP_PROPERTY_MessageTo
  LIBMTP_PROPERTY_MetaGenre
  LIBMTP_PROPERTY_MiddleNames
  LIBMTP_PROPERTY_Mood
  LIBMTP_PROPERTY_Name
  LIBMTP_PROPERTY_NonConsumable
  LIBMTP_PROPERTY_NumberOfChannels
  LIBMTP_PROPERTY_ObjectBookmark
  LIBMTP_PROPERTY_ObjectFileName
  LIBMTP_PROPERTY_ObjectFormat
  LIBMTP_PROPERTY_ObjectSize
  LIBMTP_PROPERTY_OrganizationName
  LIBMTP_PROPERTY_OriginLocation
  LIBMTP_PROPERTY_OriginalReleaseDate
  LIBMTP_PROPERTY_Owner
  LIBMTP_PROPERTY_PagerNumber
  LIBMTP_PROPERTY_ParentObject
  LIBMTP_PROPERTY_ParentalRating
  LIBMTP_PROPERTY_PersistantUniqueObjectIdentifier
  LIBMTP_PROPERTY_PersonalWebAddress
  LIBMTP_PROPERTY_PhoneNumberBusiness
  LIBMTP_PROPERTY_PhoneNumberBusiness2
  LIBMTP_PROPERTY_PhoneNumberMobile
  LIBMTP_PROPERTY_PhoneNumberMobile2
  LIBMTP_PROPERTY_PhoneNumberOthers
  LIBMTP_PROPERTY_PhoneNumberPersonal
  LIBMTP_PROPERTY_PhoneNumberPersonal2
  LIBMTP_PROPERTY_PhoneNumberPrimary
  LIBMTP_PROPERTY_PhoneticFamilyName
  LIBMTP_PROPERTY_PhoneticGivenName
  LIBMTP_PROPERTY_PhoneticOrganizationName
  LIBMTP_PROPERTY_PostalAddressBusinessCity
  LIBMTP_PROPERTY_PostalAddressBusinessCountry
  LIBMTP_PROPERTY_PostalAddressBusinessFull
  LIBMTP_PROPERTY_PostalAddressBusinessLine1
  LIBMTP_PROPERTY_PostalAddressBusinessLine2
  LIBMTP_PROPERTY_PostalAddressBusinessPostalCode
  LIBMTP_PROPERTY_PostalAddressBusinessRegion
  LIBMTP_PROPERTY_PostalAddressOtherCity
  LIBMTP_PROPERTY_PostalAddressOtherCountry
  LIBMTP_PROPERTY_PostalAddressOtherFull
  LIBMTP_PROPERTY_PostalAddressOtherLine1
  LIBMTP_PROPERTY_PostalAddressOtherLine2
  LIBMTP_PROPERTY_PostalAddressOtherPostalCode
  LIBMTP_PROPERTY_PostalAddressOtherRegion
  LIBMTP_PROPERTY_PostalAddressPersonalFull
  LIBMTP_PROPERTY_PostalAddressPersonalFullCity
  LIBMTP_PROPERTY_PostalAddressPersonalFullCountry
  LIBMTP_PROPERTY_PostalAddressPersonalFullLine1
  LIBMTP_PROPERTY_PostalAddressPersonalFullLine2
  LIBMTP_PROPERTY_PostalAddressPersonalFullPostalCode
  LIBMTP_PROPERTY_PostalAddressPersonalFullRegion
  LIBMTP_PROPERTY_Prefix
  LIBMTP_PROPERTY_PrimaryWebAddress
  LIBMTP_PROPERTY_Priority
  LIBMTP_PROPERTY_ProducedBy
  LIBMTP_PROPERTY_ProducerSerialNumber
  LIBMTP_PROPERTY_PropertyBag
  LIBMTP_PROPERTY_ProtectionStatus
  LIBMTP_PROPERTY_Rating
  LIBMTP_PROPERTY_RepresentativeSampleData
  LIBMTP_PROPERTY_RepresentativeSampleDuration
  LIBMTP_PROPERTY_RepresentativeSampleFormat
  LIBMTP_PROPERTY_RepresentativeSampleHeight
  LIBMTP_PROPERTY_RepresentativeSampleSize
  LIBMTP_PROPERTY_RepresentativeSampleWidth
  LIBMTP_PROPERTY_Role
  LIBMTP_PROPERTY_SampleRate
  LIBMTP_PROPERTY_ScanDepth
  LIBMTP_PROPERTY_SkipCount
  LIBMTP_PROPERTY_Source
  LIBMTP_PROPERTY_StorageID
  LIBMTP_PROPERTY_SubDescription
  LIBMTP_PROPERTY_Subject
  LIBMTP_PROPERTY_SubscriptionContentID
  LIBMTP_PROPERTY_Subtitle
  LIBMTP_PROPERTY_Suffix
  LIBMTP_PROPERTY_SyncID
  LIBMTP_PROPERTY_SystemObject
  LIBMTP_PROPERTY_TimeBookmark
  LIBMTP_PROPERTY_TimetoLive
  LIBMTP_PROPERTY_TotalBitRate
  LIBMTP_PROPERTY_Track
  LIBMTP_PROPERTY_UNKNOWN
  LIBMTP_PROPERTY_URLDestination
  LIBMTP_PROPERTY_URLReference
  LIBMTP_PROPERTY_URLSource
  LIBMTP_PROPERTY_UseCount
  LIBMTP_PROPERTY_VideoBitRate
  LIBMTP_PROPERTY_VideoFourCCCodec
  LIBMTP_PROPERTY_Webmaster
  LIBMTP_PROPERTY_Width
  MTPDataGetFunc
  MTPDataPutFunc
  STORAGE_SORTBY_FREESPACE
  STORAGE_SORTBY_MAXSPACE
  STORAGE_SORTBY_NOTSORTED
  VERSION
  progressfunc_t
  snprintf
  ssize_t

=head2 Exportable functions

  int LIBMTP_Check_Specific_Device(int busno, int devno)
  void LIBMTP_Clear_Errorstack(LIBMTP_mtpdevice_t*)
  uint32_t LIBMTP_Create_Folder(LIBMTP_mtpdevice_t*, char *, uint32_t, uint32_t)
  int LIBMTP_Create_New_Album(LIBMTP_mtpdevice_t *, LIBMTP_album_t * const)
  int LIBMTP_Create_New_Playlist(LIBMTP_mtpdevice_t *, LIBMTP_playlist_t * const)
  int LIBMTP_Delete_Object(LIBMTP_mtpdevice_t *, uint32_t)
  LIBMTP_error_number_t LIBMTP_Detect_Raw_Devices(LIBMTP_raw_device_t **, int *)
  void LIBMTP_Dump_Device_Info(LIBMTP_mtpdevice_t*)
  void LIBMTP_Dump_Errorstack(LIBMTP_mtpdevice_t*)
  LIBMTP_folder_t *LIBMTP_Find_Folder(LIBMTP_folder_t*, uint32_t const)
  int LIBMTP_Format_Storage(LIBMTP_mtpdevice_t *, LIBMTP_devicestorage_t *)
  LIBMTP_album_t *LIBMTP_Get_Album(LIBMTP_mtpdevice_t *, uint32_t const)
  LIBMTP_album_t *LIBMTP_Get_Album_List(LIBMTP_mtpdevice_t *)
  LIBMTP_album_t *LIBMTP_Get_Album_List_For_Storage(LIBMTP_mtpdevice_t *, uint32_t const)
  int LIBMTP_Get_Allowed_Property_Values(LIBMTP_mtpdevice_t*, LIBMTP_property_t const,
            LIBMTP_filetype_t const, LIBMTP_allowed_values_t*)
  int LIBMTP_Get_Batterylevel(LIBMTP_mtpdevice_t *,
       uint8_t * const,
       uint8_t * const)
  LIBMTP_error_number_t LIBMTP_Get_Connected_Devices(LIBMTP_mtpdevice_t **)
  int LIBMTP_Get_Device_Certificate(LIBMTP_mtpdevice_t *, char ** const)
  char *LIBMTP_Get_Deviceversion(LIBMTP_mtpdevice_t*)
  LIBMTP_error_t *LIBMTP_Get_Errorstack(LIBMTP_mtpdevice_t*)
  int LIBMTP_Get_File_To_File(LIBMTP_mtpdevice_t*, uint32_t, char const * const,
   void* const, void const * const)
  int LIBMTP_Get_File_To_File_Descriptor(LIBMTP_mtpdevice_t*,
           uint32_t const,
           int const,
           void* const,
           void const * const)
  int LIBMTP_Get_File_To_Handler(LIBMTP_mtpdevice_t *,
          uint32_t const,
          void*,
          void *,
          void* const,
          void const * const)
  LIBMTP_file_t *LIBMTP_Get_Filelisting(LIBMTP_mtpdevice_t *)
  LIBMTP_file_t *LIBMTP_Get_Filelisting_With_Callback(LIBMTP_mtpdevice_t *,
      void* const, void const * const)
  LIBMTP_file_t *LIBMTP_Get_Filemetadata(LIBMTP_mtpdevice_t *, uint32_t const)
  LIBMTP_file_t * LIBMTP_Get_Files_And_Folders(LIBMTP_mtpdevice_t *,
          uint32_t const,
          uint32_t const)
  char const * LIBMTP_Get_Filetype_Description(LIBMTP_filetype_t)
  LIBMTP_mtpdevice_t *LIBMTP_Get_First_Device(void)
  LIBMTP_folder_t *LIBMTP_Get_Folder_List(LIBMTP_mtpdevice_t*)
  LIBMTP_folder_t *LIBMTP_Get_Folder_List_For_Storage(LIBMTP_mtpdevice_t*,
          uint32_t const)
  char *LIBMTP_Get_Friendlyname(LIBMTP_mtpdevice_t*)
  char *LIBMTP_Get_Manufacturername(LIBMTP_mtpdevice_t*)
  char *LIBMTP_Get_Modelname(LIBMTP_mtpdevice_t*)
  LIBMTP_playlist_t *LIBMTP_Get_Playlist(LIBMTP_mtpdevice_t *, uint32_t const)
  LIBMTP_playlist_t *LIBMTP_Get_Playlist_List(LIBMTP_mtpdevice_t *)
  char const * LIBMTP_Get_Property_Description(LIBMTP_property_t inproperty)
  int LIBMTP_Get_Representative_Sample(LIBMTP_mtpdevice_t *, uint32_t const,
                          LIBMTP_filesampledata_t *)
  int LIBMTP_Get_Representative_Sample_Format(LIBMTP_mtpdevice_t *,
                        LIBMTP_filetype_t const,
                        LIBMTP_filesampledata_t **)
  int LIBMTP_Get_Secure_Time(LIBMTP_mtpdevice_t *, char ** const)
  char *LIBMTP_Get_Serialnumber(LIBMTP_mtpdevice_t*)
  int LIBMTP_Get_Storage(LIBMTP_mtpdevice_t *, int const)
  char *LIBMTP_Get_String_From_Object(LIBMTP_mtpdevice_t *, uint32_t const, LIBMTP_property_t const)
  int LIBMTP_Get_Supported_Devices_List(LIBMTP_device_entry_t ** const, int * const)
  int LIBMTP_Get_Supported_Filetypes(LIBMTP_mtpdevice_t *, uint16_t ** const, uint16_t * const)
  char *LIBMTP_Get_Syncpartner(LIBMTP_mtpdevice_t*)
  int LIBMTP_Get_Track_To_File(LIBMTP_mtpdevice_t*, uint32_t, char const * const,
   void* const, void const * const)
  int LIBMTP_Get_Track_To_File_Descriptor(LIBMTP_mtpdevice_t*, uint32_t const, int const,
   void* const, void const * const)
  int LIBMTP_Get_Track_To_Handler(LIBMTP_mtpdevice_t *, uint32_t const, void*,
      void *, void* const, void const * const)
  LIBMTP_track_t *LIBMTP_Get_Tracklisting(LIBMTP_mtpdevice_t*)
  LIBMTP_track_t *LIBMTP_Get_Tracklisting_With_Callback(LIBMTP_mtpdevice_t*,
      void* const, void const * const)
  LIBMTP_track_t *LIBMTP_Get_Tracklisting_With_Callback_For_Storage(LIBMTP_mtpdevice_t*, uint32_t const,
      void* const, void const * const)
  LIBMTP_track_t *LIBMTP_Get_Trackmetadata(LIBMTP_mtpdevice_t*, uint32_t const)
  uint16_t LIBMTP_Get_u16_From_Object(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint16_t const)
  uint32_t LIBMTP_Get_u32_From_Object(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint32_t const)
  uint64_t LIBMTP_Get_u64_From_Object(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint64_t const)
  uint8_t LIBMTP_Get_u8_From_Object(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint8_t const)
  void LIBMTP_Init(void)
  int LIBMTP_Is_Property_Supported(LIBMTP_mtpdevice_t*, LIBMTP_property_t const,
            LIBMTP_filetype_t const)
  uint32_t LIBMTP_Number_Devices_In_List(LIBMTP_mtpdevice_t *)
  LIBMTP_mtpdevice_t *LIBMTP_Open_Raw_Device(LIBMTP_raw_device_t *)
  LIBMTP_mtpdevice_t *LIBMTP_Open_Raw_Device_Uncached(LIBMTP_raw_device_t *)
  int LIBMTP_Read_Event(LIBMTP_mtpdevice_t *, LIBMTP_event_t *)
  void LIBMTP_Release_Device(LIBMTP_mtpdevice_t*)
  void LIBMTP_Release_Device_List(LIBMTP_mtpdevice_t*)
  int LIBMTP_Reset_Device(LIBMTP_mtpdevice_t*)
  int LIBMTP_Send_File_From_File(LIBMTP_mtpdevice_t *,
          char const * const,
          LIBMTP_file_t * const,
          void* const,
          void const * const)
  int LIBMTP_Send_File_From_File_Descriptor(LIBMTP_mtpdevice_t *,
       int const,
       LIBMTP_file_t * const,
       void* const,
       void const * const)
  int LIBMTP_Send_File_From_Handler(LIBMTP_mtpdevice_t *,
      void*, void *,
      LIBMTP_file_t * const,
      void* const,
      void const * const)
  int LIBMTP_Send_Representative_Sample(LIBMTP_mtpdevice_t *, uint32_t const,
                          LIBMTP_filesampledata_t *)
  int LIBMTP_Send_Track_From_File(LIBMTP_mtpdevice_t *,
    char const * const, LIBMTP_track_t * const,
                         void* const,
    void const * const)
  int LIBMTP_Send_Track_From_File_Descriptor(LIBMTP_mtpdevice_t *,
    int const, LIBMTP_track_t * const,
                         void* const,
    void const * const)
  int LIBMTP_Send_Track_From_Handler(LIBMTP_mtpdevice_t *,
    void*, void *, LIBMTP_track_t * const,
                         void* const,
    void const * const)
  int LIBMTP_Set_Album_Name(LIBMTP_mtpdevice_t *, LIBMTP_album_t *, const char *)
  void LIBMTP_Set_Debug(int)
  int LIBMTP_Set_File_Name(LIBMTP_mtpdevice_t *,
    LIBMTP_file_t *,
    const char *)
  int LIBMTP_Set_Folder_Name(LIBMTP_mtpdevice_t *, LIBMTP_folder_t *, const char *)
  int LIBMTP_Set_Friendlyname(LIBMTP_mtpdevice_t*, char const * const)
  int LIBMTP_Set_Object_Filename(LIBMTP_mtpdevice_t *, uint32_t , char *)
  int LIBMTP_Set_Object_String(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, char const * const)
  int LIBMTP_Set_Object_u16(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint16_t const)
  int LIBMTP_Set_Object_u32(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint32_t const)
  int LIBMTP_Set_Object_u8(LIBMTP_mtpdevice_t *, uint32_t const,
      LIBMTP_property_t const, uint8_t const)
  int LIBMTP_Set_Playlist_Name(LIBMTP_mtpdevice_t *, LIBMTP_playlist_t *, const char *)
  int LIBMTP_Set_Syncpartner(LIBMTP_mtpdevice_t*, char const * const)
  int LIBMTP_Set_Track_Name(LIBMTP_mtpdevice_t *, LIBMTP_track_t *, const char *)
  int LIBMTP_Track_Exists(LIBMTP_mtpdevice_t *, uint32_t const)
  int LIBMTP_Update_Album(LIBMTP_mtpdevice_t *, LIBMTP_album_t const * const)
  int LIBMTP_Update_Playlist(LIBMTP_mtpdevice_t *, LIBMTP_playlist_t * const)
  int LIBMTP_Update_Track_Metadata(LIBMTP_mtpdevice_t *,
   LIBMTP_track_t const * const)
  void LIBMTP_destroy_album_t(LIBMTP_album_t *)
  void LIBMTP_destroy_allowed_values_t(LIBMTP_allowed_values_t*)
  void LIBMTP_destroy_file_t(LIBMTP_file_t*)
  void LIBMTP_destroy_filesampledata_t(LIBMTP_filesampledata_t *)
  void LIBMTP_destroy_folder_t(LIBMTP_folder_t*)
  void LIBMTP_destroy_playlist_t(LIBMTP_playlist_t *)
  void LIBMTP_destroy_track_t(LIBMTP_track_t*)
  LIBMTP_album_t *LIBMTP_new_album_t(void)
  LIBMTP_file_t *LIBMTP_new_file_t(void)
  LIBMTP_filesampledata_t *LIBMTP_new_filesampledata_t(void)
  LIBMTP_folder_t *LIBMTP_new_folder_t(void)
  LIBMTP_playlist_t *LIBMTP_new_playlist_t(void)
  LIBMTP_track_t *LIBMTP_new_track_t(void)



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Christopher J. Madsen, E<lt>cjm@(none)E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Christopher J. Madsen

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
