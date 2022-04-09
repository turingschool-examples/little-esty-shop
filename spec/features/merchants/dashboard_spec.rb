require 'rails_helper'

RSpec.describe 'Merchant Dashboard' , type: :feature do
  before do
    @merchant_1 = create :merchant
    binding.pry
    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  it' displays merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end
end