################################################################################
# mount.mk
################################################################################

MM_MYTHGALLERY_URL = $(shell mm_var_get MM_MYTHGALLERY_URL)
MM_MYTHMUSIC_URL   = $(shell mm_var_get MM_MYTHMUSIC_URL)
MM_MYTHVIDEO_URL   = $(shell mm_var_get MM_MYTHVIDEO_URL)

mount: mm_var_get mm_url_mount /mnt
	$(if $(MM_MYTHGALLERY_URL),mm_url_mount "$(MM_MYTHGALLERY_URL)" "/mnt/gallery")
	$(if $(MM_MYTHMUSIC_URL),mm_url_mount "$(MM_MYTHMUSIC_URL)" "/mnt/music")
	$(if $(MM_MYTHVIDEO_URL),mm_url_mount "$(MM_MYTHVIDEO_URL)" "/mnt/video")
	touch mount
