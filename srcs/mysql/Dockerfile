# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rgilles <rgilles@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/15 15:23:02 by rgilles           #+#    #+#              #
#    Updated: 2021/03/15 15:23:04 by rgilles          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

RUN		apk add --no-cache mariadb screen
RUN		apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY	./telegraf.conf /etc/telegraf/telegraf.conf

COPY my.cnf /etc/mysql/my.cnf
COPY setup.sh /tmp/setup.sh
COPY db.sql /tmp/db.sql
COPY db1.sql /tmp/db1.sql

EXPOSE	3306
CMD /tmp/setup.sh