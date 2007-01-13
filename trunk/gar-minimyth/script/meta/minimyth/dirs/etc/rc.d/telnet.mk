################################################################################
# telnet.mk
################################################################################

telnet: utelnetd
	touch telnet

utelnetd: mm_var_get network
	utelnetd -d
	touch utelnetd
