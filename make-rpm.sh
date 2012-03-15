#!/bin/sh
version=`cat VERSION`
cur=`pwd`

rm -fR fluent-agent-lite
git clone https://github.com/tagomoris/fluent-agent-lite.git
tar czf fluent-agent-lite.v$version.tar.gz fluent-agent-lite
rm -fR fluent-agent-lite

# setup rpmbuild env
echo "%_topdir $cur/rpmbuild/" > ~/.rpmmacros
rm -fR rpmbuild
mkdir rpmbuild
pushd rpmbuild
mkdir BUILD RPMS SOURCES SPECS SRPMS
# locate spec
cp ../SPECS/fluent-agent-lite.spec SPECS
# locate source tarball
mv ../fluent-agent-lite.v$version.tar.gz SOURCES
# locate conf
cp ../package/fluent-agent-lite.conf SOURCES
# locate init.d script
cp ../package/fluent-agent-lite.init SOURCES
# build
rpmbuild -v -ba --clean SPECS/fluent-agent-lite.spec
popd
