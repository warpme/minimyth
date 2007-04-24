GARNAME = xorg
GARVERSION = $(XORG_VERSION)
CATEGORIES = $(CATEGORY)
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	$(CATEGORY)/font-alias \
	$(CATEGORY)/font-bh-ttf \
	$(CATEGORY)/font-cursor-misc \
	$(CATEGORY)/font-misc-misc \
	$(CATEGORY)/iceauth \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXdamage \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfixes \
	$(CATEGORY)/libXft \
	$(CATEGORY)/libXinerama \
	$(CATEGORY)/libXmu \
	$(CATEGORY)/libXpm \
	$(CATEGORY)/libXrandr \
	$(CATEGORY)/libXrender \
	$(CATEGORY)/libXres \
	$(CATEGORY)/libXt \
	$(CATEGORY)/libXtst \
	$(CATEGORY)/libXxf86dga \
	$(CATEGORY)/Mesa \
	$(CATEGORY)/mkfontdir \
	$(CATEGORY)/mkfontscale \
	$(CATEGORY)/rgb \
	$(CATEGORY)/xdpyinfo \
	$(CATEGORY)/xf86-input-keyboard \
	$(CATEGORY)/xf86-input-mouse \
	$(CATEGORY)/xf86-video-ati \
	$(CATEGORY)/xf86-video-i810 \
	$(CATEGORY)/xf86-video-openchrome \
	$(CATEGORY)/xf86-video-vmware \
	$(CATEGORY)/xinit \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xset \
	$(CATEGORY)/xsetroot

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
