################################################################################
# log.mk
################################################################################

log: syslogd klogd
	touch log

syslogd: /var/log
	syslogd
	touch syslogd

klogd: /var/log
	klogd
	touch klogd

/var/log: /var
	mkdir -p /var/log
	touch /var/log
