#!/bin/bash

ARG="$1"
FORCE=
if [ "x"$ARG = "x-f" ]; then
    FORCE="y"
fi

cd $(dirname $0)"/../"

SOURCEDIR=$(cd)

PREFIX=/usr/local
INSTALLDIR=$PREFIX/fluent-agent-lite

mkdir $INSTALLDIR

cp -rp bin lib extlib $INSTALLDIR

cd $INSTALLDIR

$SOURCEDIR/bin/cpanm inc::Module::Install
$SOURCEDIR/bin/cpanm -Lextlib -n --installdeps .

cd $SOURCEDIR

cp package/fluent-agent-lite.init /etc/init.d/fluent-agent-lite
chmod +x /etc/init.d/fluent-agent-lite

if [ ! -f /etc/fluent-agent-lite.conf -o "x"$FORCE = x"y" ]; 
    cp package/fluent-agent-lite.conf /etc/fluent-agent-lite.conf
fi
