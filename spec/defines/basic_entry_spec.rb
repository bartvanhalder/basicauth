require 'spec_helper'

describe 'basicauth::basic_entry', type: :define do
  let(:title) { 'basic_entry' }

  context 'set location' do
    let :params do
      {
        'location' => '/var/www/.basicauth',
      }
    end

    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }
  end
end
