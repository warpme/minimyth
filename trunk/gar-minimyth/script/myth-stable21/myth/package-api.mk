MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_STABLE21_FIXES_VERSION = 16317

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

MYTHTV_USE_RELEASE_TARBALL = no

mythtv-fixes-patch:
	@mkdir -p $(PARTIALDIR)
	@$(MAKE) $(DOWNLOADDIR)/$(DISTNAME).tar.bz2
	@$(call FETCH_SVN, \
		http://svn.mythtv.org/svn/branches/release-0-21-fixes/$(GARNAME), \
		$(MYTHTV_STABLE21_FIXES_VERSION),  \
		$(GARNAME)-$(MYTHTV_STABLE21_FIXES_VERSION))
	@rm -rf $(WORKDIR)/fixes-patch
	@mkdir -p $(WORKDIR)/fixes-patch
	@tar -jxf $(DOWNLOADDIR)/$(DISTNAME).tar.bz2 -C $(WORKDIR)/fixes-patch
	@tar -jxf $(PARTIALDIR)/$(GARNAME)-$(MYTHTV_STABLE21_FIXES_VERSION).tar.bz2 -C $(WORKDIR)/fixes-patch
	@cd $(WORKDIR)/fixes-patch ; \
		mv $(DISTNAME) $(DISTNAME)-old
	@cd $(WORKDIR)/fixes-patch ; \
		mv $(GARNAME)-$(MYTHTV_STABLE21_FIXES_VERSION) $(DISTNAME)-new
	@cd $(WORKDIR)/fixes-patch ; \
		diff -Naur -x 'mytharchive' $(DISTNAME)-old $(DISTNAME)-new > $(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch || true
	@if [ -w files/$(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch ] ; then \
		rm -f files/$(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch ; \
	 fi
	@if [ -e files/$(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch ] ; then \
		echo "error: cannot remove existing patch file from the files directory" ; \
		exit 1 ; \
	 fi
	@cp $(WORKDIR)/fixes-patch/$(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch files/
	@if [ ! -w checksums ] ; then \
		echo "error: cannot write the patch file checksum to the checksum file" ; \
		exit 1 ; \
	 fi
	@cat checksums \
		| sed 's%^.*download/$(DISTNAME)-fixes-.*\.patch%%' \
		| grep 'download' \
		> $(WORKDIR)/fixes-patch/checksums~
	@mv -f $(WORKDIR)/fixes-patch/checksums~ checksums
	@md5sum files/$(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch >> checksums
	@sed -i 's%files/\($(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch\)%download/\1%' checksums
	@rm -rf $(WORKDIR)/fixes-patch
