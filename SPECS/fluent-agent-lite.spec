%define name fluent-agent-lite
%define version 0.1
%define prefix /usr/local
%define _use_internal_dependency_generator 0

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

BuildArch:      noarch
AutoReq:        no

%description
Log transfer agent service over fluentd protocol.

%prep
%setup -q -n fluent-agent-lite

%build

%install
rm -rf $RPM_BUILD_ROOT

mkdir -p $RPM_BUILD_ROOT%{prefix}%{name}
env PREFIX=$RPM_BUILD_ROOT bin/install.sh

%clean
rm -rf $RPM_BUILD_ROOT

# %files
# %config(noreplace) /etc/fluent-agent-lite.conf
# %config /etc/fluent-agent.servers.primary
# %config /etc/fluent-agent.servers.secondary
# %defattr(-,root,root,-)

%changelog
* Wed Mar 14 2012 TAGOMORI Satoshi <tagomoris@gmail.com>
- initial packaging attempt
