require 'spec_helper'

describe 'basicauth::basic_entry' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with a basic example using sane defaults' do
        let(:pre_condition) { 'include basicauth' }
        let(:title) { 'root' }
        let(:params) do
          {
            'password' => 'abcd1234',
          }
        end

        it { is_expected.to compile }
        it {
          is_expected.to contain_concat__fragment('basicauth_fragment_root').with(
            'target' => '/var/www/.basicauth',
            'order' => '10',
            'content' => "root:abcd1234\n",
          )
        }
      end
    end
  end
end
