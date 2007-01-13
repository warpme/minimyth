################################################################################
# mount.mk
################################################################################

MM_MYTHGALLERY_URL = $(shell mm_var_get MM_MYTHGALLERY_URL)
MM_MYTHMUSIC_URL   = $(shell mm_var_get MM_MYTHMUSIC_URL)
MM_MYTHVIDEO_URL   = $(shell mm_var_get MM_MYTHVIDEO_URL)

mount: /mnt/gallery /mnt/music /mnt/video
	touch mount

/mnt/gallery: mm_var_get mm_url_mount /mnt
	$(if $(MM_MYTHGALLERY_URL),mm_url_mount "$(MM_MYTHGALLERY_URL)" "/mnt/gallery")

/mnt/music: mm_var_get mm_url_mount /mnt
	$(if $(MM_MYTHMUSIC_URL),mm_url_mount "$(MM_MYTHMUSIC_URL)" "/mnt/music")

/mnt/video: mm_var_get mm_url_mount /mnt
	$(if $(MM_MYTHVIDEO_URL),mm_url_mount "$(MM_MYTHVIDEO_URL)" "/mnt/video")
