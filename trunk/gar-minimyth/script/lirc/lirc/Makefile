GARNAME = lirc
GARVERSION = $(LIRC_VERSION)
CATEGORIES = lirc
MASTER_SITES = http://aleron.dl.sourceforge.net/sourceforge/lirc/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
PATCHFILES = $(GARNAME)-$(GARVERSION)-libusb.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lirc/lirc.any lirc/lirc.serial

include ../../gar.mk

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

