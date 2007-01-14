GARNAME = corefonts
GARVERSION =
CATEGORIES = X11
MASTER_SITES  = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
MASTER_SITES += http://corefonts.sourceforge.net/
FONTFILES = \
	andale32.exe \
	arial32.exe \
	arialb32.exe \
	comic32.exe \
	courie32.exe \
	georgi32.exe \
	impact32.exe \
	times32.exe \
	trebuc32.exe \
	verdan32.exe \
	wd97vwr32.exe \
	webdin32.exe
DISTFILES = $(FONTFILES) eula.htm
LICENSE = corefonts
corefonts_LICENSE_TEXT = $(WORKSRC)/eula.htm

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c
BUILDDEPS = utils/cabextract

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

extract-%.exe:
	@mkdir -p $(WORKSRC)
	@cp -f $(DOWNLOADDIR)/$*.exe $(WORKSRC)
	@$(MAKECOOKIE)

extract-%.htm:
	@mkdir -p $(WORKSRC)
	@cp -f $(DOWNLOADDIR)/$*.htm $(WORKSRC)
	@$(MAKECOOKIE)

build-custom:
	@cd $(WORKSRC) ; $(foreach file, $(FONTFILES), cabextract $(file) ; )
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp $(WORKSRC)/*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp $(WORKSRC)/*.TTF $(DESTDIR)$(libdir)/X11/fonts/TTF
	@$(MAKECOOKIE)
