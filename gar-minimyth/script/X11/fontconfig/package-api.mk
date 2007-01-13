FONTCONFIG_ADD_FONTDIR = sed -i "s%</fontconfig>%<dir>$(1)</dir>\n</fontconfig>%" $(DESTDIR)$(sysconfdir)/fonts/fonts.conf
