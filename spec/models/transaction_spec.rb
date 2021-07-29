require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it {should belong_to(:invoice)}
    it {should have_many(:customers).through(:invoice)}
  end

  describe 'validations' do
    it { should define_enum_for(:result).with([:success, :failed]) }
  end
end
