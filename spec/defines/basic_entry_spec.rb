require 'spec_helper'

describe 'basicauth::basic_entry', type: :define do
  let(:title) { 'basic_entry' }
  it { is_expected.to compile }
  # it { is_expected.to compile.with_all_deps }     
end
