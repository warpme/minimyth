# $(call FETCH_CVS, <cvs_root>, <cvs_module>, <cvs_date>, <file_base>)
FETCH_CVS = \
	mkdir -p $(PARTIALDIR)                                                                  ; \
	cd $(PARTIALDIR)                                                                        ; \
	rm -rf $(strip $(4))                                                                    ; \
	rm -rf $(strip $(4)).tar.bz2                                                            ; \
	cvs -z9 -d:pserver:$(strip $(1)) co -D $(strip $(3)) -d $(strip $(4)) $(strip $(2))     ; \
	if [ ! -d $(strip $(4)) ] ; then                                                          \
		rm -rf $(strip $(4))                                                            ; \
		rm -rf $(strip $(4)).tar.bz2                                                    ; \
		exit 1                                                                          ; \
	fi                                                                                      ; \
	tar --exclude '*/CVS' --exclude '*/.cvsignore' -jcf $(strip $(4)).tar.bz2 $(strip $(4)) ; \
	rm -rf $(strip $(4))


# $(call FETCH_GIT, <git_url>, <git_objectid>, <file_base>)
FETCH_GIT = \
	mkdir -p $(PARTIALDIR)                                                                   ; \
	cd $(PARTIALDIR)                                                                         ; \
	rm -rf $(strip $(3))                                                                     ; \
	rm -rf $(strip $(3)).tar.bz2                                                             ; \
	git clone git://$(strip $(1)) $(strip $(3))                                              ; \
	if [ ! -d $(strip $(3)) ] ; then                                                           \
		rm -rf $(strip $(3))                                                             ; \
		rm -rf $(strip $(3)).tar.bz2                                                     ; \
		exit 1                                                                           ; \
	fi                                                                                       ; \
	cd $(strip $(3))                                                                         ; \
	git checkout -b $(strip $(2)) $(strip $(2))                                              ; \
	cd ..                                                                                    ; \
	tar --exclude '*/.git' --exclude '*/.gitignore' -jcf $(strip $(3)).tar.bz2 $(strip $(3)) ; \
	rm -rf $(strip $(3))

# $(call FETCH_SVN, <svn_url>, <svn_revision>, <file_base>)
FETCH_SVN = \
	mkdir -p $(PARTIALDIR)                                          ; \
	cd $(PARTIALDIR)                                                ; \
	rm -rf $(strip $(3))                                            ; \
	rm -rf $(strip $(3)).tar.bz2                                    ; \
	svn co -r $(strip $(2)) $(strip $(1)) $(strip $(3))             ; \
	if [ $$? -ne 0 ] ; then                                           \
		rm -rf $(strip $(3))                                    ; \
	fi                                                              ; \
	ls -l . ; \
	if [ ! -d $(strip $(3)) ] ; then                                  \
		rm -rf $(strip $(3))                                    ; \
		rm -rf $(strip $(3)).tar.bz2                            ; \
		exit 1                                                  ; \
	fi                                                              ; \
	tar --exclude '*/.svn' -jcf $(strip $(3)).tar.bz2 $(strip $(3)) ; \
	rm -rf $(strip $(3))

clean-image:
	@rm -rf $(COOKIEROOTDIR)/$(DESTIMG).d
	@rm -rf $(WORKROOTDIR)/$(DESTIMG).d
	@rm -rf $(SCRATCHDIR)/$(DESTIMG).d
	@rm -rf $(WORKROOTDIR)/$(DESTIMG).d

garchive-touch:
	@$(if $(strip $(ALLFILES)), touch $(GARCHIVEDIR))

patch-%.gar: gar-patch-%.gar
	@$(MAKECOOKIE)

gar-patch-%:
	@echo " ==> Applying patch $(DOWNLOADDIR)/$*"
	@cat $(DOWNLOADDIR)/$* \
		| sed 's%@GAR_build_DESTDIR@%$(build_DESTDIR)%g' \
		| sed 's%@GAR_build_bindir@%$(build_bindir)%g' \
		| sed 's%@GAR_build_qt3bindir@%$(build_qt3bindir)%g' \
		| sed 's%@GAR_build_qt4bindir@%$(build_qt4bindir)%g' \
		| sed 's%@GAR_build_kdebindir@%$(build_kdebindir)%g' \
		| sed 's%@GAR_DESTDIR@%$(DESTDIR)%g' \
		| sed 's%@GAR_rootdir@%$(rootdir)%g' \
		| sed 's%@GAR_prefix@%$(prefix)%g' \
		| sed 's%@GAR_bindir@%$(bindir)%g' \
		| sed 's%@GAR_datadir@%$(datadir)%g' \
		| sed 's%@GAR_docdir@%$(docdir)%g' \
		| sed 's%@GAR_ebindir@%$(ebindir)%g' \
		| sed 's%@GAR_elibdir@%$(elibdir)%g' \
		| sed 's%@GAR_esbindir@%$(esbindir)%g' \
		| sed 's%@GAR_includedir@%$(includedir)%g' \
		| sed 's%@GAR_libdir@%$(libdir)%g' \
		| sed 's%@GAR_localstatedir@%$(localstatedir)%g' \
		| sed 's%@GAR_mandir@%$(mandir)%g' \
		| sed 's%@GAR_sbindir@%$(sbindir)%g' \
		| sed 's%@GAR_sourcedir@%$(sourcedir)%g' \
		| sed 's%@GAR_sysconfdir@%$(sysconfdir)%g' \
		| sed 's%@GAR_qt3prefix@%$(qt3prefix)%g' \
		| sed 's%@GAR_qt3bindir@%$(qt3bindir)%g' \
		| sed 's%@GAR_qt3includedir@%$(qt3includedir)%g' \
		| sed 's%@GAR_qt3libdir@%$(qt3libdir)%g' \
		| sed 's%@GAR_qt4prefix@%$(qt4prefix)%g' \
		| sed 's%@GAR_qt4bindir@%$(qt4bindir)%g' \
		| sed 's%@GAR_qt4includedir@%$(qt4includedir)%g' \
		| sed 's%@GAR_qt4libdir@%$(qt4libdir)%g' \
		| sed 's%@GAR_kdeprefix@%$(kdeprefix)%g' \
		| sed 's%@GAR_kdebindir@%$(kdebindir)%g' \
		| sed 's%@GAR_kdedatadir@%$(kdedatadir)%g' \
		| sed 's%@GAR_kdeincludedir@%$(kdeincludedir)%g' \
		| sed 's%@GAR_kdelibdir@%$(kdelibdir)%g' \
		| sed 's%@GAR_GARCH_FAMILY@%$(GARCH_FAMILY)%g' \
		| sed 's%@GAR_CPP@%$(CPP)%g' \
		| sed 's%@GAR_CC@%$(CC)%g' \
		| sed 's%@GAR_CXX@%$(CXX)%g' \
		| sed 's%@GAR_LD@%$(LD)%g' \
		| sed 's%@GAR_AS@%$(AS)%g' \
		| sed 's%@GAR_AR@%$(AR)%g' \
		| sed 's%@GAR_RANLIB@%$(RANLIB)%g' \
		| sed 's%@GAR_NM@%$(NM)%g' \
		| sed 's%@GAR_STRIP@%$(STRIP)%g' \
		| sed 's%@GAR_CPPLAGS@%$(CPPFLAGS)%g' \
		| sed 's%@GAR_CFLAGS@%$(CFLAGS)%g' \
		| sed 's%@GAR_CXXFLAGS@%$(CXXFLAGS)%g' \
		| sed 's%@GAR_LDFLAGS@%$(LDFLAGS)%g' \
		| $(GARPATCH)
	@$(MAKECOOKIE)
