include ../../gar.mk

clean-all:
	@$(foreach dir, $(wildcard ../../myth-*), $(MAKE) clean-all -C $(dir)/myth ; )
	@$(MAKE) clean
