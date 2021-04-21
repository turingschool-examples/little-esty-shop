require 'rails_helper'

RSpec.describe "Merchant item index page" do
  before(:each) do
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant: @merchant, status: 0)
    @item_2 = create(:item, merchant: @merchant, status: 0)
    @item_3 = create(:item, merchant: @merchant, status: 1)
    @item_4 = create(:item, merchant: @merchant, status: 1)
    @item_5 = create(:item, merchant: @merchant, status: 1)
    @item_6 = create(:item, merchant: @merchant, status: 1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @customer_7 = create(:customer)

    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 0, customer_id: @customer_6.id)
    @invoice_7 = Invoice.create!(status: 2, customer_id: @customer_7.id)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 20, status: 1)
    @invoice_item_2 =InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 20, status: 1)
    @invoice_item_3 =InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 3, unit_price: 20, status: 1)
    @invoice_item_4 =InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id, quantity: 4, unit_price: 20, status: 2)
    @invoice_item_5 =InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 5, unit_price: 20, status: 2)
    @invoice_item_5 =InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 500, unit_price: 20, status: 0)

    @transaction_1 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
    @transaction_2 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
    @transaction_3 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
    @transaction_4 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
    @transaction_5 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
    @transaction_6 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")
    @transaction_7 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: "#{@invoice_7.id}")
    visit "/merchant/#{@merchant.id}/items"
  end

  it 'can see a list of the names of all items' do
    expect(page).to have_content("My Items")
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to have_content(@item_5.name)
    expect(page).to have_content(@item_6.name)
    expect(page).to have_link(@item_1.name)
    expect(page).to have_link(@item_2.name)
    expect(page).to have_link(@item_3.name)
    expect(page).to have_link(@item_4.name)
    expect(page).to have_link(@item_5.name)
    expect(page).to have_link(@item_6.name)
  end

  it 'shows a button next to each item to enable or disable that item' do
    within("#enabled-item-#{@item_3.id}") do
      expect(page).to have_button("Disable")
    end

    within("#disabled-item-#{@item_1.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it 'can click on enable and it updates item status to enable' do
    within("#disabled-item-#{@item_1.id}") do
      click_button "Enable"
    end

    expect(current_path).to eq("/merchant/#{@merchant.id}/items")

    within("#enabled-item-#{@item_1.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it 'can click on disable and it updates item status to disabled' do
    within("#enabled-item-#{@item_3.id}") do
      click_button "Disable"
    end

    expect(current_path).to eq("/merchant/#{@merchant.id}/items")

    within("#disabled-item-#{@item_3.id}") do
      expect(page).to have_button("Enable")
    end
  end

  it 'shows a link to create a new item that I can click on and the top sell day for that item' do
    expect(page).to have_link("Create New Item")

    click_link "Create New Item"

    expect(current_path).to eq("/merchant/#{@merchant.id}/items/new")
  end

  it 'can submit a form to create a new item' do
    click_link "Create New Item"

    fill_in "Name", with: "Broom"
    fill_in "Description", with: "Sweep very well"
    fill_in "Unit price", with: 34
    click_button "Submit"

    expect(current_path).to eq("/merchant/#{@merchant.id}/items")
  end

  it 'shows a section for my top five items by revenue' do
    expect(page).to have_content("Top Items")

    within("#top-item-#{@item_5.id}") do
      expect(page).to have_content("#{@item_5.name}")
      expect(page).to have_content("#{@item_5.invoice_items.best_item_sale_day.strftime("%A, %B %d, %Y")}")
    end

    within("#top-item-#{@item_4.id}") do
      expect(page).to have_content("#{@item_4.name}")
      expect(page).to have_content("#{@item_4.invoice_items.best_item_sale_day.strftime("%A, %B %d, %Y")}")
    end

    within("#top-item-#{@item_3.id}") do
      expect(page).to have_content("#{@item_3.name}")
      expect(page).to have_content("#{@item_3.invoice_items.best_item_sale_day.strftime("%A, %B %d, %Y")}")
    end

    within("#top-item-#{@item_2.id}") do
      expect(page).to have_content("#{@item_2.name}")
      expect(page).to have_content("#{@item_2.invoice_items.best_item_sale_day.strftime("%A, %B %d, %Y")}")
    end

    within("#top-item-#{@item_1.id}") do
      expect(page).to have_content("#{@item_1.name}")
      expect(page).to have_content("#{@item_1.invoice_items.best_item_sale_day.strftime("%A, %B %d, %Y")}")
    end
  end
end
