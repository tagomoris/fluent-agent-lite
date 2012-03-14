%define name fluent-agent-lite
%define version 0.1
%define prefix /usr/local
%define _use_internal_dependency_generator 0

%global debug_package %{nil}

Name:           fluent-agent-lite
Version:        %{version}
Release:        original
Summary:        Log transfer agent service over fluentd protocol

Group:          Applications/System
License:        Apache Software License v2
URL:            https://github.com/tagomoris/fluent-agent-lite
# Source0:        https://github.com/tagomoris/fluent-agent-lite/tarball/v%{version}
Source0:        fluent-agent-lite.v%{version}.tar.gz
# Source1:        fluent-agent-lite.conf
# Source2:        fluent-agent.servers.primary
# Source3:        fluent-agent.servers.secondary
BuildRoot:      %{_tmppath}/%{name}-root

ExclusiveArch:  x86_64
AutoReq:        no

%description
Log transfer agent service over fluentd protocol.

%prep
%setup -q -n fluent-agent-lite

%build

%install
rm -rf $RPM_BUILD_ROOT
env PREFIX=$RPM_BUILD_ROOT bin/install.sh

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
# %config(noreplace) /etc/fluent-agent-lite.conf
# %config /etc/fluent-agent.servers.primary
# %config /etc/fluent-agent.servers.secondary
%{_sysconfdir}/*
%{prefix}/*
# %doc README

%changelog
* Wed Mar 14 2012 TAGOMORI Satoshi <tagomoris@gmail.com>
- initial packaging attempt
