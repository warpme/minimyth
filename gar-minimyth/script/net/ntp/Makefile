GARNAME = ntp
GARVERSION = 4.2.0
CATEGORIES = net
MASTER_SITES = http://www.eecis.udel.edu/~$(GARNAME)/$(GARNAME)_spool/$(GARNAME)4/$(GARNAME)-4.2/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gcc4.patch $(DISTNAME)-config_phone.patch
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c
ifneq ($(DESTIMG),build)
BUILDDEPS = net/ntp
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += cross
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-all-clocks \
	--without-crypto
	
include ../../gar.mk

install-cross:
	cp -f $(WORKSRC)/ntpdc/ntpdc-layout $(DESTDIR)$(bindir)/ntp-ntpdc-layout
	@$(MAKECOOKIE)
