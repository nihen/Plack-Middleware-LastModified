use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;
use Plack::Builder;
use Plack::Test;
use IO::File;
use File::stat;

my $file = 't/01_basic.t';

my $none_handler = builder {
    sub { ['200', ['Content-Type' => 'text/html'], IO::File->new($file)] };
};

my $handler = builder {
    enable "LastModified";
    sub { ['200', ['Content-Type' => 'text/html'], IO::File->new($file)] };
};




test_psgi app => $handler, client => sub {
    my $cb = shift;

    {
        # GET is not checked
        my $req = GET "/";
        my $res = $cb->($req);

        is $res->header('Last-Modified') => HTTP::Date::time2str(stat($file)->mtime);
    }
};
test_psgi app => $none_handler, client => sub {
    my $cb = shift;

    {
        # GET is not checked
        my $req = GET "/";
        my $res = $cb->($req);

        ok !$res->header('Last-Modified');
    }
};

done_testing;
