PATCHDIR = $(WORKSRC)

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
		| sed 's%@DESTDIR@%$(DESTDIR)%g' \
		| sed 's%@prefix@%$(prefix)%g' \
		| sed 's%@bindir@%$(bindir)%g' \
		| sed 's%@datadir@%$(datadir)%g' \
		| sed 's%@includedir@%$(includedir)%g' \
		| sed 's%@libdir@%$(libdir)%g' \
		| sed 's%@x11libdir@%$(x11libdir)%g' \
		| sed 's%@CFLAGS@%$(CFLAGS)%g' \
		| sed 's%@CXXFLAGS@%$(CFLAGS)%g' \
		| $(GARPATCH)
	@$(MAKECOOKIE)
