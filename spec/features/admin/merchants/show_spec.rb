require 'rails_helper'

RSpec.describe "admin merchant show" do
  before do
    @merchant = create(:merchant)
    visit admin_merchant_path(@merchant)
  end

  it 'can show the name of the merchant' do
    expect(current_path).to eq(admin_merchant_path(@merchant))
    expect(page).to have_content(@merchant.name)
  end

end
