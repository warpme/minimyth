include ../category.mk

clean-all:
	@$(foreach dir,$(filter-out ./Makefile,$(wildcard ./*)),$(MAKE) -C $(dir) clean-all ; )
