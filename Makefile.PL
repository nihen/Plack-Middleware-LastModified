use inc::Module::Install;
name 'Plack-Middleware-LastModified';
all_from 'lib/Plack/Middleware/LastModified.pm';
readme_from 'lib/Plack/Middleware/LastModified.pm';
requires 'parent';
requires 'Plack';
requires 'HTTP::Date';
requires 'File::stat';
build_requires 'Test::More';
use_test_base;
auto_include_deps;
author_tests('xt');
auto_set_repository;
WriteAll;
