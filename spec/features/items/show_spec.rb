require 'rails_helper'

RSpec.describe 'the merchant item show page' do
  before do
    @merchant = Merchant.create!(name: "Hondo MacGuillicutty", created_at: Time.now, updated_at: Time.now)
    @item = @merchant.items.create!(name:)
  end
end
