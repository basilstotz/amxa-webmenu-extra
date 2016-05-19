#
# Regular cron jobs for the amxa-webmenu-extra package
#
0 4	* * *	root	[ -x /usr/bin/amxa-webmenu-extra_maintenance ] && /usr/bin/amxa-webmenu-extra_maintenance
