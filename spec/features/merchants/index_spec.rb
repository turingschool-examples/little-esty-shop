require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: "Pabu")

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows merchant name' do
    expect(page).to have_content(@merchant1.name)
  end
  it 'has link to merchant item index' do
    within("#index-buttons") do
      click_button "Items Index"
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end
  end
  it 'has link to merchant invoices index' do
    click_button "Invoices Index"
    expect(current_path).to eq(merchant_invoices_path(@merchant1))
  end

  it "merchant dashboard items ready to ship" do
    # comprehensively tests all possible item compartmentalizations
    item_1 = @merchant_1.items.create!(name: "spoon", description: "stamped stainless steel, not deburred", unit_price: 80, status: 1, merchant_id: @merchant_1.id)
    item_2 = @merchant_1.items.create!(name: "add_foreign_key", description: "stamped stainless steel, not deburred", unit_price: 90, status: 1, merchant_id: @merchant_1.id)
    item_3 = @merchant_1.items.create!(name: "butter knife", description: "stamped stainless steel, not deburred", unit_price: 65, status: 1, merchant_id: @merchant_1.id)
    customer_1 = Customer.create(first_name: "Max", last_name: "Powers")
    customer_2 = Customer.create!(first_name: "Bob", last_name: "Ross")
    invoice_1 = customer_1.invoices.create!(status: 0)
    invoice_2 = customer_2.invoices.create!(status: 0)
    invoice_item_1 = invoice_1.invoice_items.create!(quantity: 12, unit_price: item_1.unit_price, status: 0, item_id: item_1.id)
    invoice_item_2 = invoice_2.invoice_items.create!(quantity: 12, unit_price: item_2.unit_price, status: 1, item_id: item_2.id)
    invoice_item_3 = invoice_1.invoice_items.create!(quantity: 12, unit_price: item_3.unit_price, status: 2, item_id: item_1.id)

    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_content("Items Ready to Ship")

    expect(page).to have_content("item_2.name")
    expect(page).not_to have_content("item_3.name") # Because item already shipped

    within ("#unshipped_invoice_item_#{invoice_item_1.id}") do
      expect(page).to have_content(invoice_item_1.invoice_id)
      expect(page).to have_content("item_1.name")
      expect(page).to have_link("/invoices/#{invoice_1.id}")
    end

    within ("#unshipped_invoice_item_#{invoice_item_2.id}") do
      expect(page).to have_content(invoice_item_2.invoice_id)
      expect(page).to have_content("item_2.name")
      expect(page).to have_link("/invoices/#{invoice_2.id}")
    end

  end
end
