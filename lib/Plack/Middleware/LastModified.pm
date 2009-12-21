package Plack::Middleware::LastModified;
use strict;
use 5.008_001;
use parent qw( Plack::Middleware );
use Plack::Util;
use File::stat;
use HTTP::Date;

sub call {
    my $self = shift;
    my $env  = shift;

    my $res = $self->app->($env);
    $self->response_cb($res, sub {
        my $res = shift;
        return unless Plack::Util::is_real_fh($res->[2]);
        Plack::Util::header_set($res->[1], 'Last-Modified'  => HTTP::Date::time2str( stat($res->[2])->mtime ));
    });

}


1;

__END__

=head1 NAME

Plack::Middleware::LastModified - Adds Last-Modified header automatically

=head1 SYNOPSIS

  builder {
      enable "LastModified";
      $app;
  };

=head1 DESCRIPTION

Plack::Middleware::LastModified is a middleware that automatically
adds C<Last-Modified> header.

=head1 AUTHOR

Masahiro Chiba

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

Plack::Middleware Plack::Builder

=cut
