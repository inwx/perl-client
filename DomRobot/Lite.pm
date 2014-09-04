package DomRobot::Lite;
use strict;
use warnings;
BEGIN {
	require HTTP::Cookies;
	require XMLRPC::Lite;
	@DomRobot::Lite::ISA = qw(XMLRPC::Lite);
}


sub new {
	my $class = shift;
	return $class if ref $class;
	my $self = $class->SUPER::new(@_);
	bless $self => $class;
}

sub lang {
	my $self = shift;
	$self->{lang} = shift if @_ > 0;
	$self->{lang};
}

sub customer {
	my $self = shift;
	$self->{customer} = shift if @_ > 0;
	$self->{customer};
}

sub clTrId {
	my $self = shift;
	$self->{clTrId} = shift if @_ > 0;
	$self->{clTrId};
}

sub call {
	my $self = shift;
	my ($method,$args) = @_;
	do {
		$args->{$_} = $self->{$_} 
			if !exists $args->{$_} && defined $self->{$_} 
	} foreach qw(lang customer clTrId);
	$self->SUPER::call($method,$args);
}

sub login {
	my $self = shift;
	my ($user,$pass,$shared_secret) = @_;
	$self->call('account.login', { user => $user, pass => $pass });
}

1;

