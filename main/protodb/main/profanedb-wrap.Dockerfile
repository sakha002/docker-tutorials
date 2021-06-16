FROM registry.gitlab.com/profanedb/profanedb:develop


VOLUME [ "/var/profanedb/schema" ]

CMD [ "profanedb_server", "-c/usr/local/etc/profanedb/server.conf" ]
