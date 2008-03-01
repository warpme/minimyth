MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_SVN_VERSION = $(mm_MYTH_TRUNK_VERSION)
MYTHTV_SVN_BRANCH = trunk

GARVERSION_SHORT = trunk
DISTNAME_SHORT   = $(GARNAME)-$(GARVERSION_SHORT)

MYTHTV_CONFIGURE_ENV = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
MYTHTV_BUILD_ENV     = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
MYTHTV_INSTALL_ENV   = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

post-install-mythtv-version:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION_SHORT) through SVN $(MYTHTV_SVN_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
