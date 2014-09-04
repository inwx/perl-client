#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper; # debug

# Don't forget to: 'cpan -i XMLRPC::Lite'
# or, on Debian, you may: 'apt-get install libxmlrpc-lite-perl'
#
use DomRobot::Lite;
# use DomRobot::Lite +trace => 'all';


# skip SSL verification for OT&E
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;

# Be careful when using the production environment
#my $addr = "https://api.domrobot.com/xmlrpc/";

# INWX OT&E API
my $addr = "https://api.ote.domrobot.com/xmlrpc/"; # OT&E

# Replace with your OT&E credentials:
my $usr = 'your-username-here';
my $pwd = 'your-password-here';

my ($client,$response);

$client = DomRobot::Lite
      -> proxy($addr, cookie_jar => HTTP::Cookies->new(ignore_discard => 1)
	);

# You may set you language preference here:
$client->lang('de');

# Authenticate and get a session cookie.
$response = $client->login($usr,$pwd);

# Check avilability for mydomain.com and mydomain2.net:
if ($response->result->{code} == 1000) { # Command completed successfully
	$response = $client->call('domain.check', {
		domain => ['mydomain.com','mydomain2.net']});
	print Dumper($response->result);

}
else {
	# login failed
	print Dumper($response->result);
}

# End session
$client->logout;

exit 0;
__END__


