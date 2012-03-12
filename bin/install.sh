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

cp -rp bin lib Makefile.PL $INSTALLDIR

cd $INSTALLDIR

perl $SOURCEDIR/bin/cpanm -n inc::Module::Install
perl $SOURCEDIR/bin/cpanm -Lextlib -n --installdeps .

cd $SOURCEDIR

cp package/fluent-agent-lite.init /etc/init.d/fluent-agent-lite
chmod +x /etc/init.d/fluent-agent-lite

if [ ! -f /etc/fluent-agent-lite.conf -o "x"$CLEAN = x"y" ]; then
    cp package/fluent-agent-lite.conf /etc/fluent-agent-lite.conf
fi
