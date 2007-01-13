include script/gar.conf.mk
-include $(HOME)/.minimyth/minimyth.conf.mk
include script/minimyth.conf.mk

DIR_HEAD := $(shell echo $(mm_HOME) | sed 's%/[^/]*$$%%')
DIR_TAIL := $(shell echo $(mm_HOME) | sed 's%[^/]*/%%g')
TAR_BASE := $(mm_SOURCENAME)
TAR_FILE := $(mm_SOURCENAME).tar.bz2

PWD := $(shell pwd)

build:
	@echo "error: 'make build' must be run in directory 'script/meta/minimyth'."
	@exit 1

clean:
	@rm -rf images/*
	@make -C script clean

clean-main:
	@rm -rf images/main
	@make -C script DESTIMG=main clean-image

garchive:
	@make -C script garchive

install:
	@echo "error: 'make build' must be run in directory 'script/meta/minimyth'."
	@exit 1

tarball:
	@rm -rf   $(DIR_HEAD)/$(DIR_TAIL)~
	@mkdir -p $(DIR_HEAD)/$(DIR_TAIL)~
	@cd $(DIR_HEAD) ; tar  \
		--exclude '$(DIR_TAIL)/$(TAR_FILE)' \
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
		-jcf $(DIR_TAIL)~/$(TAR_FILE) $(DIR_TAIL)
	@cd $(DIR_HEAD)/$(DIR_TAIL)~ ; tar -jxf $(TAR_FILE)
	@cd $(DIR_HEAD)/$(DIR_TAIL)~ ; rm -f    $(TAR_FILE)
	@cd $(DIR_HEAD)/$(DIR_TAIL)~ ; [ ! "$(DIR_TAIL)" = "$(TAR_BASE)" ] && mv $(DIR_TAIL) $(TAR_BASE) ; [ -d "$(TAR_BASE)" ]
	@cd $(DIR_HEAD)/$(DIR_TAIL)~ ; tar -jcf $(TAR_FILE) $(TAR_BASE)
	@cd $(DIR_HEAD) ; mv $(DIR_TAIL)~/$(TAR_FILE) $(DIR_TAIL)/$(TAR_FILE)
	@rm -rf $(DIR_HEAD)/$(DIR_TAIL)~

update-gar:
	@cd devel ; ./update-gar
