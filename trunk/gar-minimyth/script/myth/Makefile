include ../category.mk

clean-all:
	@$(foreach dir,$(filter-out Makefile,$(wildcard *)),$(MAKE) -C $(dir) clean ; )
	@rm -rf $(DESTDIR)$(bindir)/myth*
	@rm -rf $(DESTDIR)$(datadir)/myth*
	@rm -rf $(DESTDIR)$(includedir)/myth*
	@rm -rf $(DESTDIR)$(libdir)/libmyth*
	@rm -rf $(DESTDIR)$(libdir)/myth*
