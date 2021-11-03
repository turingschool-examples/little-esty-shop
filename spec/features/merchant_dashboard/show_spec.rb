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

  it 'should have top customers names in correct order' do
    expect(@merchant.top_customers[0][0]).to appear_before(@merchant.top_customers[1][0])
    expect(@merchant.top_customers[1][0]).to appear_before(@merchant.top_customers[2][0])
    expect(@merchant.top_customers[2][0]).to appear_before(@merchant.top_customers[3][0])
    expect(@merchant.top_customers[3][0]).to appear_before(@merchant.top_customers[4][0])
  end

  it 'should have top customers names in correct order' do
    expect(@merchant.top_customers[0][0]).to appear_before(@merchant.top_customers[1][0])
    expect(@merchant.top_customers[1][0]).to appear_before(@merchant.top_customers[2][0])
    expect(@merchant.top_customers[2][0]).to appear_before(@merchant.top_customers[3][0])
    expect(@merchant.top_customers[3][0]).to appear_before(@merchant.top_customers[4][0])
  end

  it 'should have items ready to ship in order from oldest to newest' do
    expect(page).to have_content("Items Ready to Ship")
    expect(page).to have_content(@merchant.shippable_items[0][0])
    expect(page).to have_content(@merchant.shippable_items[0][1])
    expect(@merchant.shippable_items[0][0]).to appear_before(@merchant.shippable_items[10][0])
  end
end
