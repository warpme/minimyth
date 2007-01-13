################################################################################
# network.mk
################################################################################

NETWORK_IP=$(shell ifconfig eth0 | grep '^ *inet addr:' | sed 's%^ *inet addr:\([^ ]*\) .*%-r \1%')

network: /etc
	ifconfig lo 127.0.0.1
	udhcpc -s /etc/minimyth.d/dhcp.script -i eth0 $(NETWORK_IP)
	portmap -l
	touch network
