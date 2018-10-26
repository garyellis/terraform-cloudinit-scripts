#!/bin/bash

# yes we're pointing to latest right now.

docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /host/rancher:/var/lib/rancher \
  -e AUDIT_LEVEL=1 \
  -e AUDIT_LOG_PATH=/var/log/auditlog/rancher-api-audit.log \
  -e AUDIT_LOG_MAXAGE=20 \
  -e AUDIT_LOG_MAXBACKUP=20 \
  -e AUDIT_LOG_MAXSIZE=100 \
  rancher/rancher:latest
