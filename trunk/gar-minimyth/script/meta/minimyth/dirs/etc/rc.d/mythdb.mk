################################################################################
# mythdb.mk
################################################################################

mythdb: mythdb-minimyth mythdb-user
	touch mythdb

mythdb-minimyth: mm_mythdb_setting_update
	mm_mythdb_setting_update "CDDevice"          "/dev/cdrom"
	mm_mythdb_setting_update "CDWriterEnabled"   "0"
	mm_mythdb_setting_update "DVDDeviceLocation" "/dev/dvd"
	mm_mythdb_setting_update "EnableXbox"        "0"
	mm_mythdb_setting_update "DecodeExtraAudio"  "0"
	mm_mythdb_setting_update "RealtimePriority"  "1"
	mm_mythdb_setting_update "UseMPEG2Dec"       "0"
	mm_mythdb_setting_update "UseXVMC"           "0"
	mm_mythdb_setting_update "UseXvMcVld"        "1"
	mm_mythdb_setting_update "VCDDeviceLocation" "/dev/cdrom"
	touch mythdb-minimyth

mythdb-user: mm_var_get mm_mythdb_setting_update mythdb-minimyth
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
	touch mythdb-user
