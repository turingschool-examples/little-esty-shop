require 'rails_helper'

RSpec.describe 'invoice index page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
    @item1 = @merchant1.items.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est lauda...", unit_price: 75107)
    @item2 = @merchant1.items.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestia...", unit_price: 67076)
    @item3 = @merchant1.items.create!(name: "Item Ea Voluptatum", description: "Sunt officia eum qui molestiae. Nesciunt quidem cu...", unit_price: 32301)
    @customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
    @customer2 = Customer.create!(first_name: "Cory", last_name: "Bethune")
    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled")
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: "in progress")
    @invoice3 = Invoice.create!(customer_id: @customer2.id, status: "in progress")
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 75100, status: "shipped",)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 200000, status: "packaged",)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 32301, status: "pending",)

  end

  it "shows the invoices of the merchant" do
    visit "/merchants/#{@merchant1.id}/invoices"

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_no_content(@invoice3.id)
  end

  it "has links to the merchant invoice show page" do
    visit "/merchants/#{@merchant1.id}/invoices"

    click_link "#{@invoice2.id}"
    expect(current_path).to eq "/merchants/#{@merchant1.id}/invoices/#{@invoice2.id}"
  end

end
