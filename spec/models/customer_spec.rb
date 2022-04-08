require 'rails_helper'

RSpec.describe Customer do
  before :each do
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson",
                                 created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                 updated_at: Time.parse('2012-03-27 14:54:09 UTC'))
  end

  context 'readable attributes' do
    it 'has a name' do
      expect(@customer.first_name).to eq("Billy")
      expect(@customer.last_name).to eq("Jonson")
    end
  end
end
