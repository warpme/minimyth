MYTHTV_GARVERSION_SHORT = trunk
MYTHTV_SVN_VERSION      = $(mm_MYTH_TRUNK_VERSION)

MYTHTV_VERSION = $(MYTHTV_GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)

MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_CONFIGURE_ENV = \
	PYTHONXCPREFIX=$(DESTDIR)$(prefix)
MYTHTV_BUILD_ENV     =
MYTHTV_INSTALL_ENV   = \
	INSTALL_ROOT=$(DESTDIR)

MYTHTV_PLUGINS_CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--qmake="$(DESTDIR)$(qt4bindir)/qmake" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl

post-install-mythtv-version:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(MYTHTV_GARVERSION_SHORT) through SVN $(MYTHTV_SVN_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
