#!/bin/bash

ARG="$1"
CLEAN=
if [ "x"$ARG = "xclean" ]; then
    CLEAN="y"
fi

cd $(dirname $0)"/../"

SOURCEDIR=$(pwd)

PREFIX=/usr/local
INSTALLDIR=$PREFIX/fluent-agent-lite

if [ -d $INSTALLDIR -a "x"$CLEAN = "xy" ]; then
    rm -rf $INSTALLDIR
fi

mkdir $INSTALLDIR

cp -rp bin lib $INSTALLDIR

cd $INSTALLDIR

$SOURCEDIR/bin/cpanm inc::Module::Install
$SOURCEDIR/bin/cpanm -Lextlib -n --installdeps .

cd $SOURCEDIR

cp package/fluent-agent-lite.init /etc/init.d/fluent-agent-lite
chmod +x /etc/init.d/fluent-agent-lite

if [ ! -f /etc/fluent-agent-lite.conf -o "x"$CLEAN = x"y" ]; then
    cp package/fluent-agent-lite.conf /etc/fluent-agent-lite.conf
fi
