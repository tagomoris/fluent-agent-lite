#!/bin/bash

set -e

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

if [ "x"$PERL_PATH = "x" ]; then
    PERL_PATH="perl"
fi

if [ -d $INSTALLDIR -a "x"$CLEAN = "xy" ]; then
    rm -rf $INSTALLDIR
fi

mkdir -p $INSTALLDIR

cp -rp bin lib Makefile.PL $INSTALLDIR

cd $INSTALLDIR

export PERL_CPANM_OPT="--local-lib=~/perl5"
$PERL_PATH $SOURCEDIR/bin/cpanm -n -lextlib inc::Module::Install
$PERL_PATH $SOURCEDIR/bin/cpanm -n -lextlib --reinstall --installdeps .

cd $SOURCEDIR

mkdir -p $PREFIX/etc/init.d
cp package/fluent-agent-lite.init $PREFIX/etc/init.d/fluent-agent-lite
chmod +x $PREFIX/etc/init.d/fluent-agent-lite

if [ ! -f $PREFIX/etc/fluent-agent-lite.conf -o "x"$CLEAN = x"y" ]; then
    cp package/fluent-agent-lite.conf $PREFIX/etc/fluent-agent-lite.conf
fi
