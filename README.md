# LDAP-Rails

## Radically simple LDAP authentication

ldap-rails is a Rails plugin that makes it easy to authenticate users against
your organization's LDAP server.

It's designed for Rails 3.1 and above.

ldap-rails is developed and maintained by
[Ben Weissmann](http://benweissmann.com).

## Setup

1. Add "gem ldap-rails" to your Gemfile.
2. Run "bundle install" to install the new gem.
3. Run "rails generate ldap_auth ldap.your-org.com"

That's it. You're done.

## Configuration

ldap-rails will try to guess your LDAP server's configuration based on the
the URL you give to the rails generate command. Note that you can specify
the for as part of the URL -- for example, if your LDAP server runs on port
1000, use "rails generate ldap_auth ldap.your-org.com:1000". ldap-rails will
automatically try to use and SSL connection to your LDAP server if your LDAP
server is on port 636.

You can customize the LDAP connection configuration after you've run the
generator in config/initializer/ldap_auth.rb. See the instruction in that
file for more detail.

## License

ldap-rails is licensed under the MIT license