# $(call FETCH_CVS, <cvs_root>, <cvs_module>, <cvs_date>, <file_base>)
FETCH_CVS = \
	mkdir -p $(PARTIALDIR)                                                              ; \
	cd $(PARTIALDIR)                                                                    ; \
	rm -rf $(strip $(4))                                                                ; \
	rm -rf $(strip $(4)).tar.bz2                                                        ; \
	cvs -z9 -d:pserver:$(strip $(1)) co -D $(strip $(3)) -d $(strip $(4)) $(strip $(2)) ; \
	if [ ! -d $(strip $(4)) ] ; then                                                      \
		rm -rf $(strip $(4))                                                        ; \
		rm -rf $(strip $(4)).tar.bz2                                                ; \
		exit 1                                                                      ; \
	fi                                                                                  ; \
	tar --exclude '*/.svn' -jcf $(strip $(4)).tar.bz2 $(strip $(4))                     ; \
	rm -rf $(strip $(4))


# $(call FETCH_SVN, <svn_url>, <svn_revision>, <file_base>)
FETCH_SVN = \
	mkdir -p $(PARTIALDIR)                                          ; \
	cd $(PARTIALDIR)                                                ; \
	rm -rf $(strip $(3))                                            ; \
	rm -rf $(strip $(3)).tar.bz2                                    ; \
	svn co -r $(strip $(2)) $(strip $(1)) $(strip $(3))             ; \
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

patch-%.gar: gar-patch-%.gar
	@$(MAKECOOKIE)

gar-patch-%:
	@echo " ==> Applying patch $(DOWNLOADDIR)/$*"
	@cat $(DOWNLOADDIR)/$* \
		| sed 's%@GAR_DESTDIR@%$(DESTDIR)%g' \
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
		| sed 's%@GAR_sysconfdir@%$(sysconfdir)%g' \
		| sed 's%@GAR_CFLAGS@%$(CFLAGS)%g' \
		| sed 's%@GAR_CXXFLAGS@%$(CFLAGS)%g' \
		| $(GARPATCH)
	@$(MAKECOOKIE)
