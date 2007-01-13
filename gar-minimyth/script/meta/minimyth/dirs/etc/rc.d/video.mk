################################################################################
# video.mk
################################################################################

video: video-modules
	touch video

video-modules:
	modprobe via
	touch video-modules
