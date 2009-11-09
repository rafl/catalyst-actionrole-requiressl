package Catalyst::ActionRole::RequireSSL;

use Moose::Role;
use namespace::autoclean;

requires 'execute';

around execute => sub {
    my $next = shift;
    my ($self, $controller, $ctx) = @_;

    if (!$ctx->request->secure) {
        $self->redirect_to_secure_uri($controller, $ctx);
        return;
    }

    return $next->(@_);
};

sub redirect_to_secure_uri {
    my ($self, $controller, $ctx) = @_;
    $ctx->response->redirect($self->secure_uri_for($controller, $ctx, $ctx->request->uri));
}

sub secure_uri_for {
    my ($self, $controller, $ctx, $uri) = @_;
    my $redir_uri = $uri->clone;
    $redir_uri->scheme('https');
    return $redir_uri;
}

1;
