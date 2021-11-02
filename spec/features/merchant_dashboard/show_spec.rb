require 'rails_helper'

RSpec.describe 'merchant dashboard show page' do
  before(:each) do
    @merchant = Merchant.first
    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'should have name of merchant' do
    expect(page).to have_content(@merchant.name)
  end

  it 'should have links to the items/invoices indices' do
    has_link?("My Items")
    has_link?("My Invoices")
  end
end
