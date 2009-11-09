use strict;
use warnings;
use Test::More;

use FindBin;
use lib "$FindBin::Bin/lib";

use Catalyst::Test 'TestApp';

is(get('/insecure'), 'insecure');

{
    my $resp = request('/secure');
    is($resp->code, 302);
    is($resp->header('Location'), 'https://localhost/secure');
}

is(get('/secure?pretend_secure=1'), 'secure');

done_testing;
