# fluent-agent-lite

* http://github.com/tagomoris/fluent-agent-lite

## DESCRIPTION

'fluent-agent-lite' is a log transfer agent, for Fluentd's 'forward' input.

This agent reads specified files, and sends each lines to fluentd servers. One log line will be packed one fluentd message, that has one attribute ('message' or specified in configuration) with entire line (not terminated by newline).

### VERSION

0.9 http://tagomoris.github.io/tarballs/fluent-agent-lite.v0.9.tar.gz

## PACKAGING TARBALL

To get tarball of latest tagged version:

    make -f Makefile.package

Got tarball on `tmp/archive/fluent-agent-lite.vX.Y.tar.gz`.

To do this, versions (tags) MUST be v1.0 not but v0.10 for sorting order...

## INSTALL

On RHEL/CentOS, you can use .spec file to build rpm with your customized default config file.

### RHEL/CentOS

To build your rpm package, do 5 steps below.

1. Download (newest version) tarball, and place it on SOURCES/ .
2. Download package/fluent-agent-lite.conf, and place it on SOURCES/ .
3. Fix SOURCES/package/fluent-agent-lite.conf as you want (ex: server name or servers list), and add servers list for your own.
4. Download SPECS/fluent-agent-lite.spec, and place it on SPECS/ .
5. run 'rpmbuild -ba SPECS/fluent-agent-lite.spec'

To install each RHEL/CentOS host, use yum server, or copy and rpm -i on each host.

NOTE: `yum install perl-devel` and `QA_RPATHS=$[0x001] rpmbuild -ba` may help you if `rpmbuild` fails on your build environment.

### Other Linux or Unix-like OS

On each host, do steps below.

1. Download and extract tarball, or clone repository, and move into extracted directory.
2. Do 'bin/install.sh'.

## Configuration

All of configurations are written in configuration shell-script file (/etc/fluent-agent-lite.conf). Configurable values are below:

### LOGS

Pairs of tag and file, such as:

    LOGS=$(cat <<"EOF"
    www     /var/log/nginx/www_access.log
    app     /var/log/apache2/app_access.log
    EOF

Or, you can use this syntax:

    LOGS=$(cat /etc/fluent-agent.logs)
    
    ## in fluent-agent.logs
    www  /var/log/nginx/www_access.log
    app  /var/log/apache2/app_access.log

### TAG_PREFIX

Prefix of each tags, specified in 'LOGS'. 'TAG_PREFIX="service"' with 'LOGS' above, you will get fluentd messages with tags 'service.www' and 'service.app'.

### FIELD_NAME

Log line attribute name in fluentd message (default: 'message').

### PRIMARY_SERVER, SECONDARY_SERVER

Fluentd server name and port (SERVERNAME:PORT), as primary server. 'fluent-agent-lite' try to connect to primary server at first, and if fails, then try to connect secondary server (if it specified).

Default port is 24224 (if omitted).

### PRIMARY_SERVERS_LIST, SECONDARY_SERVERS_LIST

File path to specify primary(secondary) servers' list. 'fluent-agent-lite' reads this file when executed, and choose one of servers randomly at each connection trial.

You cannot specify both of 'PRIMARY\_SERVER' and 'PRIMARY\_SERVERS\_LIST', and both of 'SECONDARY\_SERVER' and 'SECONDARY\_SERVERS\_LIST'

### READ_BUFFER_SIZE

Bytes size which 'fluent-agent-lite' try to read from 'tail' at once (Default: 1MB).

### PROCESS_NICE

Nice value for 'fluent-agent-lite'. If you want to execute fluent-agent-lite in server with high loadavg, 'PROCESS_NICE="-1"' can help you.

### TAIL_PATH

Path of tail command (Default: /usr/bin/tail).

### TAIL_INTERVAL

'sleep interval' of tail command in seconds (Default: 1.0). For high throughput log file, you can specify 'TAIL_INTERVAL="0.5"' or any other values (but over "0.1").

Caution: This cofiguration is for GNU tail only.

### PING_TAG, PING_DATA, PING_INTERVAL

Ping message tag/data and emit interval specification. Without PING\_TAG, fluent-agent-lite doesn't emit ping\_messages.

Actual 'data' field of ping message is 'PING_DATA PATH\_OF\_INPUT\_FILE'.

### DRAIN_LOG_TAG

Tag name of drain\_log (messages count per drain/send to server), which is emitted to configured fluentd sever as fluentd message. Default is none (not to send drain\_log).

### KEEPALIVE_TIME

Connection keepalive time in seconds. 0 means infinity (Default: 1800, minimum: 120)

### LOG_PATH

Log file path for 'fluent-agent-lite' (Default: /tmp/fluent-agent.log).

### LOG_VERBOSE

If you specify 'LOG_VERBOSE="yes"', 'fluent-agent-lite' writes logs with level info/debug (Default: warn/crit only).

## Run

With properly configured '/etc/fluent-agent-lite.conf', you can run and stop all transfer agent as below.

    # /etc/init.d/fluent-agent-lite start
    # /etc/init.d/fluent-agent-lite restart
    # /etc/init.d/fluent-agent-lite stop

Check running processes:

    # /etc/init.d/fluent-agent-lite status

And reset fluentd connections of each processes. (To re-connect primary server instead of secondary server immediately.)

    # /etc/init.d/fluent-agent-lite reload

To reflect change of config file, you must do 'restart'.

* * * * *

## License

Copyright 2012- TAGOMORI Satoshi (tagomoris)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
