<p align="center">
  <a href="https://www.inwx.com/en/" target="_blank">
    <img src="https://images.inwx.com/logos/inwx.png">
  </a>
</p>

INWX Domrobot Perl Client
=========
You can access all functions of our frontend via our API, which is available via the XML-RPC or JSON-RPC protocol and thus can be easily consumed with all programming languages.

There is also an OT&E test system, which you can access via [ote.inwx.com](https://ote.inwx.com/en/). Here you will find the known web interface which is using a test database. On the OT&E system no actions will be charged. So you can test as much as you like there.

Documentation
------
You can view a detailed description of the API functions in our documentation. You can find the online documentation [by clicking here](https://www.inwx.de/en/help/apidoc).

If you still experience any kind of problems don't hesitate to contact our [support via email](mailto:support@inwx.de).

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
