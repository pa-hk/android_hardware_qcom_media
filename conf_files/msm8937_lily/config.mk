CONFIG_PATH := hardware/qcom/media/conf_files/msm8937_lily

PRODUCT_COPY_FILES += $(CONFIG_PATH)/media_profiles_8937.xml:system/etc/media_profiles.xml \
                      $(CONFIG_PATH)/media_profiles_8937.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml \
                      $(CONFIG_PATH)/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
                      $(CONFIG_PATH)/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_8937_v1.xml \
                      $(CONFIG_PATH)/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor.xml \
                      $(CONFIG_PATH)/media_codecs_performance_8937.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
                      $(CONFIG_PATH)/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml \

# Vendor property overrides
ifeq ($(GENERIC_ODM_IMAGE),true)
  $(warning "Forcing codec2.0 HW for generic odm build variant")
  #Set default ranks and rank Codec 2.0 over OMX codecs
  PRODUCT_ODM_PROPERTIES += debug.stagefright.ccodec=4
  PRODUCT_ODM_PROPERTIES += debug.stagefright.omx_default_rank=1000
  PRODUCT_COPY_FILES += \
     device/qcom/common/media/media_profiles.xml:$(TARGET_COPY_OUT_ODM)/etc/media_profiles_V1_0.xml
else
  $(warning "Enabling codec2.0 non-audio SW only for non-generic odm build variant")
  PRODUCT_PROPERTY_OVERRIDES += ro.media.xml_variant.codecs=_vendor
  PRODUCT_PROPERTY_OVERRIDES += ro.media.xml_variant.codecs_performance=_vendor
  PRODUCT_PROPERTY_OVERRIDES += \
        vendor.vidc.disable.split.mode=1 \
        vendor.mediacodec.binder.size=4 \
        debug.stagefright.omx_default_rank=0 \
        media.settings.xml=/vendor/etc/media_profiles_vendor.xml
  PRODUCT_COPY_FILES += \
     device/qcom/common/media/media_profiles.xml:$(TARGET_COPY_OUT_ODM)/etc/media_profiles_V1_0.xml
endif
