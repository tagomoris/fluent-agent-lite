#!/bin/bash

ARG="$1"
CLEAN=
if [ "x"$ARG = "xclean" ]; then
    CLEAN="y"
fi

cd $(dirname $0)"/../"

SOURCEDIR=$(pwd)

if [ "x"$PREFIX = "x" ]; then
    PREFIX=
fi
INSTALLDIR=$PREFIX/usr/local/fluent-agent-lite

if [ -d $INSTALLDIR -a "x"$CLEAN = "xy" ]; then
    rm -rf $INSTALLDIR
fi

mkdir -f -p $PREFIX$INSTALLDIR

cp -rp bin lib Makefile.PL $PREFIX$INSTALLDIR

cd $PREFIX$INSTALLDIR

perl $SOURCEDIR/bin/cpanm -n inc::Module::Install
perl $SOURCEDIR/bin/cpanm -Lextlib -n --installdeps .

cd $SOURCEDIR

cp package/fluent-agent-lite.init $PREFIX/etc/init.d/fluent-agent-lite
chmod +x $PREFIX/etc/init.d/fluent-agent-lite

if [ ! -f /etc/fluent-agent-lite.conf -o "x"$CLEAN = x"y" ]; then
    cp package/fluent-agent-lite.conf $PREFIX/etc/fluent-agent-lite.conf
fi
