require 'rails_helper'
describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({enable: 0, disable: 1})}
  end

end
