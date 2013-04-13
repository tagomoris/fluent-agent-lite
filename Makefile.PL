# requires Module::Install
# requires Module::Install::Repository
# requires Module::Install::CPANfile

use inc::Module::Install;

name     'Fluent-AgentLite';
all_from 'lib/Fluent/AgentLite.pm';
license  'perl';
perl_version '5.008001';

cpanfile;

install_script 'bin/fluent-agent-lite';

auto_set_repository;

WriteAll;
