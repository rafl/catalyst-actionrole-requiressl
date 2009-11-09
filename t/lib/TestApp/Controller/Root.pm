package TestApp::Controller::Root;

use Moose;
use namespace::autoclean;

BEGIN {
    extends 'Catalyst::Controller::ActionRole';
}

__PACKAGE__->config(namespace => '');

sub insecure : Path('insecure') {
    my ($self, $ctx) = @_;
    $ctx->response->body('insecure');
}

sub secure : Path('secure') Does('RequireSSL') {
    my ($self, $ctx) = @_;
    die 42 unless $ctx->request->secure;
    $ctx->response->body('secure');
}

__PACKAGE__->meta->make_immutable;

1;
