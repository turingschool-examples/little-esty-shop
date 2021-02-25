require 'rails_helper'

RSpec.describe "Merchant Edit Page" do
  before :each do
    @merchant = create(:merchant)
  end

  it "can update attributes with form" do
    visit "/admin/merchants/#{@merchant.id}/edit"

    fill_in "Name", with: "Bob's Burgers"
    click_button("Submit")

    expect(current_path).to eq(admin_merchant_path(@merchant))
  end
end
