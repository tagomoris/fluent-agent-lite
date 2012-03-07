use inc::Module::Install;
#use Module::Install::AuthorTests;
#use Module::Install::Repository;

name     'Fluent-AgentLite';
all_from 'lib/Fluent/AgentLite.pm';
license  'perl';
auto_set_repository;
repository 'https://github.com/tagomoris/fluent-agent-lite';

requires 'Data::MessagePack' => '0.35_01';

requires 'Time::Piece';
requires 'Log::Minimal';

test_requires 'Test::More' => 0.88;
# test_requires 'Test::TCP'  => 1.13;
# test_requires 'Test::SharedFork';
# test_requires 'Path::Class';
# test_requires 'Capture::Tiny';

tests_recursive;
# author_tests 'xt';

WriteAll;
