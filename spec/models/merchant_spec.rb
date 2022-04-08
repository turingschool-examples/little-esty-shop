require 'rails_helper'

RSpec.describe Merchant do
  before :each do
    @merchant = Merchant.create!(name: "Frank's Eel Puding",
                                 created_at: Time.parse('2012-03-27 14:53:59 UTC'),
                                 updated_at: Time.parse('2012-03-27 14:53:59 UTC'))
  end

  context 'readable attributes' do
    it 'has a name' do
      expect(@merchant.name).to eq("Frank's Eel Pudding")
    end
  end
end
