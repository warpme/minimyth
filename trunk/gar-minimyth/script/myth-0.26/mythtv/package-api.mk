MYTHTV_GARVERSION = 0.26-20121123-10479af

MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_CONFIGURE_ENV = \
	PYTHONXCPREFIX=$(DESTDIR)$(prefix)
MYTHTV_BUILD_ENV     =
MYTHTV_INSTALL_ENV   = \
	INSTALL_ROOT="/" \

MYTHTV_PLUGINS_CONFIGURE_ARGS = \
	--prefix="$(DESTDIR)$(prefix)" \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--qmake="$(DESTDIR)$(qt4bindir)/qmake" \
	--libdir-name="$(patsubst $(prefix)/%,%,$(libdir))" \
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
