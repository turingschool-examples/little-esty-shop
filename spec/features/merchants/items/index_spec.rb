require 'rails_helper'

RSpec.describe 'merchants items index page' do
  before :each do
    @merchant = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Kevin")
    @item_1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5, enable: 0)
    @item_2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10, enable: 0)
    @item_3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
    @item_4 = @merchant_2.items.create!(name: "Table", description: "Eat on it", unit_price: 100, enable: 0)
  end

  it 'displays merchant item names' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
  end

  it 'has a link to items show page' do
    visit "/merchants/#{@merchant.id}/items"

    click_on "#{@item_1.name}"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
  end

  it 'has a button for enable/disable item' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'allows you to click enable' do
    visit "/merchants/#{@merchant.id}/items"

    @item_2.update(enable: 1)

    within("#item-#{@item_2.id}") do
      click_on "Enable"
    end

    @item_2.reload
    expect(@item_2.enable).to eq("enabled")
  end

  it 'allows you to click disable' do
    visit "/merchants/#{@merchant.id}/items"

    within("#item-#{@item_2.id}") do
      click_on "Disable"
    end

    @item_2.reload

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/")
    expect(@item_2.enable).to eq("disabled")
  end

  it 'has an enabled only section' do
    visit "/merchants/#{@merchant.id}/items"

    within("#enabled") do
      within("#item-#{@item_2.id}") do
        expect(@item_2.enable).to eq("enabled")
        expect(page).to have_content("#{@item_2.name}")
        click_on "Disable"
      end
    end
  end

  it 'has an disabled only section' do
    visit "/merchants/#{@merchant.id}/items"

    within("#disabled") do
      within("#item-#{@item_3.id}") do
        expect(@item_3.enable).to eq("disabled")
        expect(page).to have_content("#{@item_3.name}")
      end
    end
  end

  it 'has a link to create a new item' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_link("Create new item")
    click_link "Create new item"
    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
  end

  it 'shows the 5 most popular items on the page' do
    @merch_1 = create(:merchant)
    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
    @item_1 = create(:item, merchant: @merch_1, unit_price: 100)
    @item_2 = create(:item, merchant: @merch_1, unit_price: 200)
    @item_3 = create(:item, merchant: @merch_1, unit_price: 500)
    @item_4 = create(:item, merchant: @merch_1, unit_price: 600)
    @item_5 = create(:item, merchant: @merch_1, unit_price: 1000)
    @item_6 = create(:item, merchant: @merch_1, unit_price: 2000)
    @item_7 = create(:item, merchant: @merch_1, unit_price: 5000)
    @invoice_1 = create(:invoice, customer: @cust_1)
    @invoice_2 = create(:invoice, customer: @cust_2)
    @invoice_3 = create(:invoice, customer: @cust_3)
    @invoice_4 = create(:invoice, customer: @cust_4)
    @invoice_5 = create(:invoice, customer: @cust_5)
    @invoice_6 = create(:invoice, customer: @cust_6)
    @invoice_7 = create(:invoice, customer: @cust_6)
    @invoice_8 = create(:invoice, customer: @cust_6)
    @invoice_9 = create(:invoice, customer: @cust_6)
    @invoice_10 = create(:invoice, customer: @cust_6)
    @invoice_11 = create(:invoice, customer: @cust_6)
    @invoice_12 = create(:invoice, customer: @cust_6)
    @invoice_13 = create(:invoice, customer: @cust_6)
    @invoice_14 = create(:invoice, customer: @cust_6)
    InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)
    InvoiceItem.create(item: @item_1, invoice: @invoice_2, quantity: 2, unit_price: @item_1.unit_price)
    InvoiceItem.create(item: @item_2, invoice: @invoice_4, quantity: 4, unit_price: @item_2.unit_price)
    InvoiceItem.create(item: @item_2, invoice: @invoice_3, quantity: 3, unit_price: @item_2.unit_price)
    InvoiceItem.create(item: @item_3, invoice: @invoice_5, quantity: 5, unit_price: @item_3.unit_price)
    InvoiceItem.create(item: @item_3, invoice: @invoice_6, quantity: 6, unit_price: @item_3.unit_price)
    InvoiceItem.create(item: @item_4, invoice: @invoice_7, quantity: 7, unit_price: @item_4.unit_price)
    InvoiceItem.create(item: @item_4, invoice: @invoice_8, quantity: 8, unit_price: @item_4.unit_price)
    InvoiceItem.create(item: @item_5, invoice: @invoice_9, quantity: 9, unit_price: @item_5.unit_price)
    InvoiceItem.create(item: @item_5, invoice: @invoice_10, quantity: 10, unit_price: @item_5.unit_price)
    InvoiceItem.create(item: @item_6, invoice: @invoice_11, quantity: 11, unit_price: @item_6.unit_price)
    InvoiceItem.create(item: @item_6, invoice: @invoice_12, quantity: 12, unit_price: @item_6.unit_price)
    InvoiceItem.create(item: @item_7, invoice: @invoice_13, quantity: 13, unit_price: @item_7.unit_price)
    InvoiceItem.create(item: @item_7, invoice: @invoice_14, quantity: 14, unit_price: @item_7.unit_price)
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_2, result: 'success')
    create(:transaction, invoice: @invoice_2, result: 'success')
    create(:transaction, invoice: @invoice_3, result: 'success')
    create(:transaction, invoice: @invoice_3, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_5, result: 'success')
    create(:transaction, invoice: @invoice_5, result: 'success')
    create(:transaction, invoice: @invoice_6, result: 'success')
    create(:transaction, invoice: @invoice_7, result: 'success')
    create(:transaction, invoice: @invoice_8, result: 'success')
    create(:transaction, invoice: @invoice_9, result: 'success')
    create(:transaction, invoice: @invoice_10, result: 'success')
    create(:transaction, invoice: @invoice_11, result: 'success')
    create(:transaction, invoice: @invoice_12, result: 'success')
    create(:transaction, invoice: @invoice_13, result: 'success')
    create(:transaction, invoice: @invoice_14, result: 'success')

    visit "/merchants/#{@merch_1.id}/items"

    expect(page).to have_content("Most Popular Items")
    expect(page).to have_content(@item_7.name)
    expect(page).to have_content(@item_6.name)
    expect(page).to have_content(@item_5.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to have_content(@item_3.name)
  end

  it 'has links to all 5 popular items' do
    @merch_1 = create(:merchant)
    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
    @item_1 = create(:item, merchant: @merch_1, unit_price: 100)
    @item_2 = create(:item, merchant: @merch_1, unit_price: 200)
    @item_3 = create(:item, merchant: @merch_1, unit_price: 500)
    @item_4 = create(:item, merchant: @merch_1, unit_price: 600)
    @item_5 = create(:item, merchant: @merch_1, unit_price: 1000)
    @item_6 = create(:item, merchant: @merch_1, unit_price: 2000)
    @item_7 = create(:item, merchant: @merch_1, unit_price: 5000)
    @invoice_1 = create(:invoice, customer: @cust_1)
    @invoice_2 = create(:invoice, customer: @cust_2)
    @invoice_3 = create(:invoice, customer: @cust_3)
    @invoice_4 = create(:invoice, customer: @cust_4)
    @invoice_5 = create(:invoice, customer: @cust_5)
    @invoice_6 = create(:invoice, customer: @cust_6)
    @invoice_7 = create(:invoice, customer: @cust_6)
    @invoice_8 = create(:invoice, customer: @cust_6)
    @invoice_9 = create(:invoice, customer: @cust_6)
    @invoice_10 = create(:invoice, customer: @cust_6)
    @invoice_11 = create(:invoice, customer: @cust_6)
    @invoice_12 = create(:invoice, customer: @cust_6)
    @invoice_13 = create(:invoice, customer: @cust_6)
    @invoice_14 = create(:invoice, customer: @cust_6)
    InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)
    InvoiceItem.create(item: @item_1, invoice: @invoice_2, quantity: 2, unit_price: @item_1.unit_price)
    InvoiceItem.create(item: @item_2, invoice: @invoice_4, quantity: 4, unit_price: @item_2.unit_price)
    InvoiceItem.create(item: @item_2, invoice: @invoice_3, quantity: 3, unit_price: @item_2.unit_price)
    InvoiceItem.create(item: @item_3, invoice: @invoice_5, quantity: 5, unit_price: @item_3.unit_price)
    InvoiceItem.create(item: @item_3, invoice: @invoice_6, quantity: 6, unit_price: @item_3.unit_price)
    InvoiceItem.create(item: @item_4, invoice: @invoice_7, quantity: 7, unit_price: @item_4.unit_price)
    InvoiceItem.create(item: @item_4, invoice: @invoice_8, quantity: 8, unit_price: @item_4.unit_price)
    InvoiceItem.create(item: @item_5, invoice: @invoice_9, quantity: 9, unit_price: @item_5.unit_price)
    InvoiceItem.create(item: @item_5, invoice: @invoice_10, quantity: 10, unit_price: @item_5.unit_price)
    InvoiceItem.create(item: @item_6, invoice: @invoice_11, quantity: 11, unit_price: @item_6.unit_price)
    InvoiceItem.create(item: @item_6, invoice: @invoice_12, quantity: 12, unit_price: @item_6.unit_price)
    InvoiceItem.create(item: @item_7, invoice: @invoice_13, quantity: 13, unit_price: @item_7.unit_price)
    InvoiceItem.create(item: @item_7, invoice: @invoice_14, quantity: 14, unit_price: @item_7.unit_price)
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_2, result: 'success')
    create(:transaction, invoice: @invoice_2, result: 'success')
    create(:transaction, invoice: @invoice_3, result: 'success')
    create(:transaction, invoice: @invoice_3, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_5, result: 'success')
    create(:transaction, invoice: @invoice_5, result: 'success')
    create(:transaction, invoice: @invoice_6, result: 'success')
    create(:transaction, invoice: @invoice_7, result: 'success')
    create(:transaction, invoice: @invoice_8, result: 'success')
    create(:transaction, invoice: @invoice_9, result: 'success')
    create(:transaction, invoice: @invoice_10, result: 'success')
    create(:transaction, invoice: @invoice_11, result: 'success')
    create(:transaction, invoice: @invoice_12, result: 'success')
    create(:transaction, invoice: @invoice_13, result: 'success')
    create(:transaction, invoice: @invoice_14, result: 'success')

    visit "/merchants/#{@merch_1.id}/items"

    expect(page).to have_link(@item_7.name)
    expect(page).to have_link(@item_6.name)
    expect(page).to have_link(@item_5.name)
    expect(page).to have_link(@item_4.name)
    expect(page).to have_link(@item_3.name)

    within("#popular") do
      click_link "#{@item_4.name}"
    end

    expect(current_path).to eq("/merchants/#{@merch_1.id}/items/#{@item_4.id}")
  end

end
