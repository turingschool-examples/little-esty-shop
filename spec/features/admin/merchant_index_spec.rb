require 'rails_helper'

RSpec.describe "Admin Merchant index page" do
  before(:each)do
    @merchant1 = Merchant.create!(name: 'Ice Cream Parlour', status: "disabled")
    @merchant2 = Merchant.create!(name: 'Inked', status: "disabled")
    @merchant3 = Merchant.create!(name: 'Plants', status: "enabled")
    @merchant4 = Merchant.create!(name: 'Water Corp', status: "enabled")
    @merchant5 = Merchant.create!(name: 'Chocolates', status: "disabled")


    @item_1 = create(:item, merchant: @merchant1)
    @item_2 = create(:item, merchant: @merchant2)
    @item_3 = create(:item, merchant: @merchant3)
    @item_4 = create(:item, merchant: @merchant4)
    @item_5 = create(:item, merchant: @merchant5)

    @customer = create(:customer)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)

    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_3.id)
    @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_4.id)
    @invoice_6 = Invoice.create!(status: 0, customer_id: @customer_5.id)

    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 2, status: 2)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 40, status: 2)
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 5, status: 2)
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 2, status: 2)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 3, unit_price: 5, status: 2)

    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
    @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")

    visit "admin/merchant"
  end

  it "had a list of all merchants names" do
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_link(@merchant1.name)
    expect(page).to have_link(@merchant2.name)
    expect(page).to have_link(@merchant3.name)
    expect(page).to have_link(@merchant4.name)
    expect(page).to have_link(@merchant5.name)
  end

  it 'shows a button next to each merchant to enable or disable that merchant' do
    within("#disabled-merchant-#{@merchant2.id}") do
      expect(page).to have_button("Enable")
      click_button "Enable"
    end

    within("#enabled-merchant-#{@merchant2.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it 'can click on enable and it updates item status to enable' do
    within("#disabled-merchant-#{@merchant1.id}") do
      click_button "Enable"
    end

    expect(current_path).to eq("/admin/merchant")

    within("#enabled-merchant-#{@merchant1.id}") do
      expect(page).to have_button("Disable")
        click_button "Disable"
    end

    within("#disabled-merchant-#{@merchant1.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it 'shows section for top 5 merchants by total revenue' do
    expect(page).to have_content("Top 5 Merchants")
    expect(@merchant3.name).to appear_before(@merchant2.name)
    expect(@merchant2.name).to appear_before(@merchant4.name)
    expect(@merchant4.name).to appear_before(@merchant1.name)
    expect(@merchant1.name).to appear_before(@merchant5.name)

    expect(page).to have_link(@merchant1.name)
    expect(page).to have_link(@merchant2.name)
    expect(page).to have_link(@merchant3.name)
    expect(page).to have_link(@merchant4.name)
    expect(page).to have_link(@merchant5.name)
    expect(page).to have_content("Top selling date for #{@merchant1.name} was #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
  end
end
