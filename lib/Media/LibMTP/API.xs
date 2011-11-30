#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <libmtp.h>

typedef LIBMTP_album_t *           MLA_Album;
typedef LIBMTP_allowed_values_t *  MLA_AllowedValues;
typedef LIBMTP_file_t *            MLA_File;
typedef LIBMTP_filesampledata_t *  MLA_FileSampleData;
typedef LIBMTP_error_t *           MLA_Error;
typedef LIBMTP_folder_t *          MLA_Folder;
typedef LIBMTP_folder_t *          MLA_FolderList; /* needs DESTROY */
typedef LIBMTP_mtpdevice_t *       MLA_MTPDevice;
typedef LIBMTP_playlist_t *        MLA_Playlist;
typedef LIBMTP_raw_device_t *      MLA_RawDevice;
typedef LIBMTP_track_t *           MLA_Track;

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

MLA_Album
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_album_t();
   OUTPUT:
	RETVAL

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

MLA_Album
LIBMTP_Get_Album(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

MLA_Album
LIBMTP_Get_Album_List(self)
	MLA_MTPDevice	self

MLA_Album
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

MLA_File
LIBMTP_Get_Filelisting(self)
	MLA_MTPDevice	self

#//FIXME
#// MLA_File
#// LIBMTP_Get_Filelisting_With_Callback(self, arg1, arg2)
#// 	MLA_MTPDevice	self
#// 	void *		arg1
#// 	void const *	arg2

MLA_File
LIBMTP_Get_Filemetadata(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

MLA_File
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

MLA_Playlist
LIBMTP_Get_Playlist(self, arg1)
	MLA_MTPDevice	self
	uint32_t	arg1

MLA_Playlist
LIBMTP_Get_Playlist_List(self)
	MLA_MTPDevice	self

int
LIBMTP_Get_Representative_Sample(self, arg1, arg2)
	MLA_MTPDevice		self
	uint32_t		arg1
	MLA_FileSampleData	arg2

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

MLA_Track
LIBMTP_Get_Tracklisting(self)
	MLA_MTPDevice	self

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

MLA_Track
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

#// FIXME
#// int
#// LIBMTP_Send_Track_From_File(self, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	self
#// 	char const *	arg1
#// 	MLA_Track	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
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
LIBMTP_Set_Object_Filename(self, arg1, arg2)
	MLA_MTPDevice	self
	uint32_t	arg1
	Utf8String	arg2

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

void
DESTROY(self)
	MLA_File	self
   CODE:
	LIBMTP_destroy_file_t(self);

MLA_File
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_file_t();
   OUTPUT:
	RETVAL


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
folder_id(self)
	MLA_Folder	self
   CODE:
	RETVAL = self->folder_id;
   OUTPUT:
	RETVAL

uint32_t
parent_id(self)
	MLA_Folder	self
   CODE:
	RETVAL = self->parent_id;
   OUTPUT:
	RETVAL

uint32_t
storage_id(self)
	MLA_Folder	self
   CODE:
	RETVAL = self->storage_id;
   OUTPUT:
	RETVAL

Utf8String
name(self)
	MLA_Folder	self
   CODE:
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
	MLA_FolderList	self
   CODE:
	LIBMTP_destroy_folder_t(self);


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Playlist

void
DESTROY(self)
	MLA_Playlist	self
   CODE:
	LIBMTP_destroy_playlist_t(self);

MLA_Playlist
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_playlist_t();
   OUTPUT:
	RETVAL


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Track

void
DESTROY(self)
	MLA_Track	self
   CODE:
	LIBMTP_destroy_track_t(self);

MLA_Track
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_track_t();
   OUTPUT:
	RETVAL
