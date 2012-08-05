require 'test_helper'

class LdapRailsTest < ActiveSupport::TestCase
  test "configure, all specified" do
    LdapRails.configure :host => 'foo.example.com',
                        :port => 100,
                        :ssl => true,
                        :base_dn => 'dc=a,dc=b',
                        :login_suffix => 'ou=hello,ou=world',
                        :login_key => 'userid'

    assert_equal 'foo.example.com', LdapRails.config[:host]
    assert_equal 100, LdapRails.config[:port]
    assert_equal true, LdapRails.config[:ssl]
    assert_equal 'dc=a,dc=b', LdapRails.config[:base_dn]
    assert_equal 'ou=hello,ou=world', LdapRails.config[:login_suffix]
    assert_equal 'userid', LdapRails.config[:login_key]
  end

  test "configure, default port" do
    LdapRails.configure :host => 'foo.example.com',
                        :ssl => true,
                        :base_dn => 'dc=a,dc=b'

    assert_equal 'foo.example.com', LdapRails.config[:host]
    assert_equal 389, LdapRails.config[:port]
    assert_equal true, LdapRails.config[:ssl]
    assert_equal 'dc=a,dc=b', LdapRails.config[:base_dn]
  end

  test "configure, infer port" do
    LdapRails.configure :host => 'foo.example.com:1000',
                        :ssl => true,
                        :base_dn => 'dc=a,dc=b'

    assert_equal 'foo.example.com', LdapRails.config[:host]
    assert_equal 1000, LdapRails.config[:port]
    assert_equal true, LdapRails.config[:ssl]
    assert_equal 'dc=a,dc=b', LdapRails.config[:base_dn]
  end

  test "configure, default ssl" do
    LdapRails.configure :host => 'foo.example.com',
                        :port => 100,
                        :base_dn => 'dc=a,dc=b'

    assert_equal 'foo.example.com', LdapRails.config[:host]
    assert_equal 100, LdapRails.config[:port]
    assert_equal false, LdapRails.config[:ssl]
    assert_equal 'dc=a,dc=b', LdapRails.config[:base_dn]
  end

  test "configure, infer ssl" do
    LdapRails.configure :host => 'foo.example.com:636',
                        :base_dn => 'dc=a,dc=b'

    assert_equal 'foo.example.com', LdapRails.config[:host]
    assert_equal 636, LdapRails.config[:port]
    assert_equal true, LdapRails.config[:ssl]
    assert_equal 'dc=a,dc=b', LdapRails.config[:base_dn]
  end

  test "configure, infer all" do
    LdapRails.configure :host => 'foo.example.com:636'

    assert_equal 'foo.example.com', LdapRails.config[:host]
    assert_equal 636, LdapRails.config[:port]
    assert_equal true, LdapRails.config[:ssl]
    assert_equal 'dc=example,dc=com', LdapRails.config[:base_dn]
    assert_nil   LdapRails.config[:login_suffix]
    assert_equal 'uid', LdapRails.config[:login_key]
  end

  test "configure, no host" do
    assert_raise LdapRails::InvalidConfigurationError do
      LdapRails.configure :port => 100,
                          :ssl => true,
                          :base_dn => 'dc=a,dc=b',
                          :login_suffix => 'ou=hello,ou=world',
                          :login_key => 'userid'
    end
  end
end

