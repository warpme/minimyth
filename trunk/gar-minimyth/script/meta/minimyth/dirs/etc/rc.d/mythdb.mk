################################################################################
# mythdb.mk
################################################################################

mythdb: /etc/minimyth.d/minimyth.conf mm_mythdb_setting_update
	cat /etc/minimyth.d/minimyth.conf | grep '^MM_MYTHDB_SETTING_' | sed -e 's%^MM_MYTHDB_SETTING_%%' | \
	while read setting ; do \
		setting_label=`echo "$${setting}" | \
			sed 's%=.*$$%%'     | \
			sed 's%^[ \t]*%%'  | \
			sed 's%[ \t]*$$%%'` ; \
		setting_value=`echo "$${setting}" | \
			sed 's%^[^=]*=%%'  | \
			sed 's%^[ \t]*%%'  | \
			sed 's%[ \t]*$$%%'  | \
			sed 's%^"%%'       | \
			sed 's%"$$%%'       | \
			sed "s%^'%%"       | \
			sed "s%'$$%%"`      ; \
		mm_mythdb_setting_update "$${setting_label}" "$${setting_value}" ; \
	done
	touch mythdb
