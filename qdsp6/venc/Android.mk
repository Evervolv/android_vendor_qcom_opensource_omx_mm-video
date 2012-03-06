ifneq ($(BUILD_TINY_ANDROID),true)

ROOT_DIR := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_PATH:= $(ROOT_DIR)

# ---------------------------------------------------------------------------------
# 				Common definitons
# ---------------------------------------------------------------------------------

libmm-venc-def := -DVENC_MSG_ERROR_ENABLE
libmm-venc-def += -DVENC_MSG_FATAL_ENABLE
libmm-venc-def += -DQCOM_OMX_VENC_EXT
libmm-venc-def += -O3
libmm-venc-def += -D_ANDROID_LOG_
libmm-venc-def += -D_ANDROID_LOG_ERROR
libmm-venc-def += -D_ANDROID_LOG_PROFILE
libmm-venc-def += -Du32="unsigned int"

# ---------------------------------------------------------------------------------
# 			Make the Shared library (libOmxVidEnc)
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

libmm-venc-inc += $(LOCAL_PATH)/omx/inc
libmm-venc-inc += $(LOCAL_PATH)/device/inc
libmm-venc-inc += $(LOCAL_PATH)/common/inc
libmm-venc-inc += $(TARGET_OUT_HEADERS)/mm-core/omxcore

LOCAL_MODULE := libOmxVidEnc
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := $(libmm-venc-def)
LOCAL_C_INCLUDES := $(libmm-venc-inc)
LOCAL_PRELINK_MODULE := false
LOCAL_SHARED_LIBRARIES := liblog libutils

LOCAL_SRC_FILES	:= omx/src/OMX_Venc.cpp
LOCAL_SRC_FILES	+= omx/src/OMX_VencBufferManager.cpp
LOCAL_SRC_FILES	+= device/src/venc_device.c

include $(BUILD_SHARED_LIBRARY)

endif #BUILD_TINY_ANDROID

# ---------------------------------------------------------------------------------
# 					END
# ---------------------------------------------------------------------------------

