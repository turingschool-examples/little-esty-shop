require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it {should belong_to(:invoice)}
  end

  describe 'validations' do
    it { should define_enum_for(:result).with([:success, :failed]) }
  end
end
