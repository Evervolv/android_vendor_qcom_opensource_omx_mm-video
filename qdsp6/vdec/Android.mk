ifneq ($(BUILD_TINY_ANDROID),true)

ROOT_DIR := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_PATH:= $(ROOT_DIR)

# ---------------------------------------------------------------------------------
#             Common definitons
# ---------------------------------------------------------------------------------

libOmxVdec-def := -g -O3
libOmxVdec-def += -DQC_MODIFIED
libOmxVdec-def += -DVERBOSE
libOmxVdec-def += -D_DEBUG
libOmxVdec-def += -DUSE_LOGE_FOR_DECODER
libOmxVdec-def += -D_ANDROID_
libOmxVdec-def += -DPROFILE_DECODER
libOmxVdec-def += -Du32="unsigned int"
libOmxVdec-def += -Du8="unsigned char"

# ---------------------------------------------------------------------------------
#          Make the Shared library (libOmxVdec)
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

libOmxVdec-inc          := $(LOCAL_PATH)/src
libOmxVdec-inc          += $(TARGET_OUT_HEADERS)/mm-core/omxcore

LOCAL_MODULE            := libOmxVdec
LOCAL_MODULE_TAGS       := optional
LOCAL_CFLAGS            := $(libOmxVdec-def)
LOCAL_C_INCLUDES        := $(libOmxVdec-inc)
LOCAL_PRELINK_MODULE    := false
LOCAL_SHARED_LIBRARIES  := libutils liblog libbinder libcutils

LOCAL_SRC_FILES         := src/adsp.c
LOCAL_SRC_FILES         += src/pmem.c
LOCAL_SRC_FILES         += src/qutility.c
LOCAL_SRC_FILES         += src/vdec.cpp
LOCAL_SRC_FILES         += src/omx_vdec.cpp
LOCAL_SRC_FILES         += src/omx_vdec_linux.cpp
LOCAL_SRC_FILES         += src/omx_vdec_inpbuf.cpp
LOCAL_SRC_FILES         += src/MP4_Utils.cpp
LOCAL_SRC_FILES         += src/H264_Utils.cpp

include $(BUILD_SHARED_LIBRARY)

# ---------------------------------------------------------------------------------
#          Make the vdec-property-mgr (mm-vdec-omx-property-mgr)
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

mm-vdec-property-mgr-inc    := $(LOCAL_PATH)

LOCAL_MODULE            := mm-vdec-omx-property-mgr
LOCAL_MODULE_TAGS       := optional
LOCAL_CFLAGS            := $(libOmxVdec-def)
LOCAL_C_INCLUDES        := $(mm-vdec-property-mgr-inc)
LOCAL_PRELINK_MODULE    := false
LOCAL_SHARED_LIBRARIES  := libcutils

LOCAL_SRC_FILES         := test/omx_vdec_property_mgr.cpp

include $(BUILD_EXECUTABLE)

endif #BUILD_TINY_ANDROID

# ---------------------------------------------------------------------------------
#                END
# ---------------------------------------------------------------------------------

