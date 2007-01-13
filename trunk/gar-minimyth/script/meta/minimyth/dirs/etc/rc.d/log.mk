################################################################################
# log.mk
################################################################################

log: syslogd klogd
	touch log

syslogd: /dev /var/log
	syslogd
	touch syslogd

klogd: /proc /var/log
	klogd
	touch klogd
