# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rgilles <rgilles@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/19 05:20:28 by rgilles           #+#    #+#              #
#    Updated: 2021/03/19 05:20:31 by rgilles          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
if [ -d /root/.influxdb/data ]; then
	echo "[i] InfluxDB directory already present, skipping DB creation."
	screen -dmS influxd_screen
	screen -S influxd_screen -X stuff 'influxd\n'
	sleep 5
else
	echo "[i] InfluxDB data directory is not found, creating initial DB(s)..."

	# need to launch influxd in screen since there's no way to get access to
	# terminal after it's launched
	screen -dmS influxd_screen
	screen -S influxd_screen -X stuff 'influxd\n'
	sleep 15
		influx -execute "CREATE USER admin WITH PASSWORD '$IDB_ROOTPW' WITH ALL PRIVILEGES" && echo "[i] admin user created"
	influx -execute "CREATE DATABASE influx_db" && echo "[i] Database created"
	influx -execute "CREATE USER $IDB_USER WITH PASSWORD '$IDB_PASSWORD'" && echo "[i] $IDB_USER user created with password $IDB_PASSWORD"
	influx -execute "GRANT ALL ON influx_db TO $IDB_USER" && echo "[i] DB permissions granted to user $IDB_USER"
fi

telegraf
