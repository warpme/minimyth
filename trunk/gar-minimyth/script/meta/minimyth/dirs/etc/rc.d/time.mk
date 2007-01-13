################################################################################
# time.mk
################################################################################

MM_TIME_SERVER = $(shell mm_var_get MM_TIME_SERVER)

time: /etc/localtime ntpdate ntpd

/etc/localtime: mm_conf_get /etc
	mm_conf_get /localtime /etc/localtime
	touch /etc/localtime

ntpdate: mm_var_get network
	if [ -n $(MM_TIME_SERVER) ] ; then \
		ntpdate $(MM_TIME_SERVER) ; \
	fi
	touch ntpdate

ntpd: mm_var_get network ntpdate /etc
	if [ -n $(MM_TIME_SERVER) ] ; then \
		echo "server $(MM_TIME_SERVER)" > /etc/ntp.conf ; \
		ntpd ; \
	fi
