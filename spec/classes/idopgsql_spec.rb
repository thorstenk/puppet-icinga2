require 'spec_helper'

describe('icinga2::feature::idopgsql', :type => :class) do
  let(:pre_condition) do
    [
      "class { 'icinga2': features => [], }"
    ]
  end

  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end


    context "#{os} with ensure => present" do
      let(:params) do
        {
          :ensure => 'present'
        }
      end

      it { is_expected.to contain_icinga2__feature('ido-pgsql').with({'ensure' => 'present'}) }
    end


    context "#{os} with ensure => absent" do
      let(:params) do
        {
          :ensure => 'absent'
        }
      end

      it { is_expected.to contain_icinga2__feature('ido-pgsql').with({'ensure' => 'absent'}) }
    end

    context "#{os} with all defaults" do
      it { is_expected.to contain_icinga2__feature('ido-pgsql').with({'ensure' => 'present'}) }

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/host = "127.0.0.1"/)
                              .with_content(/port = 5432/)
                              .with_content(/user = "icinga"/)
                              .with_content(/password = "icinga"/)
                              .with_content(/table_prefix = "icinga_"/)
                              .with_content(/instance_name = "default"/)
                              .with_content(/enable_ha = true/)
                              .with_content(/failover_timeout = 60s/) }
    end


    context "#{os} with host => foo.example.com" do
      let(:params) do
        {
          :host => 'foo.example.com'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/host = "foo.example.com"/) }
    end


    context "#{os} with port => 4247" do
      let(:params) do
        {
          :port => '4247'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/port = 4247/) }
    end


    context "#{os} with port => foo (not a valid integer)" do
      let(:params) do
        {
          :port => 'foo'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /first argument to be an Integer/) }
    end


    context "#{os} with user => foo" do
      let(:params) do
        {
          :user => 'foo'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/user = "foo"/) }
    end


    context "#{os} with database => foo" do
      let(:params) do
        {
          :database => 'foo'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/database = "foo"/) }
    end


    context "#{os} with table_prefix => foo" do
      let(:params) do
        {
          :table_prefix => 'foo'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/table_prefix = "foo"/) }
    end


    context "#{os} with instance_name => foo" do
      let(:params) do
        {
          :instance_name => 'foo'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/instance_name = "foo"/) }
    end


    context "#{os} with enable_ha => true" do
      let(:params) do
        {
          :enable_ha => true
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/enable_ha = true/) }
    end


    context "#{os} with enable_ha => false" do
      let(:params) do
        {
          :enable_ha => false
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/enable_ha = false/) }
    end


    context "#{os} with enable_ha => foo (not a valid boolean)" do
      let(:params) do
        {
          :enable_ha => 'foo'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /"foo" is not a boolean/) }
    end


    context "#{os} with failover_timeout => 50s" do
      let(:params) do
        {
          :failover_timeout => '50s'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/failover_timeout = 50s/) }
    end


    context "#{os} with failover_timeout => foo (not a valid value)" do
      let(:params) do
        {
          :failover_timeout => "foo"
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /"foo" does not match/) }
    end


    context "#{os} with cleanup => { foo => 'bar', bar => 'foo' }" do
      let(:params) do
        {
          :cleanup => { 'foo' => "bar", 'bar' => "foo" }
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/cleanup = {\n\s+foo = "bar"\n\s+bar = "foo"\n\s+}/) }
    end


    context "#{os} with cleanup => 'foo' (not a valid hash)" do
      let(:params) do
        {
          :cleanup => 'foo'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /"foo" is not a Hash/) }
    end


    context "#{os} with categories => ['foo', 'bar']" do
      let(:params) do
        {
          :categories => ['foo', 'bar']
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                              .with({ 'target' => '/etc/icinga2/features-available/ido-pgsql.conf' })
                              .with_content(/categories = \[ "foo", "bar", \]/) }
    end


    context "#{os} with categories => 'foo' (not a valid array)" do
      let(:params) do
        {
          :categories => 'foo'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /"foo" is not an Array/) }
    end


    context "#{os} with import_schema => true" do
      let(:params) do
        {
          :import_schema => true
        }
      end

      it { is_expected.to contain_exec('idopgsql-import-schema') }
    end


    context "#{os} with import_schema => false" do
      let(:params) do
        {
          :import_schema => false
        }
      end

      it { should_not contain_exec('idopgsql-import-schema') }
    end


    context "#{os} with import_schema => foo (not a valid boolean)" do
      let(:params) do
        {
          :import_schema => 'foo'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /"foo" is not a boolean/) }
    end

    context "#{os} with icinga2::manage_package => true" do
      let(:pre_condition) do
        [
          "class { 'icinga2': features => [], manage_package => true }"
        ]
      end

      it { is_expected.to contain_package('icinga2').with({ 'ensure' => 'installed' }) }
    end

    context "#{os} with icinga2::manage_package => false" do
      let(:pre_condition) do
        [
          "class { 'icinga2': features => [], manage_package => false }"
        ]
      end

      it { should_not contain_package('icinga2').with({ 'ensure' => 'installed' }) }
    end
  end
end

describe('icinga2::feature::idopgsql', :type => :class) do
  let(:pre_condition) do
    [
      "class { 'icinga2': features => [], }"
    ]
  end

  let(:facts) do
    {
      :kernel                    => 'Windows',
      :architecture              => 'x86_64',
      :osfamily                  => 'Windows',
      :operatingsystem           => 'Windows',
      :operatingsystemmajrelease => '2012 R2',
      :path                      => 'C:/Program Files/Postgresql/bin'
    }
  end


  context "Windows 2012 R2 with ensure => present" do
    let(:params) do
      {
        :ensure => 'present'
      }
    end

    it { is_expected.to contain_icinga2__feature('ido-pgsql').with({'ensure' => 'present'}) }
  end


  context "Windows 2012 R2 with ensure => absent" do
    let(:params) do
      {
        :ensure => 'absent'
      }
    end

    it { is_expected.to contain_icinga2__feature('ido-pgsql').with({'ensure' => 'absent'}) }
  end

  context "Windows 2012 R2 with all defaults" do
    it { is_expected.to contain_icinga2__feature('ido-pgsql').with({'ensure' => 'present'}) }

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/host = "127.0.0.1"/)
                            .with_content(/port = 5432/)
                            .with_content(/user = "icinga"/)
                            .with_content(/password = "icinga"/)
                            .with_content(/table_prefix = "icinga_"/)
                            .with_content(/instance_name = "default"/)
                            .with_content(/enable_ha = true/)
                            .with_content(/failover_timeout = 60s/) }
  end


  context "Windows 2012 R2 with host => foo.example.com" do
    let(:params) do
      {
        :host => 'foo.example.com'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/host = "foo.example.com"/) }
  end


  context "Windows 2012 R2 with port => 4247" do
    let(:params) do
      {
        :port => '4247'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/port = 4247/) }
  end


  context "Windows 2012 R2 with port => foo (not a valid integer)" do
    let(:params) do
      {
        :port => 'foo'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /first argument to be an Integer/) }
  end


  context "Windows 2012 R2 with user => foo" do
    let(:params) do
      {
        :user => 'foo'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/user = "foo"/) }
  end


  context "Windows 2012 R2 with database => foo" do
    let(:params) do
      {
        :database => 'foo'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/database = "foo"/) }
  end


  context "Windows 2012 R2 with table_prefix => foo" do
    let(:params) do
      {
        :table_prefix => 'foo'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/table_prefix = "foo"/) }
  end


  context "Windows 2012 R2 with instance_name => foo" do
    let(:params) do
      {
        :instance_name => 'foo'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/instance_name = "foo"/) }
  end


  context "Windows 2012 R2 with enable_ha => true" do
    let(:params) do
      {
        :enable_ha => true
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/enable_ha = true/) }
  end


  context "Windows 2012 R2 with enable_ha => false" do
    let(:params) do
      {
        :enable_ha => false
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/enable_ha = false/) }
  end


  context "Windows 2012 R2 with enable_ha => foo (not a valid boolean)" do
    let(:params) do
      {
        :enable_ha => 'foo'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /"foo" is not a boolean/) }
  end


  context "Windows 2012 R2 with failover_timeout => 50s" do
    let(:params) do
      {
        :failover_timeout => '50s'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/failover_timeout = 50s/) }
  end


  context "Windows 2012 R2 with failover_timeout => foo (not a valid value)" do
    let(:params) do
      {
        :failover_timeout => "foo"
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /"foo" does not match/) }
  end


  context "Windows 2012 R2 with cleanup => { foo => 'bar', bar => 'foo' }" do
    let(:params) do
      {
        :cleanup => { 'foo' => "bar", 'bar' => "foo" }
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/cleanup = {\r\n\s+foo = "bar"\r\n\s+bar = "foo"\r\n\s+}/) }
  end


  context "Windows 2012 R2 with cleanup => 'foo' (not a valid hash)" do
    let(:params) do
      {
        :cleanup => 'foo'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /"foo" is not a Hash/) }
  end


  context "Windows 2012 R2 with categories => ['foo', 'bar']" do
    let(:params) do
      {
        :categories => ['foo', 'bar']
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::IdoPgsqlConnection::ido-pgsql')
                            .with({ 'target' => 'C:/ProgramData/icinga2/etc/icinga2/features-available/ido-pgsql.conf' })
                            .with_content(/categories = \[ "foo", "bar", \]/) }
  end


  context "Windows 2012 R2 with categories => 'foo' (not a valid array)" do
    let(:params) do
      {
        :categories => 'foo'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /"foo" is not an Array/) }
  end


  context "Windows 2012 R2 with import_schema => true" do
    let(:params) do
      {
        :import_schema => true
      }
    end

    it { is_expected.to contain_exec('idopgsql-import-schema') }
  end


  context "Windows 2012 R2 with import_schema => false" do
    let(:params) do
      {
        :import_schema => false
      }
    end

    it { should_not contain_exec('idopgsql-import-schema') }
  end


  context "Windows 2012 R2 with import_schema => foo (not a valid boolean)" do
    let(:params) do
      {
        :import_schema => 'foo'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /"foo" is not a boolean/) }
  end

  context "Windows 2012 R2 with icinga2::manage_package => true" do
    let(:pre_condition) do
      [
        "class { 'icinga2': features => [], manage_package => true }"
      ]
    end

    it { is_expected.to contain_package('icinga2').with({ 'ensure' => 'installed' }) }
  end

  context "Windows 2012 R2 with icinga2::manage_package => false" do
    let(:pre_condition) do
      [
        "class { 'icinga2': features => [], manage_package => false }"
      ]
    end

    it { should_not contain_package('icinga2').with({ 'ensure' => 'installed' }) }
  end
end
