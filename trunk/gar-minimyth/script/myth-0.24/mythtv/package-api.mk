MYTHTV_GARVERSION = 0.24-20110623-30993d6-931028f

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
	@rm -rf     $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n "$(MYTHTV_GARVERSION) "                                                  >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n "("                                                                      >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n "$(word 1,$(subst -, ,$(MYTHTV_GARVERSION)))"                            >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n " through "                                                              >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n "mythtv git repo commit $(word 3,$(subst -, ,$(MYTHTV_GARVERSION)))"     >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n " and "                                                                  >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo -n "myththemes git repo commit $(word 4,$(subst -, ,$(MYTHTV_GARVERSION)))" >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@echo    ")"                                                                      >> $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
