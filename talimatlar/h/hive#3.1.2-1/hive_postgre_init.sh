#!/bin/sh
sudo psql postgres -c 'CREATE USER hiveuser WITH PASSWORD 'hivepass';'
sudo psql postgres -c 'CREATE DATABASE hive_metastore;'

$HIVE_HOME/bin/schematool -dbType postgres -initSchema
