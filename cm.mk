$(call inherit-product, device/htc/primou/device.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/gsm.mk)

PRODUCT_NAME := cm_primou
PRODUCT_BRAND := htc
PRODUCT_DEVICE := primou
PRODUCT_MODEL := One V
PRODUCT_MANUFACTURER := HTC
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_primou BUILD_FINGERPRINT=htc_europe/htc_primou/primou:4.2.2/JDQ39/330937:user/user-debug PRIVATE_BUILD_DESC="4.2.2 JDQ39 330937 user-debug"

PRODUCT_PROPERTY_OVERRIDES += \
    ro.goo.developerid=gannon5197 \
    ro.goo.rom=cm_$(TARGET_PRODUCT) \
    ro.goo.version=$(shell date +%s)
