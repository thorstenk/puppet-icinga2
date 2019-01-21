require 'spec_helper'

describe('icinga2::object::usergroup', :type => :define) do
  let(:title) do
    'bar'
  end

  let(:pre_condition) do
    [
      "class { 'icinga2': }"
    ]
  end

  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    context "#{os} with all defaults and target => /bar/baz" do
      let(:params) do
        {
          :target =>  '/bar/baz'
        }
      end

      it { is_expected.to contain_concat('/bar/baz') }

      it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                              .with({'target' => '/bar/baz'})
                              .with_content(/object UserGroup "bar"/)
                              .without_content(/assign where/)
                              .without_content(/ignore where/) }

      it { is_expected.to contain_icinga2__object('icinga2::object::UserGroup::bar')
                              .that_notifies('Class[icinga2::service]') }
    end


    context "#{os} with usergroup_name => foo" do
      let(:params) do
        {
          :usergroup_name => 'foo',
          :target         => '/bar/baz'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                              .with({'target' => '/bar/baz'})
                              .with_content(/object UserGroup "foo"/) }
    end


    context "#{os} with display_name => foo" do
      let(:params) do
        {
          :display_name => 'foo',
          :target       => '/bar/baz'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                              .with({'target' => '/bar/baz'})
                              .with_content(/display_name = "foo"/) }
    end


    context "#{os} with groups => [foo, bar]" do
      let(:params) do
        {
          :groups => ['foo','bar'],
          :target => '/bar/baz'
        }
      end

      it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                              .with({'target' => '/bar/baz'})
                              .with_content(/groups = \[ "foo", "bar", \]/) }
    end


    context "#{os} with groups => foo (not a valid array)" do
      let(:params) do
        {
          :groups => 'foo',
          :target => '/bar/baz'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /"foo" is not an Array/) }
    end


    context "#{os} with assign => [] and ignore => [ foo ]" do
      let(:params) do
        {
          :assign => [],
          :ignore => ['foo'],
          :target => '/bar/baz'
        }
      end

      it { is_expected.to raise_error(Puppet::Error, /When attribute ignore is used, assign must be set/) }
    end
  end
end

describe('icinga2::object::usergroup', :type => :define) do
  let(:facts) do
    {
      :kernel                    => 'Windows',
      :architecture              => 'x86_64',
      :osfamily                  => 'Windows',
      :operatingsystem           => 'Windows',
      :operatingsystemmajrelease => '2012 R2',
      :path => 'C:\Program Files\Puppet Labs\Puppet\puppet\bin;
                C:\Program Files\Puppet Labs\Puppet\facter\bin;
                C:\Program Files\Puppet Labs\Puppet\hiera\bin;
                C:\Program Files\Puppet Labs\Puppet\mcollective\bin;
                C:\Program Files\Puppet Labs\Puppet\bin;
                C:\Program Files\Puppet Labs\Puppet\sys\ruby\bin;
                C:\Program Files\Puppet Labs\Puppet\sys\tools\bin;
                C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;
                C:\Windows\System32\WindowsPowerShell\v1.0\;
                C:\ProgramData\chocolatey\bin;',
    }
  end

  let(:title) do
    'bar'
  end

  let(:pre_condition) do
    [
      "class { 'icinga2': }"
    ]
  end

  context "Windows 2012 R2 with all defaults and target => C:/bar/baz" do
    let(:params) do
      {
        :target =>  'C:/bar/baz'
      }
    end

    it { is_expected.to contain_concat('C:/bar/baz') }

    it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                            .with({'target' => 'C:/bar/baz'})
                            .with_content(/object UserGroup "bar"/)
                            .without_content(/assign where/)
                            .without_content(/ignore where/) }

    it { is_expected.to contain_icinga2__object('icinga2::object::UserGroup::bar')
                            .that_notifies('Class[icinga2::service]') }
  end


  context "Windows 2012 R2 with usergroup_name => foo" do
    let(:params) do
      {
        :usergroup_name => 'foo',
        :target         => 'C:/bar/baz'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                            .with({'target' => 'C:/bar/baz'})
                            .with_content(/object UserGroup "foo"/) }
  end


  context "Windows 2012 R2 with display_name => foo" do
    let(:params) do
      {
        :display_name => 'foo',
        :target       => 'C:/bar/baz'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                            .with({'target' => 'C:/bar/baz'})
                            .with_content(/display_name = "foo"/) }
  end


  context "Windows 2012 R2 with groups => [foo, bar]" do
    let(:params) do
      {
        :groups => ['foo','bar'],
        :target => 'C:/bar/baz'
      }
    end

    it { is_expected.to contain_concat__fragment('icinga2::object::UserGroup::bar')
                            .with({'target' => 'C:/bar/baz'})
                            .with_content(/groups = \[ "foo", "bar", \]/) }
  end


  context "Windows 2012 R2 with groups => foo (not a valid array)" do
    let(:params) do
      {
        :groups => 'foo',
        :target => 'C:/bar/baz'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /"foo" is not an Array/) }
  end


  context "Windows 2012 R2 with assign => [] and ignore => [ foo ]" do
    let(:params) do
      {
        :assign => [],
        :ignore => ['foo'],
        :target => 'C:/bar/baz'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, /When attribute ignore is used, assign must be set/) }
  end
end
