GARNAME = xorg-base
GARVERSION =
CATEGORIES = xorg
LICENSE =

DESCRIPTION = 
define BLURB
endef

INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../xorg.mk

install-custom:
	@rm -f $(DESTDIR)$(bindir)/X11
	@rm -f $(DESTDIR)$(includedir)/X11
	@rm -f $(DESTDIR)$(libdir)/X11
	@ln -sf ./$(call DIRSTODOTS,$(bindir))/$(xorg_bindir)             $(DESTDIR)$(bindir)/X11
	@ln -sf ./$(call DIRSTODOTS,$(includedir))/$(xorg_includedir)/X11 $(DESTDIR)$(includedir)/X11
	@ln -sf ./$(call DIRSTODOTS,$(libdir))/$(xorg_libdir)/X11         $(DESTDIR)$(libdir)/X11
	@$(MAKECOOKIE)
