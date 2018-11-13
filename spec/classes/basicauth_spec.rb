require 'spec_helper'

describe 'basicauth', type: :class do
  let(:title) { 'basicauth' }

  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }
end
