GARNAME = intel
GARVERSION = 5.0
CATEGORIES = X11
MASTER_SITES = http://downloadmirror.intel.com/df-support/9871/eng/
DISTFILES = IEGD_5_0_Linux.tgz
LICENSE = Intel_IEGD
Intel_IEGD_LICENSE_TEXT=$(WORKSRC)/License/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg

WORKSRC = $(WORKDIR)/IEGD_5_0_Linux

INSTALL_SCRIPTS = $(if $(filter i386,$(mm_GARCH_FAMILY)),custom)

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/drivers
	@install $(WORKSRC)/Driver/Xorg-X11R6.7/intel_drv.o \
		$(DESTDIR)$(libdir)/xorg/modules/drivers
	@install $(WORKSRC)/Driver/Xorg-X11R6.7/*.so \
		$(DESTDIR)$(libdir)/xorg/modules
	@install $(WORKSRC)/Driver/Xorg-X11R6.7/libXportctl.a \
		$(DESTDIR)$(libdir)
	@install $(WORKSRC)/Driver/Xorg-X11R6.7/libXportctl.so.1.0 \
		$(DESTDIR)$(libdir)
	@cd $(DESTDIR)$(libdir) ; \
		ln -sf libXportctl.so.1.0 \
		       libXportctl.so.1 ; \
		ln -sf libXportctl.so.1 \
		       libXportctl.so
	@install $(WORKSRC)/Driver/Xorg-X11R6.7/libXiegdctl.so.1.0 \
		$(DESTDIR)$(libdir)
	@cd $(DESTDIR)$(libdir) ; \
		ln -sf libXiegdctl.so.1.0 \
		       libXiegdctl.so.1 ; \
		ln -sf libXiegdctl.so.1 \
		       libXiegdctl.so
	@install $(WORKSRC)/Driver/Xorg-X11R6.7/libXiegd_escape.so.1.0 \
		$(DESTDIR)$(libdir)
	@cd $(DESTDIR)$(libdir) ; \
		ln -sf libXiegd_escape.so.1.0 \
		       libXiegd_escape.so.1 ; \
		ln -sf libXiegd_escape.so.1 \
		       libXiegd_escape.so
	@$(MAKECOOKIE)
