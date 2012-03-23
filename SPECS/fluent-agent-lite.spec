%define name fluent-agent-lite
%define version 0.4
%define prefix /usr/local
%define build_perl_path /usr/bin/perl

%define _use_internal_dependency_generator 0

%global debug_package %{nil}

Name:           fluent-agent-lite
Version:        %{version}
Release:        original
Summary:        Log transfer agent service over fluentd protocol

Group:          Applications/System
License:        Apache Software License v2
URL:            https://github.com/tagomoris/fluent-agent-lite
# Source0:        https://github.com/downloads/tagomoris/fluent-agent-lite/fluent-agent-lite.v%{version}.tar.gz
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
env PREFIX=$RPM_BUILD_ROOT PERL_PATH=%{build_perl_path} bin/install.sh

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%config(noreplace) %{_sysconfdir}/fluent-agent-lite.conf
# %config %{_sysconfdir}/fluent-agent.servers.primary
# %config %{_sysconfdir}/fluent-agent.servers.secondary
%{_sysconfdir}/init.d/fluent-agent-lite
%{prefix}/*
# %doc README

%changelog
* Wed Mar 21 2012 TAGOMORI Satoshi <tagomoris@gmail.com>
- fix to send PackedForward object
- bugfix about installer / init script
- add feature about drain log
* Thu Mar 15 2012 TAGOMORI Satoshi <tagomoris@gmail.com>
- bugfix about path of perl
* Wed Mar 14 2012 TAGOMORI Satoshi <tagomoris@gmail.com>
- initial packaging attempt
