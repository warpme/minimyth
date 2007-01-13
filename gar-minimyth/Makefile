include script/gar.conf.mk
-include $(HOME)/.minimyth/minimyth.conf.mk
include script/minimyth.conf.mk

DIR_HEAD := $(shell echo $(mm_HOME) | sed 's%/[^/]*$$%%')
DIR_TAIL := $(shell echo $(mm_HOME) | sed 's%[^/]*/%%g')

PWD := $(shell pwd)

clean:
	@rm -rf images/*
	@make -C script clean

clean-main:
	@rm -rf images/main
	@make -C script DESTIMG=main clean-image

garchive:
	@make -C script garchive

tarball:
	@cd $(DIR_HEAD) ; tar -jcf $(DIR_TAIL)/gar-minimyth-$(mm_VERSION).tar.bz2 $(DIR_TAIL) \
		--exclude '$(DIR_TAIL)/gar-minimyth-*.tar.bz2' \
		--exclude '$(DIR_TAIL)/images/*' \
		--exclude '$(DIR_TAIL)/source/*' \
		--exclude '$(DIR_TAIL)/script/*/*/cookies' \
		--exclude '$(DIR_TAIL)/script/*/*/cookies/*' \
		--exclude '$(DIR_TAIL)/script/*/*/download' \
		--exclude '$(DIR_TAIL)/script/*/*/download/*' \
		--exclude '$(DIR_TAIL)/script/*/*/tmp' \
		--exclude '$(DIR_TAIL)/script/*/*/tmp/*' \
		--exclude '$(DIR_TAIL)/script/*/*/work' \
		--exclude '$(DIR_TAIL)/script/*/*/work/*' \
		--exclude '$(DIR_TAIL)/*.log' \
		--exclude '$(DIR_TAIL)/script/*.log' \
		--exclude '$(DIR_TAIL)/script/*/*.log' \
		--exclude '$(DIR_TAIL)/script/*/*/*.log' \

update-gar:
	@cd devel ; ./update-gar
