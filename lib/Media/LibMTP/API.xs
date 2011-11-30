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
typedef LIBMTP_mtpdevice_t *       MLA_MTPDevice;
typedef LIBMTP_playlist_t *        MLA_Playlist;
typedef LIBMTP_raw_device_t *      MLA_RawDevice;
typedef LIBMTP_track_t *           MLA_Track;

#include "const-c.inc"

MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API  PREFIX = LIBMTP_

INCLUDE: const-xs.inc

int
LIBMTP_Check_Specific_Device(busno, devno)
	int	busno
	int	devno

void
LIBMTP_Clear_Errorstack(arg0)
	MLA_MTPDevice		arg0

uint32_t
LIBMTP_Create_Folder(arg0, arg1, arg2, arg3)
	MLA_MTPDevice	arg0
	char *		arg1
	uint32_t	arg2
	uint32_t	arg3

int
LIBMTP_Create_New_Album(arg0, arg1)
	MLA_MTPDevice	arg0
	MLA_Album	arg1

int
LIBMTP_Create_New_Playlist(arg0, arg1)
	MLA_MTPDevice	arg0
	MLA_Playlist	arg1

int
LIBMTP_Delete_Object(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

#// FIXME
#// LIBMTP_error_number_t
#// LIBMTP_Detect_Raw_Devices(arg0, arg1)
#// 	LIBMTP_raw_device_t **	arg0
#// 	int *	arg1

void
LIBMTP_Dump_Device_Info(arg0)
	MLA_MTPDevice	arg0

void
LIBMTP_Dump_Errorstack(arg0)
	MLA_MTPDevice	arg0

MLA_Folder
LIBMTP_Find_Folder(arg0, arg1)
	MLA_Folder	arg0
	uint32_t	arg1

#// FIXME
#// int
#// LIBMTP_Format_Storage(arg0, arg1)
#// 	MLA_MTPDevice		arg0
#// 	LIBMTP_devicestorage_t *	arg1

MLA_Album
LIBMTP_Get_Album(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

MLA_Album
LIBMTP_Get_Album_List(arg0)
	MLA_MTPDevice	arg0

MLA_Album
LIBMTP_Get_Album_List_For_Storage(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

int
LIBMTP_Get_Allowed_Property_Values(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	LIBMTP_property_t	arg1
	LIBMTP_filetype_t	arg2
	MLA_AllowedValues	arg3

#//FIXME return list
#// int
#// LIBMTP_Get_Batterylevel(arg0, arg1, arg2)
#// 	MLA_MTPDevice	arg0
#// 	uint8_t *	arg1
#// 	uint8_t *	arg2

#//FIXME use AV* ???
#//  LIBMTP_error_number_t
#//  LIBMTP_Get_Connected_Devices(arg0)
#//  	MLA_MTPDevice *		arg0
#//

#// FIXME
#// int
#// LIBMTP_Get_Device_Certificate(arg0, arg1)
#// 	MLA_MTPDevice		arg0
#// 	char **	arg1

char *
LIBMTP_Get_Deviceversion(arg0)
	MLA_MTPDevice	arg0

MLA_Error
LIBMTP_Get_Errorstack(arg0)
	MLA_MTPDevice	arg0

#// FIXME
#// int
#// LIBMTP_Get_File_To_File(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	char const *	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_File_To_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	int		arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_File_To_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	void *		arg2
#// 	void *		arg3
#// 	void *		arg4
#// 	void const *	arg5

MLA_File
LIBMTP_Get_Filelisting(arg0)
	MLA_MTPDevice	arg0

#//FIXME
#// MLA_File
#// LIBMTP_Get_Filelisting_With_Callback(arg0, arg1, arg2)
#// 	MLA_MTPDevice	arg0
#// 	void *		arg1
#// 	void const *	arg2

MLA_File
LIBMTP_Get_Filemetadata(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

MLA_File
LIBMTP_Get_Files_And_Folders(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	uint32_t	arg1
	uint32_t	arg2

char const *
LIBMTP_Get_Filetype_Description(arg0)
	LIBMTP_filetype_t	arg0

MLA_MTPDevice
LIBMTP_Get_First_Device()

MLA_Folder
LIBMTP_Get_Folder_List(arg0)
	MLA_MTPDevice	arg0

MLA_Folder
LIBMTP_Get_Folder_List_For_Storage(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

char *
LIBMTP_Get_Friendlyname(arg0)
	MLA_MTPDevice	arg0

char *
LIBMTP_Get_Manufacturername(arg0)
	MLA_MTPDevice	arg0

char *
LIBMTP_Get_Modelname(arg0)
	MLA_MTPDevice	arg0

MLA_Playlist
LIBMTP_Get_Playlist(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

MLA_Playlist
LIBMTP_Get_Playlist_List(arg0)
	MLA_MTPDevice	arg0

char const *
LIBMTP_Get_Property_Description(inproperty)
	LIBMTP_property_t	inproperty

int
LIBMTP_Get_Representative_Sample(arg0, arg1, arg2)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	MLA_FileSampleData	arg2

#// FIXME
#// int
#// LIBMTP_Get_Representative_Sample_Format(arg0, arg1, arg2)
#// 	MLA_MTPDevice		arg0
#// 	LIBMTP_filetype_t	arg1
#// 	MLA_FileSampleData*	arg2

#// FIXME
#// int
#// LIBMTP_Get_Secure_Time(arg0, arg1)
#// 	MLA_MTPDevice		arg0
#// 	char **	arg1

char *
LIBMTP_Get_Serialnumber(arg0)
	MLA_MTPDevice	arg0

int
LIBMTP_Get_Storage(arg0, arg1)
	MLA_MTPDevice	arg0
	int		arg1

char *
LIBMTP_Get_String_From_Object(arg0, arg1, arg2)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2

#// FIXME
#// int
#// LIBMTP_Get_Supported_Devices_List(arg0, arg1)
#// 	LIBMTP_device_entry_t **	arg0
#// 	int *	arg1

#// FIXME
#// int
#// LIBMTP_Get_Supported_Filetypes(arg0, arg1, arg2)
#// 	MLA_MTPDevice		arg0
#// 	uint16_t **	arg1
#// 	uint16_t *	arg2

char *
LIBMTP_Get_Syncpartner(arg0)
	MLA_MTPDevice	arg0

#// FIXME
#// int
#// LIBMTP_Get_Track_To_File(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	char const *	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_Track_To_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	int		arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Get_Track_To_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	void *		arg2
#// 	void *		arg3
#// 	void *		arg4
#// 	void const *	arg5

MLA_Track
LIBMTP_Get_Tracklisting(arg0)
	MLA_MTPDevice	arg0

#// FIXME
#// MLA_Track
#// LIBMTP_Get_Tracklisting_With_Callback(arg0, arg1, arg2)
#// 	MLA_MTPDevice	arg0
#// 	void *		arg1
#// 	void const *	arg2
#//
#// MLA_Track
#// LIBMTP_Get_Tracklisting_With_Callback_For_Storage(arg0, arg1, arg2, arg3)
#// 	MLA_MTPDevice	arg0
#// 	uint32_t	arg1
#// 	void *		arg2
#// 	void const *	arg3

MLA_Track
LIBMTP_Get_Trackmetadata(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

uint16_t
LIBMTP_Get_u16_From_Object(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint16_t		arg3

uint32_t
LIBMTP_Get_u32_From_Object(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint32_t		arg3

uint64_t
LIBMTP_Get_u64_From_Object(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint64_t		arg3

uint8_t
LIBMTP_Get_u8_From_Object(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint8_t			arg3

void
LIBMTP_Init()

int
LIBMTP_Is_Property_Supported(arg0, arg1, arg2)
	MLA_MTPDevice		arg0
	LIBMTP_property_t	arg1
	LIBMTP_filetype_t	arg2

uint32_t
LIBMTP_Number_Devices_In_List(arg0)
	MLA_MTPDevice	arg0

MLA_MTPDevice
LIBMTP_Open_Raw_Device(arg0)
	MLA_RawDevice	arg0

MLA_MTPDevice
LIBMTP_Open_Raw_Device_Uncached(arg0)
	MLA_RawDevice	arg0

#// FIXME
#// int
#// LIBMTP_Read_Event(arg0, arg1)
#// 	MLA_MTPDevice		arg0
#// 	LIBMTP_event_t *	arg1

void
LIBMTP_Release_Device(arg0)
	MLA_MTPDevice	arg0

void
LIBMTP_Release_Device_List(arg0)
	MLA_MTPDevice	arg0

int
LIBMTP_Reset_Device(arg0)
	MLA_MTPDevice	arg0

#// FIXME
#// int
#// LIBMTP_Send_File_From_File(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	char const *	arg1
#// 	MLA_File	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_File_From_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	int		arg1
#// 	MLA_File	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_File_From_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	arg0
#// 	void *		arg1
#// 	void *		arg2
#// 	MLA_File	arg3
#// 	void *		arg4
#// 	void const *	arg5

int
LIBMTP_Send_Representative_Sample(arg0, arg1, arg2)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	MLA_FileSampleData	arg2

#// FIXME
#// int
#// LIBMTP_Send_Track_From_File(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	char const *	arg1
#// 	MLA_Track	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_Track_From_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
#// 	MLA_MTPDevice	arg0
#// 	int		arg1
#// 	MLA_Track	arg2
#// 	void *		arg3
#// 	void const *	arg4
#//
#// int
#// LIBMTP_Send_Track_From_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
#// 	MLA_MTPDevice	arg0
#// 	void *		arg1
#// 	void *		arg2
#// 	MLA_Track	arg3
#// 	void *		arg4
#// 	void const *	arg5

int
LIBMTP_Set_Album_Name(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	MLA_Album	arg1
	const char *	arg2

void
LIBMTP_Set_Debug(arg0)
	int	arg0

int
LIBMTP_Set_File_Name(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	MLA_File	arg1
	const char *	arg2

int
LIBMTP_Set_Folder_Name(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	MLA_Folder	arg1
	const char *	arg2

int
LIBMTP_Set_Friendlyname(arg0, arg1)
	MLA_MTPDevice	arg0
	char const *	arg1

int
LIBMTP_Set_Object_Filename(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	uint32_t	arg1
	char *		arg2

int
LIBMTP_Set_Object_String(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	char const *		arg3

int
LIBMTP_Set_Object_u16(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint16_t		arg3

int
LIBMTP_Set_Object_u32(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint32_t		arg3

int
LIBMTP_Set_Object_u8(arg0, arg1, arg2, arg3)
	MLA_MTPDevice		arg0
	uint32_t		arg1
	LIBMTP_property_t	arg2
	uint8_t			arg3

int
LIBMTP_Set_Playlist_Name(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	MLA_Playlist	arg1
	const char *	arg2

int
LIBMTP_Set_Syncpartner(arg0, arg1)
	MLA_MTPDevice	arg0
	char const *	arg1

int
LIBMTP_Set_Track_Name(arg0, arg1, arg2)
	MLA_MTPDevice	arg0
	MLA_Track	arg1
	const char *	arg2

int
LIBMTP_Track_Exists(arg0, arg1)
	MLA_MTPDevice	arg0
	uint32_t	arg1

int
LIBMTP_Update_Album(arg0, arg1)
	MLA_MTPDevice	arg0
	MLA_Album	arg1

int
LIBMTP_Update_Playlist(arg0, arg1)
	MLA_MTPDevice	arg0
	MLA_Playlist	arg1

int
LIBMTP_Update_Track_Metadata(arg0, arg1)
	MLA_MTPDevice	arg0
	MLA_Track	arg1


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


#--------------------------------------------------------------------
MODULE = Media::LibMTP::API  PACKAGE = Media::LibMTP::API::Error

LIBMTP_error_number_t
errornumber(self)
	MLA_Error	self
   CODE:
	RETVAL = self->errornumber;
   OUTPUT:
 	RETVAL

char *
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

void
DESTROY(self)
	MLA_Folder	self
   CODE:
	LIBMTP_destroy_folder_t(self);

MLA_Folder
new(class)
	SV *	class
   CODE:
	RETVAL = LIBMTP_new_folder_t();
   OUTPUT:
 	RETVAL


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
