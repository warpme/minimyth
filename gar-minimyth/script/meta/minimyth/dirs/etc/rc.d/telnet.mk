################################################################################
# telnet.mk
################################################################################

telnet: utelnetd
	touch telnet

utelnetd: network /dev
	utelnetd -d
	touch utelnetd
