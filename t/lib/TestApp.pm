package TestApp;

use Moose;
use namespace::autoclean;

extends 'Catalyst';

after prepare_parameters => sub {
    my ($ctx) = @_;
    $ctx->request->secure(1)
        if $ctx->request->params->{pretend_secure};
};

__PACKAGE__->setup;

1;
