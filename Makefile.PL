use inc::Module::Install;
#use Module::Install::AuthorTests;
#use Module::Install::Repository;

name     'App-FluentAgentLite';
all_from 'lib/App/FluentAgentLite.pm';
license  'perl';
auto_set_repository;
repository 'https://github.com/tagomoris/fluent-agent-lite';

requires 'Data::MessagePack' => '0.35_01';
requires 'Time::Piece';

test_requires 'Test::More' => 0.88;
# test_requires 'Test::TCP'  => 1.13;
# test_requires 'Test::SharedFork';
# test_requires 'Path::Class';
# test_requires 'Capture::Tiny';

tests_recursive;
# author_tests 'xt';

WriteAll;
