MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_SVN_VERSION = 18314
MYTHTV_SVN_BRANCH = branches/release-0-21-fixes

GARVERSION_SHORT = 0.21
DISTNAME_SHORT   = $(GARNAME)-$(GARVERSION_SHORT)

MYTHTV_CONFIGURE_ENV = \
	QTDIR="$(DESTDIR)$(qt3prefix)"
MYTHTV_BUILD_ENV     = \
	QTDIR="$(DESTDIR)$(qt3prefix)"
MYTHTV_INSTALL_ENV   = \
	QTDIR="$(DESTDIR)$(qt3prefix)" \
	INSTALL_ROOT="$(DESTDIR)"

post-install-mythtv-version:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION_SHORT) with fixes through SVN $(MYTHTV_SVN_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)

myth-update-source:
	@$(MAKE) clean
	@$(MAKE) fetch
	@$(MAKE) $(GARCHIVEDIR)/$(DISTNAME).tar.bz2
	@$(MAKE) clean

myth-update-patches:
	@$(MAKE) clean
	@$(MAKE) extract
	@$(foreach PATCHFILE, $(PATCHFILES), \
		cd $(WORKDIR) || exit 1 ; \
		mv $(DISTNAME) $(DISTNAME)-old || exit 1 ; \
		cp -r $(DISTNAME)-old $(DISTNAME)-new || exit 1 ; \
		cd $(DISTNAME)-new || exit 1 ; \
		SIMPLE_BACKUP_SUFFIX=.gar-myth-patches-update patch -p1 < ../../../files/$(PATCHFILE) || exit 1 ; \
		cd ../ || exit 1 ; \
		find $(DISTNAME)-new -name *.gar-myth-patches-update -exec rm {} \; || exit 1 ; \
		( diff -Naur $(DISTNAME)-old $(DISTNAME)-new > ../../files/$(PATCHFILE) ; test $$? -lt 2 ) || exit 1 ; \
		rm -fr $(DISTNAME)-old || exit 1 ; \
		mv $(DISTNAME)-new $(DISTNAME) || exit 1 ; \
		cd ../../ || exit 1 ; \
		rm -f checksums~ || exit 1 ; \
		cat checksums | grep -v $(DOWNLOADDIR)/$(PATCHFILE) > checksums~ || exit 1 ; \
		md5sum $(DOWNLOADDIR)/$(PATCHFILE) >> checksums~ || exit 1 ; \
		rm -f checksums || exit 1 ; \
		mv -f checksums~ checksums || exit 1 ; )
	@$(MAKE) clean
