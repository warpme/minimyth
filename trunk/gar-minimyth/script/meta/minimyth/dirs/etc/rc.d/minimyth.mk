################################################################################
# minimyth.mk
################################################################################

minimyth: /etc/minimyth.d/minimyth.conf /etc/minimyth.d/minimyth.script
	touch minimyth

/etc/minimyth.d/minimyth.conf: mm_conf_get /etc/minimyth.d
	mm_conf_get minimyth.conf /etc/minimyth.d/minimyth.conf
	touch /etc/minimyth.d/minimyth.conf

/etc/minimyth.d/minimyth.script: mm_conf_get /etc/minimyth.d fs commands
	mm_conf_get minimyth.script /etc/minimyth.d/minimyth.script
	$(if $(wildcard /etc/minimyth.d/minimyth.script),sh /etc/minimyth.d/minimyth.script)
	touch /etc/minimyth.d/minimyth.script

/etc/minimyth.d: /etc
	mkdir -p /etc/minimyth.d
	touch /etc/minimyth.d
