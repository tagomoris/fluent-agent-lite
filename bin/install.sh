#!/bin/bash

set -e

ARG="$1"
CLEAN=
if [ "x"$ARG = "xclean" ]; then
    CLEAN="y"
fi

cd $(dirname $0)"/../"

SOURCEDIR=$(pwd)

# PREFIX is to override system root. (for packaging)
if [ "x"$PREFIX = "x" ]; then
    PREFIX=
fi
INSTALLDIR=$PREFIX/usr/local/fluent-agent-lite

if [ "x"$PERL_PATH = "x" ]; then
    PERL_PATH="perl"
fi

if [ -d $INSTALLDIR -a "x"$CLEAN = "xy" ]; then
    rm -rf $INSTALLDIR
fi

mkdir -p $INSTALLDIR
cp -rp bin lib Makefile.PL cpanfile $INSTALLDIR

cd $INSTALLDIR

WGET_PATH=$(which wget)
if [ "x"$WGET_PATH = "x" ]; then
    curl -s -L http://cpanmin.us/ | $PERL_PATH - -Lextlib Carton
else
    wget -q -O - http://cpanmin.us/ | $PERL_PATH - -Lextlib Carton
fi

$PERL_PATH $INSTALLDIR/extlib/bin/carton install

cd $SOURCEDIR

mkdir -p $PREFIX/etc/init.d
cp package/fluent-agent-lite.init $PREFIX/etc/init.d/fluent-agent-lite
chmod +x $PREFIX/etc/init.d/fluent-agent-lite

if [ ! -f $PREFIX/etc/fluent-agent-lite.conf -o "x"$CLEAN = x"y" ]; then
    cp package/fluent-agent-lite.conf $PREFIX/etc/fluent-agent-lite.conf
fi
