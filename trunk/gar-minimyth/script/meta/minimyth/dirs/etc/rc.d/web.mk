################################################################################
# web.script
################################################################################

web: webfsd
	touch web

webfsd: network
	webfsd -u 0 -g 0 -p 80 -f index.html -r /etc/www -x /cgi -s
	touch webfsd
