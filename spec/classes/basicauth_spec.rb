require 'spec_helper'

describe 'basicauth' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with all defaults' do
        it { is_expected.to compile }

        it {
          is_expected.to contain_file('/var/www/.basicauth').with(
            'ensure' => 'absent',
            'force' => true,
          )
        }

        it { is_expected.not_to contain_concat('/var/www/.basicauth') }
        it { is_expected.not_to contain_concat__fragment('file-header') }
      end

      context "when ensure is set to 'present'" do
        let(:params) { { 'ensure' => 'present' } }

        it { is_expected.to compile }

        it {
          is_expected.to contain_concat('/var/www/.basicauth').with(
            'owner' => 'www-data',
            'group' => 'www-data',
            'mode'  => '0600',
          )
        }
        it {
          is_expected.to contain_concat__fragment('file-header').with(
            'target' => '/var/www/.basicauth',
            'order' => '01',
          )
        }
      end

      context 'when managing some entries' do
        let(:params) do
          {
            'ensure'      => 'present',
            'basic_entry' => {
              'app'  => { 'user' => 'app', 'password' => 'a12345bfc' },
              'root' => { 'user' => 'root', 'password' => 'abc', 'algorithm' => 'hash', 'hashtype' => 'SHA-512' },
            },
          }
        end

        # Stub out the pw_hash function as it errors out when running spec tests with the message:
        #   - 'system does not support enhanced salts'
        before(:each) do
          Puppet::Parser::Functions.newfunction(:pw_hash, type: :rvalue) { |_args| 'hashed_pass' }
        end

        it { is_expected.to compile }
        it {
          is_expected.to contain_basicauth__basic_entry('app').with(
            'user' => 'app',
            'password' => 'a12345bfc',
          )
        }
        it {
          is_expected.to contain_basicauth__basic_entry('root').with(
            'user' => 'root',
            'password' => 'abc',
            'algorithm' => 'hash',
            'hashtype' => 'SHA-512',
          )
        }
      end
    end
  end
end
