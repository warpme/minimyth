################################################################################
# commands.mk
################################################################################

COMMANDS = \
	mm_command_run \
	mm_conf_get \
	mm_dir_make_rw \
	mm_mythdb_command_run \
	mm_mythdb_setting_dump \
	mm_mythdb_setting_update \
	mm_url_mount \
	mm_var_get

commands: $(COMMANDS)
	touch commands

mm_command_run:
	touch mm_command_run

mm_conf_get: network
	touch mm_conf_get

mm_dir_make_rw: fs-modules /var/unionfs
	touch mm_dir_make_rw

mm_mythdb_command_run: network /root/.mythtv/mysql.txt
	touch mm_mythdb_setting_run

mm_mythdb_setting_dump: mm_mythdb_command_run
	touch mm_mythdb_setting_dump

mm_mythdb_setting_update: mm_mythdb_command_run
	touch mm_mythdb_setting_update

mm_url_mount: network mm_dir_make_rw
	touch mm_url_mount

mm_var_get: /etc/minimyth.d/minimyth.conf
	touch mm_var_get
