use inc::Module::Install;
name 'Haruna';
all_from 'lib/Haruna.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
