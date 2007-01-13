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
