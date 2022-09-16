require 'rails_helper'

RSpec.describe "Admin Show" do
  describe "As an admin" do
    before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
    end

    it 'us#25 - I see the name of that merchant' do
        visit admin_merchant_path(@merchant_1)
        expect(page).to have_content(@merchant_1.name)
    end
  end
end