#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# common msm7x30 configs
$(call inherit-product, device/htc/msm7x30-common/msm7x30.mk)

# The gps config appropriate for this device

PRODUCT_COPY_FILES += \
    device/htc/primou/configs/gps.conf:system/etc/gps.conf

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

PRODUCT_COPY_FILES += \
    device/htc/primou/prebuilt/root/init.primou.rc:root/init.primou.rc \
    device/htc/primou/prebuilt/root/init.usb.rc:root/init.usb.rc \
    device/htc/primou/prebuilt/root/init.rc:root/init.rc \
    device/htc/primou/prebuilt/root/ueventd.rc:root/ueventd.rc \
    device/htc/primou/prebuilt/root/ueventd.primou.rc:root/ueventd.primou.rc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/primou/primou-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.3_r3 \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y \
    ro.sf.lcd_density=240

# Override /proc/sys/vm/dirty_ratio on UMS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20
	
DEVICE_PACKAGE_OVERLAYS += device/htc/primou/overlay

# GPS / Lights / Sensors
PRODUCT_PACKAGES += \
    libbt-vendor \
    gps.primou \
    lights.primou \
    sensors.primou

# Additional packages
PRODUCT_PACKAGES += \
    Torch \
    PinyinIME

# idc files
PRODUCT_COPY_FILES += \
    device/htc/primou/prebuilt/usr/idc/atmel-touchscreen.idc:system/usr/idc/atmel-touchscreen.idc \
    device/htc/primou/prebuilt/usr/idc/primou-keypad.idc:system/usr/idc/primou-keypad.idc \
    device/htc/primou/prebuilt/usr/idc/qwerty.idc:system/usr/idc/qwerty.idc \
    device/htc/primou/prebuilt/usr/idc/qwerty2.idc:system/usr/idc/qwerty2.idc \
    device/htc/primou/prebuilt/usr/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    device/htc/primou/prebuilt/usr/keychars/Generic.kcm:system/usr/keychars/Generic.kcm \
    device/htc/primou/prebuilt/usr/keychars/qwerty.kcm:system/usr/keychars/qwerty.kcm \
    device/htc/primou/prebuilt/usr/keychars/qwerty2.kcm:system/usr/keychars/qwerty2.kcm \
    device/htc/primou/prebuilt/usr/keychars/Virtual.kcm:system/usr/keychars/Virtual.kcm \
    device/htc/primou/prebuilt/usr/keylayout/atmel-touchscreen.kl:system/usr/keylayout/atmel-touchscreen.kl \
    device/htc/primou/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/htc/primou/prebuilt/usr/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/primou/prebuilt/usr/keylayout/primou-keypad.kl:system/usr/keylayout/primou-keypad.kl \
    device/htc/primou/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/htc/primou/prebuilt/usr/keylayout/synaptics-rmi-touchscreen.kl:system/usr/keylayout/synaptics-rmi-touchscreen.kl

PRODUCT_COPY_FILES += \
    device/htc/primou/prebuilt/etc/vold.fstab:system/etc/vold.fstab

# init.d files
PRODUCT_COPY_FILES += \
    device/htc/primou/prebuilt/etc/init.d/01swap:system/etc/init.d/01swap

# bluez config
PRODUCT_COPY_FILES += \
    device/htc/primou/prebuilt/etc/dbus.conf:system/etc/dbus.conf \
    device/htc/primou/prebuilt/etc/dbus-1/system-services/org.bluez.service:system/etc/dbus-1/system-services/org.bluez.service \
    device/htc/primou/prebuilt/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/primou/prebuilt/root/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_LOCALES += en_GB


$(call inherit-product, build/target/product/full_base.mk)

## Recovery

PRODUCT_COPY_FILES += \
    device/htc/primou/recovery/sbin/choice_fn:recovery/root/sbin/choice_fn \
    device/htc/primou/recovery/sbin/detect_key:recovery/root/sbin/detect_key \
    device/htc/primou/recovery/sbin/offmode_charging:recovery/root/sbin/offmode_charging \
    device/htc/primou/recovery/sbin/power_test:recovery/root/sbin/power_test

# HTC Audio
$(call inherit-product, device/htc/primou/media_a1026.mk)
$(call inherit-product, device/htc/primou/media_htcaudio.mk)

# Inherit qcom proprietary blobs
$(call inherit-product, vendor/qcom/proprietary/qcom-vendor.mk)

# Media Profiles
PRODUCT_COPY_FILES += \
    device/htc/primou/configs/media_profiles.xml:system/etc/media_profiles.xml \
    device/htc/primou/configs/media_codecs.xml:system/etc/media_codecs.xml

# ACDB
PRODUCT_COPY_FILES += \
    device/htc/primou/configs/default.acdb:system/etc/firmware/default.acdb \
    device/htc/primou/configs/default_org.acdb:system/etc/firmware/default_org.acdb

# Audio DSP Profiles
PRODUCT_COPY_FILES += \
    device/htc/primou/dsp/AdieHWCodec.csv:system/etc/AdieHWCodec.csv \
    device/htc/primou/dsp/AIC3254_REG.csv:system/etc/AIC3254_REG.csv \
    device/htc/primou/dsp/CodecDSPID.txt:system/etc/CodecDSPID.txt \
    device/htc/primou/dsp/TPA2051_CFG.csv:system/etc/TPA2051_CFG.csv 
	

# BT vendor configuration
PRODUCT_COPY_FILES += \
    device/htc/primou/configs/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# HTC BT audio config
PRODUCT_COPY_FILES += \
    device/htc/primou/configs/AudioBTID.csv:system/etc/AudioBTID.csv

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)
