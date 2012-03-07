package Fluent::AgentLite;

use strict;
use warnings;
use English;
use Carp;

use Time::Piece;
use Log::Minimal;

use IO::Socket::INET;
use Data::MessagePack;

our $VERSION = '0.01';

use constant CONNECTION_KEEPALIVE => 1800; # 30min
use constant CONNECTION_KEEPALIVE_MARGIN_MAX => 30; # max 30sec

use constant RECONNECT_WAIT_MIN => 0.5;  # 0.5sec
use constant RECONNECT_WAIT_MAX => 3600; # 60min
use constant RECONNECT_WAIT_INCR_RATE => 1.5;

use constant SEND_RETRY_WAIT => 0.5; # 0.5sec (fixed)

sub new {
    my $this = shift;
    my ($terminated, $tailfd, $tag, $primary_servers, $secondary_servers, $configuration) = @_;
    my $self = {
        terminated => $terminated,
        tailfd => $tailfd,
        tag => $tag,
        servers => {
            primary => $primary_servers,
            secondary => $secondary_servers,
        },
        buffer_size => $configuration->{buffer_size}
    };

    srand (time ^ $PID ^ unpack("%L*", `ps axww | gzip`));

    bless $self, $this;
}

sub execute {
    my $msgpack_packer = Data::MessagePack->new
    my $msgpack_sock; #TODO
    while() {
        # sysread -> pack -> send loop
    }
}

1;
