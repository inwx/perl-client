inwx.com XML-RPC Perl Client
=========
You can access all functions of our frontend via an application programming interface (API). Our API is based on the XML-RPC protocol and thus can be easily addressed by almost all programming languages. The documentation and programming examples in PHP, Java, Ruby and Python can be downloaded here.

There is also an OT&E test system, which you can access via ote.inwx.com. Here you will find the known web interface which is using a test database. On the OTE system no actions will be charged. So you can test how to register domains etc.

Documentation
------
You can view a detailed description of the API functions in our documentation. The documentation as PDF ist part of the Projekt. You also can read the documentation online http://www.inwx.de/en/help/apidoc

Example
-------

```perl
#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

use HTTP::Cookies;
use XMLRPC::Lite; # +trace => 'all';

my $addr = "https://api.ote.domrobot.com/xmlrpc/"; # OT&E
#my $addr = "https://api.domrobot.com/xmlrpc/"; # Live

# your credentials here
my $usr = 'your_username';
my $pwd = 'your_password';

my ($proxy,$result);
$proxy = XMLRPC::Lite
      -> proxy($addr, cookie_jar => HTTP::Cookies->new(ignore_discard => 1));

$result = $proxy->call('account.login', { user => $usr, pass => $pwd })->result;
if ( $result->{code} == 1000 ) {  # Command completed successfully

  # domain availability check
  $result = $proxy->call('domain.check', { 
    domain => ['mydomain.com','mydomain2.net']})->result;
  print Dumper($result);
  
} else {
  die Dumper($result); # login failed
}
__END__
```

You can also look at the example.php in the Project.

License
----

MIT
