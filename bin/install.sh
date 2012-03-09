#!/bin/bash

cd $(dirname $0)"/../"

cp package/fluent-agent-lite.init /etc/init.d/fluent-agent-lite
chmod +x /etc/init.d/fluent-agent-lite

cp package/fluent-agent-lite.conf /etc/fluent-agent-lite.conf

