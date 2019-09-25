#!/bin/bash

if [ ! -d /data/blast-indexer ]; then
    mkdir -p /data/blast-indexer
fi

echo "Starting Blast..."
blast indexer start \
    --grpc-address=:5000 \
    --grpc-gateway-address=:6000 \
    --http-address=:8000 \
    --node-id=$NODE_ID \
    --node-address=:2000 \
    --data-dir=/data/blast-indexer \
    --raft-storage-type=boltdb \
    --index-type=upside_down \
    --index-storage-type=boltdb
    # --index-mapping-file=./example/wiki_index_mapping.json \

