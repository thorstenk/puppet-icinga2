require 'spec_helper'

describe('icinga2::feature::gelf', :type => :class) do
  let(:pre_condition) { [
    "class { 'icinga2': features => [], }"
  ] }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts { facts }

      before(:each) do
        case facts[:kernel]
        when 'windows'
          @icinga2_conf_dir = 'C:/ProgramData/icinga2/etc/icinga2'
        when 'FreeBSD'
          @icinga2_conf_dir = '/usr/local/etc/icinga2'
        else
          @icinga2_conf_dir = '/etc/icinga2'
        end
      end

      context "with defaults" do
        it { is_expected.to contain_icinga2__feature('gelf').with({'ensure' => 'present'}) }

        it { is_expected.to contain_icinga2__object('icinga2::object::GelfWriter::gelf')
          .with({ 'target' => "#{@icinga2_conf_dir}/features-available/gelf.conf" })
          .that_notifies('Class[icinga2::service]') }

        it { is_expected.to contain_concat__fragment('icinga2::feature::gelf')
          .with({
            'target' => "#{@icinga2_conf_dir}/features-available/gelf.conf",
            'order'  => '05', })
          .with_content(/library \"perfdata\"$/) }
      end

      context "with ensure => absent" do
        let(:params) { {:ensure => 'absent'} }

        it { is_expected.to contain_icinga2__feature('gelf').with({'ensure' => 'absent'}) }
      end
    end
    
  end
end
