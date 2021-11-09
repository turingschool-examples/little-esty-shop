require 'rails_helper'
# FactoryBot.find_definitions

RSpec.describe 'merchant dashboard show page' do
  before(:each) do
    @merchant = create(:merchant)

  end

  it 'should have name of merchant' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content(@merchant.name)
  end

  it 'should have links to the items/invoices indices' do
    visit "/merchants/#{@merchant.id}/dashboard"

    has_link?("My Items")
    has_link?("My Invoices")
  end

  it 'should have top customers names in correct order' do
    @items = create_list(:item, 6, merchant: @merchant)
    @customers = create_list(:customer, 6)

    num = 0
    @customers.zip(@items) do |customer, item|
      num += 1
      invoice = create(:invoice, customer: customer)
      create(:invoice_item, invoice: invoice, item: item)
      create_list(:transaction, num, invoice: invoice, result: "success")
    end
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(@customers[5].first_name).to appear_before(@customers[4].first_name)
    expect(@customers[2].first_name).to appear_before(@customers[1].first_name)
    expect(page).to_not have_content(@customers[0].first_name)
  end

  it 'should have items ready to ship in order from oldest to newest' do
    @items = create_list(:item, 6, merchant: @merchant)
    @customers = create_list(:customer, 6)

    @customers.zip(@items) do |customer, item|
      invoice = create(:invoice, customer: customer)
      create(:invoice_item, invoice: invoice, item: item, status: 0)
    end

    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Items Ready to Ship")
    expect(page).to have_content(@merchant.shippable_items.first.name)
    expect(page).to have_content(DateTime.now.new_offset(0).strftime("%A, %B %d, %Y"))
    expect(@merchant.shippable_items.first.name).to appear_before(@merchant.shippable_items.last.name)
  end
end
