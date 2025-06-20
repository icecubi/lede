define Device/FitImage
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | libdeflate-gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/FitImageLzma
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/UbiFit
	KERNEL_IN_UBI := 1
	IMAGES := factory.ubi sysupgrade.bin
	IMAGE/factory.ubi := append-ubi
	IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef

define Device/EmmcImage
	IMAGES := factory.bin recovery.bin sysupgrade.bin
	IMAGE/factory.bin := append-kernel | pad-to 12288k | append-rootfs | append-metadata
	IMAGE/recovery.bin := append-kernel | pad-to 6144k | append-rootfs | append-metadata
	IMAGE/sysupgrade.bin/squashfs := append-rootfs | pad-to 64k | sysupgrade-tar rootfs=$$$$@ | append-metadata
endef

define Device/glinet_gl-b3000
  $(call Device/FitImage)
  $(call Device/UbiFit)
  SOC := ipq5018
  DEVICE_VENDOR := GL.iNET
  DEVICE_MODEL := GL-B3000
  BLOCKSIZE := 128k
  PAGESIZE := 2048
  DEVICE_DTS_CONFIG := config@mp03.5-c1
  DEVICE_PACKAGES := ath11k-firmware-qcn6122 ipq-wifi-gl-b3000
endef
TARGET_DEVICES += glinet_gl-b3000

define Device/jdcloud_re-cs-03
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	SOC := ipq5018
	BLOCKSIZE := 64k
	KERNEL_SIZE := 6144k
	DEVICE_VENDOR := JDCloud
	DEVICE_MODEL := AX3000
	DEVICE_DTS_CONFIG := config@mp03.5-c2
endef
TARGET_DEVICES += jdcloud_re-cs-03

define Device/linksys_mx2000
	$(call Device/FitImageLzma)
	DEVICE_VENDOR := Linksys
	DEVICE_MODEL := MX2000
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	KERNEL_SIZE := 8192k
	IMAGE_SIZE := 83968k
	DEVICE_DTS_CONFIG := config@mp03.5-c1
	SOC := ipq5018
	UBINIZE_OPTS := -E 5
	IMAGES += factory.bin
	IMAGE/factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-ubi | linksys-image type=MX2000
	DEVICE_PACKAGES := ath11k-firmware-qcn6122 ipq-wifi-linksys_mx2000
endef
TARGET_DEVICES += linksys_mx2000

define Device/linksys_mx5500
	$(call Device/FitImageLzma)
	DEVICE_VENDOR := Linksys
	DEVICE_MODEL := MX5500
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	KERNEL_SIZE := 8192k
	IMAGE_SIZE := 83968k
	DEVICE_DTS_CONFIG := config@mp03.1
	SOC := ipq5018
	UBINIZE_OPTS := -E 5
	IMAGES += factory.bin
	IMAGE/factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-ubi | linksys-image type=MX5500
	DEVICE_PACKAGES := kmod-ath11k-pci ath11k-firmware-qcn9074 ipq-wifi-linksys_mx5500
endef
TARGET_DEVICES += linksys_mx5500

define Device/redmi_ax3000
  $(call Device/FitImage)
  $(call Device/UbiFit)
  SOC := ipq5018
  DEVICE_VENDOR := Redmi
  DEVICE_MODEL := AX3000
  BLOCKSIZE := 128k
  PAGESIZE := 2048
  DEVICE_DTS_CONFIG := config@mp02.1
  DEVICE_PACKAGES := \
	ath11k-firmware-ipq5018 \
	ath11k-firmware-qcn6122 \
	ipq-wifi-redmi_ax3000
endef
TARGET_DEVICES += redmi_ax3000

