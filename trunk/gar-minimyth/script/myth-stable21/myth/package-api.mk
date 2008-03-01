MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_SVN_VERSION = 16317
MYTHTV_SVN_BRANCH = branches/release-0-21-fixes

GARVERSION_SHORT = 0.21
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
	@echo "$(GARVERSION_SHORT) with fixes through SVN $(MYTHTV_SVN_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
