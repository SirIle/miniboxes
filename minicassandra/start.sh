#!/bin/sh
sed -i "s/^listen_address:.*/listen_address:/" /cassandra/conf/cassandra.yaml
sed -i "s/^\(\s*\)- seeds:.*/\1- seeds: \"$1\"/" /cassandra/conf/cassandra.yaml
sed -i "s/^rpc_address:.*/rpc_address: 0.0.0.0/" /cassandra/conf/cassandra.yaml
sed -i "s/^# broadcast_rpc_address:.*/broadcast_rpc_address: $(hostname -i)/" /cassandra/conf/cassandra.yaml
exec /cassandra/bin/cassandra -f
