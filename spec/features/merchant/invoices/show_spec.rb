require 'rails_helper'

RSpec.describe 'the merchant invoice index page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @customer1 = create(:customer)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)
    @item6 = create(:item, merchant_id: @merchant1.id, name: "Expect Me")
    @item7 = create(:item, merchant_id: @merchant2.id)

    @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC", customer_id: @customer1.id)

    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, status: 2, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id, status: 2, quantity: 4, unit_price: 100)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item4.id, status: 0, quantity: 3, unit_price: 100)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item5.id, status: 2, quantity: 2, unit_price: 100)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item6.id, status: 1, quantity: 1, unit_price: 100)
    @invoice_item7 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item7.id, status: 2, quantity: 1, unit_price: 100)
  end

  it " shows id, status and created at" do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content("Monday, March 25, 2013")
  end

  it "shows customer first and last name" do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)
  end

  it "shows all items on invoice" do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    within("#invoice_item-#{@invoice_item1.id}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.status)
    end

    within("#invoice_item-#{@invoice_item6.id}") do
      expect(page).to have_content(@item6.name)
      expect(page).to have_content(@invoice_item6.quantity)
      expect(page).to have_content(@invoice_item6.status)
    end

    expect(page).not_to have_content(@item7.name)
  end

  it "shows total revenue for all items on the invoice" do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    expect(page).to have_content("Total Revenue: $2100")
  end

  it 'shows update item status select field and update button' do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id )

    within("#invoice_item-#{@invoice_item6.id}") do
      expect(page).to have_select("invoice_item_status", selected: "packaged")
      expect(page).to have_button("Update Item Status")
    end
  end

  it 'can update status' do
    visit merchant_invoice_path( @merchant1.id, @invoice1.id)

    within("#invoice_item-#{@invoice_item6.id}") do
      select 'shipped', from: "invoice_item_status"
      click_button("Update Item Status")
    end
    within("#invoice_item-#{@invoice_item6.id}") do
      expect(page).to have_select("invoice_item_status", selected: "shipped")
    end

    expect(current_path).to eq(merchant_invoice_path(@merchant1.id, @invoice1.id))
  end
end
