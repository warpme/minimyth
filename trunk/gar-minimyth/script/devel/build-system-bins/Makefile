GARNAME = build-system-bins
GARVERSION =
CATEGORIES = devel
LICENSE =

DESCRIPTION =
define BLURB
endef

ifeq ("$(DESTIMG)","build")
INSTALL_SCRIPTS = bins
else
INSTALL_SCRIPTS = error
endif

GAR_EXTRA_CONF += devel/build-system-bins/package-api.mk
include ../../gar.mk

PATH=$(BUILD_SYSTEM_PATH)
export $(PATH)

install-bins:
	@rm -rf   $(DESTDIR)$(rootdir)/bin-build-system
	@mkdir -p $(DESTDIR)$(rootdir)/bin-build-system
	@for bin in $(build_system_bins) ; do \
		which $${bin} > /dev/null 2>&1 ; \
		if [ ! "$$?" = "0" ] ; then \
			echo "error: the build system does not contain the program '$${bin}'." ; \
			exit 1 ; \
		fi ; \
		if [ ! -e $(DESTDIR)$(rootdir)/bin-build-system/$${bin} ] ; then \
			ln -s `which $${bin}` $(DESTDIR)$(rootdir)/bin-build-system/$${bin} ; \
		fi ; \
	done
	@$(MAKECOOKIE)

install-error:
	@echo "error: this package is only valid for DESTIMG=build."
	@exit 1
	@$(MAKECOOKIE)
