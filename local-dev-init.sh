#!/bin/bash

# Exit script on any error
set -e

echo "Updating Fluent Bit configuration..."
docker cp ./fluent-bit/config/fluent-bit.conf fluent-bit:/fluent-bit/etc
docker cp ./fluent-bit/config/parsers.conf fluent-bit:/fluent-bit/etc
docker restart fluent-bit
echo "Fluent Bit restarted."

echo "Updating Loki configuration..."
docker cp ./loki/config/loki-config.yaml loki:/etc/loki
docker restart loki
echo "Loki restarted."

echo "All services updated and restarted successfully."
