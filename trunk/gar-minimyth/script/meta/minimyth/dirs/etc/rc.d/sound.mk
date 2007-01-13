################################################################################
# sound.mk
################################################################################

MM_SOUND = $(shell mm_var_get MM_SOUND)

SOUND = $(if $(MM_SOUND),$(MM_SOUND),"analog")

sound: sound-modules sound-config
	touch sound

sound-modules:
	modprobe snd-via82xx index=0 dxs_support=3
	modprobe snd-rtctimer
	modprobe snd-mixer-oss
	modprobe snd-seq-oss
	modprobe snd-mixer-oss
	modprobe snd-pcm-oss
	touch sound-modules

sound-config: mm_var_get sound-modules /root/.xine/config
	if   [ "$(SOUND)" = "analog"  ] ; then \
		amixer set 'PCM'    90% unmute ; \
		amixer set 'Master' 90% unmute ; \
		sed -i 's%@SPEAKER_ARRANGEMENT@%Stereo 2.0%'   /root/.xine/config ; \
	elif [ "$(SOUND)" = "digital" ] ; then \
		amixer set 'IEC958 Playback AC97-SPSA' 0 ; \
		sed -i 's%@SPEAKER_ARRANGEMENT@%Pass Through%' /root/.xine/config ; \
	fi
	touch sound-config

/root/.xine/config: /root
	touch /root/.xine/config
