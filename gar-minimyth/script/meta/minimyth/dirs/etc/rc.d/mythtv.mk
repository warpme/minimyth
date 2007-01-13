################################################################################
# mythtv.mk
################################################################################
MM_MYTH_DBNAME      = $(shell mm_var_get MM_MYTH_DBNAME)
MM_MYTH_DBPASSWORD  = $(shell mm_var_get MM_MYTH_DBPASSWORD)
MM_MYTH_DBUSERNAME  = $(shell mm_var_get MM_MYTH_DBUSERNAME)
MM_MYTH_SERVER      = $(shell mm_var_get MM_MYTH_SERVER)
MM_TFTP_SERVER      = $(shell mm_var_get MM_TFTP_SERVER)
MM_THEMECACHE_URL   = $(shell mm_var_get MM_THEMECACHE_URL)

MYTH_SERVER     = $(if $(MM_MYTH_SERVER),$(MM_MYTH_SERVER),$(MM_TFTP_SERVER))
MYTH_DBUSERNAME = $(if $(MM_MYTH_DBUSERNAME),$(MM_MYTH_DBUSERNAME),"mythtv")
MYTH_DBPASSWORD = $(if $(MM_MYTH_DBPASSWORD),$(MM_MYTH_DBPASSWORD),"mythtv")
MYTH_DBNAME     = $(if $(MM_MYTH_DBNAME),$(MM_MYTH_DBNAME),"mythconverg")

mythtv: /root/.mythtv /root/.mythtv/mysql.txt /root/.mythtv/themecache
	touch mythtv

/root/.mythtv/themecache: mm_var_get mm_url_mount /root/.mythtv
	rm -rf /root/.mythtv/themecache
	if   [ -z $(MM_THEMECACHE_URL) ] ; then \
		touch /root/.mythtv/themecache ; \
	elif [ "$(MM_THEMECACHE_URL)" = "default" ] ; then \
		mm_url_mount "conf:themecache.tar.bz2" "/root/.mythtv/themecache" ; \
	else \
		mm_url_mount "$(MM_THEMECACHE_URL)"    "/root/.mythtv/themecache" ; \
	fi
	touch /root/.mythtv/themecache

/root/.mythtv/mysql.txt: mm_var_get /root/.mythtv
	rm -rf /root/.mythtv/mysql.txt
	echo "DBHostName=$(MYTH_SERVER)"     >> /root/.mythtv/mysql.txt
	echo "DBUserName=$(MYTH_DBUSERNAME)" >> /root/.mythtv/mysql.txt
	echo "DBPassword=$(MYTH_DBPASSWORD)" >> /root/.mythtv/mysql.txt
	echo "DBName=$(MYTH_DBNAME)"         >> /root/.mythtv/mysql.txt
	touch /root/.mythtv/mysql.txt

/root/.mythtv: /root
	mkdir -p /root/.mythtv
	touch /root/.mythtv
