GARNAME = perl-stub
GARVERSION =
CATEGORIES = utils
MASTER_SITES =
DISTFILES = Makefile perl.c
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

include ../../gar.mk

extract-Makefile:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/Makefile $(WORKSRC)/
	@$(MAKECOOKIE)

extract-perl.c:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/perl.c $(WORKSRC)/
	@$(MAKECOOKIE)
