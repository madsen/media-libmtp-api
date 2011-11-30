#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <libmtp.h>

#include "const-c.inc"

MODULE = Media::LibMTP::API		PACKAGE = Media::LibMTP::API		PREFIX = LIBMTP_

INCLUDE: const-xs.inc

int
LIBMTP_Check_Specific_Device(busno, devno)
	int	busno
	int	devno

void
LIBMTP_Clear_Errorstack(arg0)
	LIBMTP_mtpdevice_t *	arg0

uint32_t
LIBMTP_Create_Folder(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	char *	arg1
	uint32_t	arg2
	uint32_t	arg3

int
LIBMTP_Create_New_Album(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_album_t *	arg1

int
LIBMTP_Create_New_Playlist(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_playlist_t *	arg1

int
LIBMTP_Delete_Object(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

LIBMTP_error_number_t
LIBMTP_Detect_Raw_Devices(arg0, arg1)
	LIBMTP_raw_device_t **	arg0
	int *	arg1

void
LIBMTP_Dump_Device_Info(arg0)
	LIBMTP_mtpdevice_t *	arg0

void
LIBMTP_Dump_Errorstack(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_folder_t *
LIBMTP_Find_Folder(arg0, arg1)
	LIBMTP_folder_t *	arg0
	uint32_t	arg1

int
LIBMTP_Format_Storage(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_devicestorage_t *	arg1

LIBMTP_album_t *
LIBMTP_Get_Album(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

LIBMTP_album_t *
LIBMTP_Get_Album_List(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_album_t *
LIBMTP_Get_Album_List_For_Storage(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

int
LIBMTP_Get_Allowed_Property_Values(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_property_t	arg1
	LIBMTP_filetype_t	arg2
	LIBMTP_allowed_values_t *	arg3

int
LIBMTP_Get_Batterylevel(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint8_t *	arg1
	uint8_t *	arg2

LIBMTP_error_number_t
LIBMTP_Get_Connected_Devices(arg0)
	LIBMTP_mtpdevice_t **	arg0

int
LIBMTP_Get_Device_Certificate(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	char **	arg1

char *
LIBMTP_Get_Deviceversion(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_error_t *
LIBMTP_Get_Errorstack(arg0)
	LIBMTP_mtpdevice_t *	arg0

int
LIBMTP_Get_File_To_File(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	char const *	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Get_File_To_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	int	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Get_File_To_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	void *	arg2
	void *	arg3
	void *	arg4
	void const *	arg5

LIBMTP_file_t *
LIBMTP_Get_Filelisting(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_file_t *
LIBMTP_Get_Filelisting_With_Callback(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	void *	arg1
	void const *	arg2

LIBMTP_file_t *
LIBMTP_Get_Filemetadata(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

LIBMTP_file_t *
LIBMTP_Get_Files_And_Folders(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	uint32_t	arg2

char const *
LIBMTP_Get_Filetype_Description(arg0)
	LIBMTP_filetype_t	arg0

LIBMTP_mtpdevice_t *
LIBMTP_Get_First_Device()

LIBMTP_folder_t *
LIBMTP_Get_Folder_List(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_folder_t *
LIBMTP_Get_Folder_List_For_Storage(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

char *
LIBMTP_Get_Friendlyname(arg0)
	LIBMTP_mtpdevice_t *	arg0

char *
LIBMTP_Get_Manufacturername(arg0)
	LIBMTP_mtpdevice_t *	arg0

char *
LIBMTP_Get_Modelname(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_playlist_t *
LIBMTP_Get_Playlist(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

LIBMTP_playlist_t *
LIBMTP_Get_Playlist_List(arg0)
	LIBMTP_mtpdevice_t *	arg0

char const *
LIBMTP_Get_Property_Description(inproperty)
	LIBMTP_property_t	inproperty

int
LIBMTP_Get_Representative_Sample(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_filesampledata_t *	arg2

int
LIBMTP_Get_Representative_Sample_Format(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_filetype_t	arg1
	LIBMTP_filesampledata_t **	arg2

int
LIBMTP_Get_Secure_Time(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	char **	arg1

char *
LIBMTP_Get_Serialnumber(arg0)
	LIBMTP_mtpdevice_t *	arg0

int
LIBMTP_Get_Storage(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	int	arg1

char *
LIBMTP_Get_String_From_Object(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2

int
LIBMTP_Get_Supported_Devices_List(arg0, arg1)
	LIBMTP_device_entry_t **	arg0
	int *	arg1

int
LIBMTP_Get_Supported_Filetypes(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint16_t **	arg1
	uint16_t *	arg2

char *
LIBMTP_Get_Syncpartner(arg0)
	LIBMTP_mtpdevice_t *	arg0

int
LIBMTP_Get_Track_To_File(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	char const *	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Get_Track_To_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	int	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Get_Track_To_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	void *	arg2
	void *	arg3
	void *	arg4
	void const *	arg5

LIBMTP_track_t *
LIBMTP_Get_Tracklisting(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_track_t *
LIBMTP_Get_Tracklisting_With_Callback(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	void *	arg1
	void const *	arg2

LIBMTP_track_t *
LIBMTP_Get_Tracklisting_With_Callback_For_Storage(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	void *	arg2
	void const *	arg3

LIBMTP_track_t *
LIBMTP_Get_Trackmetadata(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

uint16_t
LIBMTP_Get_u16_From_Object(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint16_t	arg3

uint32_t
LIBMTP_Get_u32_From_Object(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint32_t	arg3

uint64_t
LIBMTP_Get_u64_From_Object(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint64_t	arg3

uint8_t
LIBMTP_Get_u8_From_Object(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint8_t	arg3

void
LIBMTP_Init()

int
LIBMTP_Is_Property_Supported(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_property_t	arg1
	LIBMTP_filetype_t	arg2

uint32_t
LIBMTP_Number_Devices_In_List(arg0)
	LIBMTP_mtpdevice_t *	arg0

LIBMTP_mtpdevice_t *
LIBMTP_Open_Raw_Device(arg0)
	LIBMTP_raw_device_t *	arg0

LIBMTP_mtpdevice_t *
LIBMTP_Open_Raw_Device_Uncached(arg0)
	LIBMTP_raw_device_t *	arg0

int
LIBMTP_Read_Event(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_event_t *	arg1

void
LIBMTP_Release_Device(arg0)
	LIBMTP_mtpdevice_t *	arg0

void
LIBMTP_Release_Device_List(arg0)
	LIBMTP_mtpdevice_t *	arg0

int
LIBMTP_Reset_Device(arg0)
	LIBMTP_mtpdevice_t *	arg0

int
LIBMTP_Send_File_From_File(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	char const *	arg1
	LIBMTP_file_t *	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Send_File_From_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	int	arg1
	LIBMTP_file_t *	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Send_File_From_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
	LIBMTP_mtpdevice_t *	arg0
	void *	arg1
	void *	arg2
	LIBMTP_file_t *	arg3
	void *	arg4
	void const *	arg5

int
LIBMTP_Send_Representative_Sample(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_filesampledata_t *	arg2

int
LIBMTP_Send_Track_From_File(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	char const *	arg1
	LIBMTP_track_t *	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Send_Track_From_File_Descriptor(arg0, arg1, arg2, arg3, arg4)
	LIBMTP_mtpdevice_t *	arg0
	int	arg1
	LIBMTP_track_t *	arg2
	void *	arg3
	void const *	arg4

int
LIBMTP_Send_Track_From_Handler(arg0, arg1, arg2, arg3, arg4, arg5)
	LIBMTP_mtpdevice_t *	arg0
	void *	arg1
	void *	arg2
	LIBMTP_track_t *	arg3
	void *	arg4
	void const *	arg5

int
LIBMTP_Set_Album_Name(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_album_t *	arg1
	const char *	arg2

void
LIBMTP_Set_Debug(arg0)
	int	arg0

int
LIBMTP_Set_File_Name(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_file_t *	arg1
	const char *	arg2

int
LIBMTP_Set_Folder_Name(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_folder_t *	arg1
	const char *	arg2

int
LIBMTP_Set_Friendlyname(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	char const *	arg1

int
LIBMTP_Set_Object_Filename(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	char *	arg2

int
LIBMTP_Set_Object_String(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	char const *	arg3

int
LIBMTP_Set_Object_u16(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint16_t	arg3

int
LIBMTP_Set_Object_u32(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint32_t	arg3

int
LIBMTP_Set_Object_u8(arg0, arg1, arg2, arg3)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1
	LIBMTP_property_t	arg2
	uint8_t	arg3

int
LIBMTP_Set_Playlist_Name(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_playlist_t *	arg1
	const char *	arg2

int
LIBMTP_Set_Syncpartner(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	char const *	arg1

int
LIBMTP_Set_Track_Name(arg0, arg1, arg2)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_track_t *	arg1
	const char *	arg2

int
LIBMTP_Track_Exists(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	uint32_t	arg1

int
LIBMTP_Update_Album(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_album_t const *	arg1

int
LIBMTP_Update_Playlist(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_playlist_t *	arg1

int
LIBMTP_Update_Track_Metadata(arg0, arg1)
	LIBMTP_mtpdevice_t *	arg0
	LIBMTP_track_t const *	arg1

void
LIBMTP_destroy_album_t(arg0)
	LIBMTP_album_t *	arg0

void
LIBMTP_destroy_allowed_values_t(arg0)
	LIBMTP_allowed_values_t *	arg0

void
LIBMTP_destroy_file_t(arg0)
	LIBMTP_file_t *	arg0

void
LIBMTP_destroy_filesampledata_t(arg0)
	LIBMTP_filesampledata_t *	arg0

void
LIBMTP_destroy_folder_t(arg0)
	LIBMTP_folder_t *	arg0

void
LIBMTP_destroy_playlist_t(arg0)
	LIBMTP_playlist_t *	arg0

void
LIBMTP_destroy_track_t(arg0)
	LIBMTP_track_t *	arg0

LIBMTP_album_t *
LIBMTP_new_album_t()

LIBMTP_file_t *
LIBMTP_new_file_t()

LIBMTP_filesampledata_t *
LIBMTP_new_filesampledata_t()

LIBMTP_folder_t *
LIBMTP_new_folder_t()

LIBMTP_playlist_t *
LIBMTP_new_playlist_t()

LIBMTP_track_t *
LIBMTP_new_track_t()
