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

mkdir tmp

WGET_PATH=$(which wget)
if [ "x"$WGET_PATH = "x" ]; then
    curl -s -L -O tmp/cpanm http://cpanmin.us/
else
    wget -q -O tmp/cpanm http://cpanmin.us/
fi

TMP_PERL_CPANM_OPTS=
if $PERL_PATH -e 'require Module::CoreList;' 2>/dev/null; then
    # do nothing (perl is any version with Module::CoreList)
    TMP_PERL_CPANM_OPTS=""
else
    cat tmp/cpanm | $PERL_PATH - -l tmp/module-corelist Module::CoreList
    TMP_PERL_CPANM_OPTS="-I tmp/module-corelist/lib/perl5"
fi
cat tmp/cpanm | $PERL_PATH $TMP_PERL_CPANM_OPTS -- - -n -Lextlib Module::CoreList App::cpanminus Carton
rm -rf tmp

export PATH=$INSTALLDIR/extlib/bin:$PATH
export PERL5OPT=-Iextlib/lib/perl5
extlib/bin/carton install

cd $SOURCEDIR

mkdir -p $PREFIX/etc/init.d
cp package/fluent-agent-lite.init $PREFIX/etc/init.d/fluent-agent-lite
chmod +x $PREFIX/etc/init.d/fluent-agent-lite

if [ ! -f $PREFIX/etc/fluent-agent-lite.conf -o "x"$CLEAN = x"y" ]; then
    cp package/fluent-agent-lite.conf $PREFIX/etc/fluent-agent-lite.conf
fi
