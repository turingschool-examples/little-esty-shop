require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
		it { should validate_presence_of(:name) }
	end

  describe 'relationships' do
    it { should have_many :items }
		it { should define_enum_for(:status).with_values(["active", "disabled"])}
  end
end
