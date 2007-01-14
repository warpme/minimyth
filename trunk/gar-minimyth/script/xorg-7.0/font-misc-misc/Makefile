GARNAME = font-misc-misc
GARVERSION = 1.0.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c \
	$(CATEGORY)/font-util
BUILDDEPS = $(CATEGORY)/bdftopcf $(CATEGORY)/font-util $(CATEGORY)/mkfontdir $(CATEGORY)/mkfontscale

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-iso8859-1 \
	--disable-iso8859-2 \
	--disable-iso8859-3 \
	--disable-iso8859-4 \
	--disable-iso8859-5 \
	--disable-iso8859-7 \
	--disable-iso8859-8 \
	--disable-iso8859-9 \
	--disable-iso8859-10 \
	--disable-iso8859-11 \
	--disable-iso8859-13 \
	--disable-iso8859-14 \
	--disable-iso8859-15 \
	--disable-iso8859-16 \
	--disable-koi8-r \
	--disable-jisx0201 \
	MAPFILES_PATH='$$(PKG_CONFIG_PATH="$(build_DESTDIR)$(build_libdir)/pkgconfig" pkg-config --variable=mapdir fontutil)'

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2
