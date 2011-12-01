#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <libmtp.h>

typedef LIBMTP_album_t *           MLA_Album;
typedef LIBMTP_album_t *           MLA_AlbumList;   /* needs DESTROY */
typedef LIBMTP_allowed_values_t *  MLA_AllowedValues;
typedef LIBMTP_file_t *            MLA_File;
typedef LIBMTP_file_t *            MLA_FileList;    /* needs DESTROY */
typedef LIBMTP_filesampledata_t *  MLA_FileSampleData;
typedef LIBMTP_error_t *           MLA_Error;
typedef LIBMTP_folder_t *          MLA_Folder;
typedef LIBMTP_folder_t *          MLA_FolderList;  /* needs DESTROY */
typedef LIBMTP_mtpdevice_t *       MLA_MTPDevice;
typedef LIBMTP_playlist_t *        MLA_Playlist;
typedef LIBMTP_playlist_t *        MLA_PlaylistList;/* needs DESTROY */
typedef LIBMTP_raw_device_t *      MLA_RawDevice;
typedef LIBMTP_track_t *           MLA_Track;
typedef LIBMTP_track_t *           MLA_TrackList;   /* needs DESTROY */

typedef const char *               Utf8StringConst;
typedef char *                     Utf8String;
typedef char *                     Utf8String2Free;

#include "const-c.inc"

MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API  PREFIX = LIBMTP_

INCLUDE: const-xs.inc

int
LIBMTP_Check_Specific_Device(busno, devno)
	int	busno
	int	devno

#// FIXME
#// LIBMTP_error_number_t
#// LIBMTP_Detect_Raw_Devices(arg0, arg1)
#// 	LIBMTP_raw_device_t **	arg0
#// 	int *	arg1

#//FIXME use AV* ???
#//  LIBMTP_error_number_t
#//  LIBMTP_Get_Connected_Devices(arg0)
#//  	MLA_MTPDevice *		arg0
#//

Utf8StringConst
LIBMTP_Get_Filetype_Description(arg0)
	LIBMTP_filetype_t	arg0

MLA_MTPDevice
LIBMTP_Get_First_Device()

Utf8StringConst
LIBMTP_Get_Property_Description(inproperty)
	LIBMTP_property_t	inproperty

#// FIXME
#// int
#// LIBMTP_Get_Supported_Devices_List(arg0, arg1)
#// 	LIBMTP_device_entry_t **	arg0
#// 	int *	arg1

void
LIBMTP_Init()

MLA_MTPDevice
LIBMTP_Open_Raw_Device(arg0)
	MLA_RawDevice	arg0

MLA_MTPDevice
LIBMTP_Open_Raw_Device_Uncached(arg0)
	MLA_RawDevice	arg0

void
LIBMTP_Set_Debug(arg0)
	int	arg0


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Album

MLA_AlbumList
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_album_t();
   OUTPUT:
	RETVAL

uint32_t
album_id(self, newValue = NO_INIT)
	MLA_Album	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->album_id = newValue;
	RETVAL = self->album_id;
   OUTPUT:
	RETVAL

uint32_t
parent_id(self, newValue = NO_INIT)
	MLA_Album	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->parent_id = newValue;
	RETVAL = self->parent_id;
   OUTPUT:
	RETVAL

uint32_t
storage_id(self, newValue = NO_INIT)
	MLA_Album	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->storage_id = newValue;
	RETVAL = self->storage_id;
   OUTPUT:
	RETVAL

Utf8String
name(self, newValue = NO_INIT)
	MLA_Album	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->name = strdup(newValue);
	RETVAL = self->name;
   OUTPUT:
	RETVAL

Utf8String
artist(self, newValue = NO_INIT)
	MLA_Album	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->artist = strdup(newValue);
	RETVAL = self->artist;
   OUTPUT:
	RETVAL

Utf8String
composer(self, newValue = NO_INIT)
	MLA_Album	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->composer = strdup(newValue);
	RETVAL = self->composer;
   OUTPUT:
	RETVAL

Utf8String
genre(self, newValue = NO_INIT)
	MLA_Album	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->genre = strdup(newValue);
	RETVAL = self->genre;
   OUTPUT:
	RETVAL

AV *
tracks(self, newValue = NO_INIT)
	MLA_Album	self
	AV *		newValue
   PREINIT:
	I32		i;
   CODE:
        if (items > 1) {
          if (self->tracks) Safefree(self->tracks);
          i = av_len(newValue);
          self->no_tracks = i + 1;
          Newx(self->tracks, self->no_tracks, uint32_t);
          for (; i >= 0; --i) {
            self->tracks[i] =
              SvUV(*av_fetch(newValue, i, 0));
          }
        }
	RETVAL = newAV();
	sv_2mortal((SV*)RETVAL);
	av_extend(RETVAL, self->no_tracks - 1);
        for (i = 0; i < self->no_tracks; ++i) {
          av_store(RETVAL, i, newSVuv(self->tracks[i]));
        }
   OUTPUT:
	RETVAL

uint32_t
no_tracks(self)
	MLA_Album	self
   CODE:
	RETVAL = self->no_tracks;
   OUTPUT:
	RETVAL

MLA_Album
next(self)
	MLA_Album	self
   CODE:
	RETVAL = self->next;
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::AlbumList

void
DESTROY(self)
	MLA_Album	self
   CODE:
	LIBMTP_destroy_album_t(self);


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::AllowedValues

void
DESTROY(self)
	MLA_AllowedValues	self
   CODE:
	LIBMTP_destroy_allowed_values_t(self);


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::MTPDevice

void
DESTROY(self)
	MLA_MTPDevice	self
   CODE:
	LIBMTP_Release_Device_List(self);

MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::MTPDevice  PREFIX = LIBMTP_

void
LIBMTP_Clear_Errorstack(self)
	MLA_MTPDevice	self

uint32_t
LIBMTP_Create_Folder(self, arg1, arg2, arg3)
	MLA_MTPDevice	self
	Utf8String	arg1
	uint32_t	arg2
	uint32_t	arg3

int
LIBMTP_Create_New_Album(self, arg1)
	MLA_MTPDevice	self
	MLA_Album	arg1

int
LIBMTP_Create_New_Playlist(self, arg1)
	MLA_MTPDevice	self
	MLA_Playlist	arg1

int
LIBMTP_Delete_Object(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

void
LIBMTP_Dump_Device_Info(self)
	MLA_MTPDevice	self

void
LIBMTP_Dump_Errorstack(self)
	MLA_MTPDevice	self

#// FIXME
#// int
#// LIBMTP_Format_Storage(self, arg1)
#// 	MLA_MTPDevice		self
#// 	LIBMTP_devicestorage_t *	arg1

MLA_AlbumList
LIBMTP_Get_Album(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

MLA_AlbumList
LIBMTP_Get_Album_List(self)
	MLA_MTPDevice	self

MLA_AlbumList
LIBMTP_Get_Album_List_For_Storage(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

int
LIBMTP_Get_Allowed_Property_Values(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	LIBMTP_property_t	arg1
	LIBMTP_filetype_t	arg2
	MLA_AllowedValues	arg3

#//FIXME return list
#// int
#// LIBMTP_Get_Batterylevel(self, arg1, arg2)
#// 	MLA_MTPDevice	self
#// 	uint8_t *	arg1
#// 	uint8_t *	arg2

#// FIXME
#// int
#// LIBMTP_Get_Device_Certificate(self, arg1)
#// 	MLA_MTPDevice		self
#// 	char **	arg1

Utf8String2Free
LIBMTP_Get_Deviceversion(self)
	MLA_MTPDevice	self

MLA_Error
LIBMTP_Get_Errorstack(self)
	MLA_MTPDevice	self

#// FIXME
#// int
#// LIBMTP_Get_File_To_File(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	char const *	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_File_To_File_Descriptor(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	int		arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_File_To_Handler(self, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	void *		arg2
#// 	void *		arg3
#// 	void *		arg4
#// 	void const *	arg5

#//FIXME
#// MLA_File
#// LIBMTP_Get_Filelisting_With_Callback(self, arg1, arg2)
#// 	MLA_MTPDevice	self
#// 	void *		arg1
#// 	void const *	arg2

MLA_FileList
LIBMTP_Get_Filemetadata(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

MLA_FileList
LIBMTP_Get_Files_And_Folders(self, arg1, arg2)
	MLA_MTPDevice	self
	uint32_t	arg1
	uint32_t	arg2

MLA_FolderList
LIBMTP_Get_Folder_List(self)
	MLA_MTPDevice	self

MLA_FolderList
LIBMTP_Get_Folder_List_For_Storage(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

Utf8String2Free
LIBMTP_Get_Friendlyname(self)
	MLA_MTPDevice	self

Utf8String2Free
LIBMTP_Get_Manufacturername(self)
	MLA_MTPDevice	self

Utf8String2Free
LIBMTP_Get_Modelname(self)
	MLA_MTPDevice	self

MLA_PlaylistList
LIBMTP_Get_Playlist(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

MLA_PlaylistList
LIBMTP_Get_Playlist_List(self)
	MLA_MTPDevice	self

int
LIBMTP_Get_Representative_Sample(self, object_id, data)
	MLA_MTPDevice		self
	uint32_t		object_id
	MLA_FileSampleData	data

#// FIXME
#// int
#// LIBMTP_Get_Representative_Sample_Format(self, arg1, arg2)
#// 	MLA_MTPDevice		self
#// 	LIBMTP_filetype_t	arg1
#// 	MLA_FileSampleData*	arg2

#// FIXME
#// int
#// LIBMTP_Get_Secure_Time(self, arg1)
#// 	MLA_MTPDevice		self
#// 	char **	arg1

Utf8String2Free
LIBMTP_Get_Serialnumber(self)
	MLA_MTPDevice	self

int
LIBMTP_Get_Storage(self, arg1)
	MLA_MTPDevice	self
	int		arg1

Utf8String2Free
LIBMTP_Get_String_From_Object(self, arg1, arg2)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2

#// FIXME
#// int
#// LIBMTP_Get_Supported_Filetypes(self, arg1, arg2)
#// 	MLA_MTPDevice		self
#// 	uint16_t **	arg1
#// 	uint16_t *	arg2

Utf8String2Free
LIBMTP_Get_Syncpartner(self)
	MLA_MTPDevice	self

#// FIXME
#// int
#// LIBMTP_Get_Track_To_File(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	char const *	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_Track_To_File_Descriptor(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	int		arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_Track_To_Handler(self, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	void *		arg2
#// 	void *		arg3
#// 	void *		arg4
#// 	void const *	arg5

MLA_TrackList
LIBMTP_Get_Tracklisting(self)
	MLA_MTPDevice	self
   CODE:
	RETVAL = LIBMTP_Get_Tracklisting_With_Callback(self, NULL, NULL);
   OUTPUT:
	RETVAL

#// FIXME
#// MLA_Track
#// LIBMTP_Get_Tracklisting_With_Callback(self, arg1, arg2)
#// 	MLA_MTPDevice	self
#// 	void *		arg1
#// 	void const *	arg2
#//
#// MLA_Track
#// LIBMTP_Get_Tracklisting_With_Callback_For_Storage(self, arg1, arg2, arg3)
#// 	MLA_MTPDevice	self
#// 	uint32_t	arg1
#// 	void *		arg2
#// 	void const *	arg3

MLA_TrackList
LIBMTP_Get_Trackmetadata(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

uint16_t
LIBMTP_Get_u16_From_Object(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint16_t		arg3

uint32_t
LIBMTP_Get_u32_From_Object(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint32_t		arg3

uint64_t
LIBMTP_Get_u64_From_Object(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint64_t		arg3

uint8_t
LIBMTP_Get_u8_From_Object(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint8_t			arg3

int
LIBMTP_Is_Property_Supported(self, arg1, arg2)
	MLA_MTPDevice		self
	LIBMTP_property_t	arg1
	LIBMTP_filetype_t	arg2

uint32_t
LIBMTP_Number_Devices_In_List(self)
	MLA_MTPDevice	self

#// FIXME
#// int
#// LIBMTP_Read_Event(self, arg1)
#// 	MLA_MTPDevice		self
#// 	LIBMTP_event_t *	arg1

void
LIBMTP_Release_Device(self)
	MLA_MTPDevice	self

void
LIBMTP_Release_Device_List(self)
	MLA_MTPDevice	self

int
LIBMTP_Reset_Device(self)
	MLA_MTPDevice	self

#// FIXME
#// int
#// LIBMTP_Send_File_From_File(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	char const *	arg1
#// 	MLA_File	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_File_From_File_Descriptor(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	int		arg1
#// 	MLA_File	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_File_From_Handler(self, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	self
#// 	void *		arg1
#// 	void *		arg2
#// 	MLA_File	arg3
#// 	void *		arg4
#// 	void const *	arg5

int
LIBMTP_Send_Representative_Sample(self, arg1, arg2)
	MLA_MTPDevice		self
	uint32_t		arg1
	MLA_FileSampleData	arg2

#// FIXME implement callback
int
LIBMTP_Send_Track_From_File(device, path, metadata)
#//LIBMTP_Send_Track_From_File(device, path, metadata, callback, data)
	MLA_MTPDevice	device
	Utf8String	path
	MLA_Track	metadata
#//	void *		callback
#//	void const *	data
   CODE:
	RETVAL = LIBMTP_Send_Track_From_File(device, path, metadata, NULL, NULL);
   OUTPUT:
	RETVAL

#// FIXME
#// int
#// LIBMTP_Send_Track_From_File_Descriptor(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	int		arg1
#// 	MLA_Track	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_Track_From_Handler(self, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	self
#// 	void *		arg1
#// 	void *		arg2
#// 	MLA_Track	arg3
#// 	void *		arg4
#// 	void const *	arg5

int
LIBMTP_Set_Album_Name(self, arg1, arg2)
	MLA_MTPDevice	self
	MLA_Album	arg1
	Utf8String	arg2

int
LIBMTP_Set_File_Name(self, arg1, arg2)
	MLA_MTPDevice	self
	MLA_File	arg1
	Utf8String	arg2

int
LIBMTP_Set_Folder_Name(self, arg1, arg2)
	MLA_MTPDevice	self
	MLA_Folder	arg1
	Utf8String	arg2

int
LIBMTP_Set_Friendlyname(self, arg1)
	MLA_MTPDevice	self
	Utf8String	arg1

int
LIBMTP_Set_Object_String(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	Utf8String		arg3

int
LIBMTP_Set_Object_u16(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint16_t		arg3

int
LIBMTP_Set_Object_u32(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint32_t		arg3

int
LIBMTP_Set_Object_u8(self, arg1, arg2, arg3)
	MLA_MTPDevice		self
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint8_t			arg3

int
LIBMTP_Set_Playlist_Name(self, arg1, arg2)
	MLA_MTPDevice	self
	MLA_Playlist	arg1
	Utf8String	arg2

int
LIBMTP_Set_Syncpartner(self, arg1)
	MLA_MTPDevice	self
	Utf8String	arg1

int
LIBMTP_Set_Track_Name(self, arg1, arg2)
	MLA_MTPDevice	self
	MLA_Track	arg1
	Utf8String	arg2

int
LIBMTP_Track_Exists(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

int
LIBMTP_Update_Album(self, arg1)
	MLA_MTPDevice	self
	MLA_Album	arg1

int
LIBMTP_Update_Playlist(self, arg1)
	MLA_MTPDevice	self
	MLA_Playlist	arg1

int
LIBMTP_Update_Track_Metadata(self, arg1)
	MLA_MTPDevice	self
	MLA_Track	arg1


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Error

LIBMTP_error_number_t
errornumber(self)
	MLA_Error	self
   CODE:
	RETVAL = self->errornumber;
   OUTPUT:
	RETVAL

Utf8String
error_text(self)
	MLA_Error	self
   CODE:
	RETVAL = self->error_text;
   OUTPUT:
	RETVAL

MLA_Error
next(self)
	MLA_Error	self
   CODE:
	RETVAL = self->next;
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::File

MLA_FileList
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_file_t();
   OUTPUT:
	RETVAL

uint32_t
item_id(self, newValue = NO_INIT)
	MLA_File	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->item_id = newValue;
	RETVAL = self->item_id;
   OUTPUT:
	RETVAL

uint32_t
parent_id(self, newValue = NO_INIT)
	MLA_File	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->parent_id = newValue;
	RETVAL = self->parent_id;
   OUTPUT:
	RETVAL

uint32_t
storage_id(self, newValue = NO_INIT)
	MLA_File	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->storage_id = newValue;
	RETVAL = self->storage_id;
   OUTPUT:
	RETVAL

Utf8String
filename(self, newValue = NO_INIT)
	MLA_File	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->filename = strdup(newValue);
	RETVAL = self->filename;
   OUTPUT:
	RETVAL

uint64_t
filesize(self, newValue = NO_INIT)
	MLA_File	self
	uint64_t	newValue
   CODE:
	if (items > 1)
	  self->filesize = newValue;
	RETVAL = self->filesize;
   OUTPUT:
	RETVAL

time_t
modificationdate(self, newValue = NO_INIT)
	MLA_File	self
	time_t		newValue
   CODE:
	if (items > 1)
	  self->modificationdate = newValue;
	RETVAL = self->modificationdate;
   OUTPUT:
	RETVAL

LIBMTP_filetype_t
filetype(self, newValue = NO_INIT)
	MLA_File		self
	LIBMTP_filetype_t	newValue
   CODE:
	if (items > 1)
	  self->filetype = newValue;
	RETVAL = self->filetype;
   OUTPUT:
	RETVAL

MLA_File
next(self)
	MLA_File	self
   CODE:
	RETVAL = self->next;
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::FileList

void
DESTROY(self)
	MLA_File	self
   CODE:
	LIBMTP_destroy_file_t(self);


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::FileSampleData

void
DESTROY(self)
	MLA_FileSampleData	self
   CODE:
	LIBMTP_destroy_filesampledata_t(self);

MLA_FileSampleData
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_filesampledata_t();
   OUTPUT:
	RETVAL

uint32_t
width(self, newValue = NO_INIT)
	MLA_FileSampleData	self
	uint32_t		newValue
   CODE:
	if (items > 1)
	  self->width = newValue;
	RETVAL = self->width;
   OUTPUT:
	RETVAL

uint32_t
height(self, newValue = NO_INIT)
	MLA_FileSampleData	self
	uint32_t		newValue
   CODE:
	if (items > 1)
	  self->height = newValue;
	RETVAL = self->height;
   OUTPUT:
	RETVAL

uint32_t
duration(self, newValue = NO_INIT)
	MLA_FileSampleData	self
	uint32_t		newValue
   CODE:
	if (items > 1)
	  self->duration = newValue;
	RETVAL = self->duration;
   OUTPUT:
	RETVAL

LIBMTP_filetype_t
filetype(self, newValue = NO_INIT)
	MLA_FileSampleData	self
	LIBMTP_filetype_t	newValue
   CODE:
	if (items > 1)
	  self->filetype = newValue;
	RETVAL = self->filetype;
   OUTPUT:
	RETVAL

uint64_t
size(self)
	MLA_FileSampleData	self
   CODE:
	RETVAL = self->size;
   OUTPUT:
	RETVAL

SV *
data(self, newValue = NO_INIT)
	MLA_FileSampleData	self
	SV *			newValue
   PREINIT:
	char *	data;
        STRLEN  size;
   CODE:
	if (items > 1) {
	  if (self->data) Safefree(self->data);
	  data = SvPVbyte(newValue, size);
	  Newx(self->data, size, char);
	  Copy(data, self->data, size, char);
	  self->size = size;
	}
	RETVAL = newSVpvn(self->data, self->size);
	SvUTF8_off(RETVAL);
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Folder

MLA_FolderList
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_folder_t();
   OUTPUT:
	RETVAL

uint32_t
folder_id(self, newValue = NO_INIT)
	MLA_Folder	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->folder_id = newValue;
	RETVAL = self->folder_id;
   OUTPUT:
	RETVAL

uint32_t
parent_id(self, newValue = NO_INIT)
	MLA_Folder	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->parent_id = newValue;
	RETVAL = self->parent_id;
   OUTPUT:
	RETVAL

uint32_t
storage_id(self, newValue = NO_INIT)
	MLA_Folder	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->storage_id = newValue;
	RETVAL = self->storage_id;
   OUTPUT:
	RETVAL

Utf8String
name(self, newValue = NO_INIT)
	MLA_Folder	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->name = strdup(newValue);
	RETVAL = self->name;
   OUTPUT:
	RETVAL

MLA_Folder
sibling(self)
	MLA_Folder	self
   CODE:
	RETVAL = self->sibling;
   OUTPUT:
	RETVAL

MLA_Folder
child(self)
	MLA_Folder	self
   CODE:
	RETVAL = self->child;
   OUTPUT:
	RETVAL

MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Folder  PREFIX = LIBMTP_

MLA_Folder
LIBMTP_Find_Folder(arg0, arg1)
	MLA_Folder	arg0
	uint32_t	arg1


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::FolderList

void
DESTROY(self)
	MLA_Folder	self
   CODE:
	LIBMTP_destroy_folder_t(self);


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Playlist

MLA_PlaylistList
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_playlist_t();
   OUTPUT:
	RETVAL

uint32_t
playlist_id(self, newValue = NO_INIT)
	MLA_Playlist	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->playlist_id = newValue;
	RETVAL = self->playlist_id;
   OUTPUT:
	RETVAL

uint32_t
parent_id(self, newValue = NO_INIT)
	MLA_Playlist	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->parent_id = newValue;
	RETVAL = self->parent_id;
   OUTPUT:
	RETVAL

uint32_t
storage_id(self, newValue = NO_INIT)
	MLA_Playlist	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->storage_id = newValue;
	RETVAL = self->storage_id;
   OUTPUT:
	RETVAL

Utf8String
name(self, newValue = NO_INIT)
	MLA_Playlist	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->name = strdup(newValue);
	RETVAL = self->name;
   OUTPUT:
	RETVAL

AV *
tracks(self, newValue = NO_INIT)
	MLA_Playlist	self
	AV *		newValue
   PREINIT:
	I32		i;
   CODE:
        if (items > 1) {
          if (self->tracks) Safefree(self->tracks);
          i = av_len(newValue);
          self->no_tracks = i + 1;
          Newx(self->tracks, self->no_tracks, uint32_t);
          for (; i >= 0; --i) {
            self->tracks[i] =
              SvUV(*av_fetch(newValue, i, 0));
          }
        }
	RETVAL = newAV();
	sv_2mortal((SV*)RETVAL);
	av_extend(RETVAL, self->no_tracks - 1);
        for (i = 0; i < self->no_tracks; ++i) {
          av_store(RETVAL, i, newSVuv(self->tracks[i]));
        }
   OUTPUT:
	RETVAL

uint32_t
no_tracks(self)
	MLA_Playlist	self
   CODE:
	RETVAL = self->no_tracks;
   OUTPUT:
	RETVAL

MLA_Playlist
next(self)
	MLA_Playlist	self
   CODE:
	RETVAL = self->next;
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::PlaylistList

void
DESTROY(self)
	MLA_Playlist	self
   CODE:
	LIBMTP_destroy_playlist_t(self);


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Track

MLA_TrackList
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_track_t();
   OUTPUT:
	RETVAL

uint32_t
item_id(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->item_id = newValue;
	RETVAL = self->item_id;
   OUTPUT:
	RETVAL

uint32_t
parent_id(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->parent_id = newValue;
	RETVAL = self->parent_id;
   OUTPUT:
	RETVAL

uint32_t
storage_id(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->storage_id = newValue;
	RETVAL = self->storage_id;
   OUTPUT:
	RETVAL

Utf8String
title(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->title = strdup(newValue);
	RETVAL = self->title;
   OUTPUT:
	RETVAL

Utf8String
artist(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->artist = strdup(newValue);
	RETVAL = self->artist;
   OUTPUT:
	RETVAL

Utf8String
composer(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->composer = strdup(newValue);
	RETVAL = self->composer;
   OUTPUT:
	RETVAL

Utf8String
genre(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->genre = strdup(newValue);
	RETVAL = self->genre;
   OUTPUT:
	RETVAL

Utf8String
album(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->album = strdup(newValue);
	RETVAL = self->album;
   OUTPUT:
	RETVAL

Utf8String
date(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->date = strdup(newValue);
	RETVAL = self->date;
   OUTPUT:
	RETVAL

Utf8String
filename(self, newValue = NO_INIT)
	MLA_Track	self
	Utf8String	newValue
   CODE:
	if (items > 1)
	  self->filename = strdup(newValue);
	RETVAL = self->filename;
   OUTPUT:
	RETVAL

uint16_t
tracknumber(self, newValue = NO_INIT)
	MLA_Track	self
	uint16_t	newValue
   CODE:
	if (items > 1)
	  self->tracknumber = newValue;
	RETVAL = self->tracknumber;
   OUTPUT:
	RETVAL

uint32_t
duration(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->duration = newValue;
	RETVAL = self->duration;
   OUTPUT:
	RETVAL

uint32_t
samplerate(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->samplerate = newValue;
	RETVAL = self->samplerate;
   OUTPUT:
	RETVAL

uint16_t
nochannels(self, newValue = NO_INIT)
	MLA_Track	self
	uint16_t	newValue
   CODE:
	if (items > 1)
	  self->nochannels = newValue;
	RETVAL = self->nochannels;
   OUTPUT:
	RETVAL

uint32_t
wavecodec(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->wavecodec = newValue;
	RETVAL = self->wavecodec;
   OUTPUT:
	RETVAL

uint32_t
bitrate(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->bitrate = newValue;
	RETVAL = self->bitrate;
   OUTPUT:
	RETVAL

uint16_t
bitratetype(self, newValue = NO_INIT)
	MLA_Track	self
	uint16_t	newValue
   CODE:
	if (items > 1)
	  self->bitratetype = newValue;
	RETVAL = self->bitratetype;
   OUTPUT:
	RETVAL

uint16_t
rating(self, newValue = NO_INIT)
	MLA_Track	self
	uint16_t	newValue
   CODE:
	if (items > 1)
	  self->rating = newValue;
	RETVAL = self->rating;
   OUTPUT:
	RETVAL

uint32_t
usecount(self, newValue = NO_INIT)
	MLA_Track	self
	uint32_t	newValue
   CODE:
	if (items > 1)
	  self->usecount = newValue;
	RETVAL = self->usecount;
   OUTPUT:
	RETVAL

uint64_t
filesize(self, newValue = NO_INIT)
	MLA_Track	self
	uint64_t	newValue
   CODE:
	if (items > 1)
	  self->filesize = newValue;
	RETVAL = self->filesize;
   OUTPUT:
	RETVAL

time_t
modificationdate(self, newValue = NO_INIT)
	MLA_Track	self
	time_t	newValue
   CODE:
	if (items > 1)
	  self->modificationdate = newValue;
	RETVAL = self->modificationdate;
   OUTPUT:
	RETVAL

LIBMTP_filetype_t
filetype(self, newValue = NO_INIT)
	MLA_Track	self
	LIBMTP_filetype_t	newValue
   CODE:
	if (items > 1)
	  self->filetype = newValue;
	RETVAL = self->filetype;
   OUTPUT:
	RETVAL

MLA_Track
next(self)
	MLA_Track	self
   CODE:
	RETVAL = self->next;
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::TrackList

void
DESTROY(self)
	MLA_Track	self
   CODE:
	LIBMTP_destroy_track_t(self);
