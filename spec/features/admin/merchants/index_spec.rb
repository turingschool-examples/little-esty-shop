require 'rails_helper'

RSpec.describe 'admin merchants index page' do

  it "has the name of each merchant in the system" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    merchant_3 = Merchant.create!(name: 'merchant_3')

    visit '/admin/merchants'

    expect(page).to have_content('Name: merchant_1')
    expect(page).to have_content('Name: merchant_2')
    expect(page).to have_content('Name: merchant_3')
  end

  it 'each name is a link when I click that link I am taken to the show page' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    merchant_3 = Merchant.create!(name: 'merchant_3')

    visit '/admin/merchants'

    expect(page).to have_link("#{merchant_1.name}")
    expect(page).to have_link("#{merchant_2.name}")
    expect(page).to have_link("#{merchant_3.name}")
    click_link("#{merchant_1.name}")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
  end

  it 'has button to toggle merchant status' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)

    visit '/admin/merchants'

    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'when clicked merchant status is changed' do
    merchant_1 = Merchant.create!(name: 'merchant_1')

    visit '/admin/merchants'

    click_button("Enable")

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Status: enable")
  end

  it 'creates new merchants' do
    visit '/admin/merchants'
    click_link("Add Merchant")
    fill_in 'Name', with: "new merchant"
    click_button("Submit")

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("new merchant")
    expect(page).to have_content("Status: disable")
  end

  it "has merchants listed in corresponding enabled or disabled sections" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)
    merchant_3 = Merchant.create!(name: 'merchant_3')
    merchant_4 = Merchant.create!(name: 'merchant_4', status: 0)

    visit '/admin/merchants'

    within('#enabled_merchants') do
      expect(page).to have_content('Enabled Merchants:')
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content(merchant_4.name)
    end

    within('#disabled_merchants') do
      expect(page).to have_content('Disabled Merchants:')
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_3.name)
    end
  end

  it 'lists top 5 merhcants by revenue with revenue generated next to merchant name' do
    merchant_1 = Merchant.create!(name: 'Seth')
    item_1 = create(:item, merchant_id: merchant_1.id)
    customer_1 = create(:customer)
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 2, quantity: 1, unit_price: 5)

    merchant_2 = Merchant.create!(name: 'John')
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 2, quantity: 1, unit_price: 5)

    merchant_3 = Merchant.create!(name: 'Jim')
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, status: 2, quantity: 1, unit_price: 5)

    merchant_4 = Merchant.create!(name: 'Ben')
    item_4 = create(:item, merchant_id: merchant_4.id)
    invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_4.id, status: 2, quantity: 1, unit_price: 5)

    merchant_5 = Merchant.create!(name: 'Josh')
    item_5 = create(:item, merchant_id: merchant_5.id)
    invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_5.id, status: 2, quantity: 1, unit_price: 5)

    merchant_6 = Merchant.create!(name: 'Rob')
    item_6 = create(:item, merchant_id: merchant_6.id)
    item_7 = create(:item, merchant_id: merchant_6.id)
    invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 5)
    invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_6.id, status: 1, quantity: 1)
    visit '/admin/merchants'
    within"#top_five_merchants" do
      expect(page).to have_content("Merchant: #{merchant_1.name} - 30")
      expect(page).to have_content("Merchant: #{merchant_2.name} - 25")
      expect(page).to have_content("Merchant: #{merchant_3.name} - 20")
      expect(page).to have_content("Merchant: #{merchant_4.name} - 15")
      expect(page).to have_content("Merchant: #{merchant_5.name} - 10")
      expect(merchant_1.name).to appear_before(merchant_2.name)
      expect(merchant_2.name).to appear_before(merchant_3.name)
      expect(merchant_3.name).to appear_before(merchant_4.name)
      expect(merchant_4.name).to appear_before(merchant_5.name)
      expect(page).to_not have_content(merchant_6.name)
    end
  end

  it 'lists the date with the most revenue for that merchant' do
    merchant_1 = Merchant.create!(name: 'Seth')
    item_1 = create(:item, merchant_id: merchant_1.id)
    customer_1 = create(:customer)
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 2, quantity: 1, unit_price: 5)

    merchant_2 = Merchant.create!(name: 'John')
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 2, quantity: 1, unit_price: 5)

    merchant_3 = Merchant.create!(name: 'Jim')
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, status: 2, quantity: 1, unit_price: 5)

    merchant_4 = Merchant.create!(name: 'Ben')
    item_4 = create(:item, merchant_id: merchant_4.id)
    invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
    transaction_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_4.id, status: 2, quantity: 1, unit_price: 5)

    merchant_6 = Merchant.create!(name: 'Rob')
    item_6 = create(:item, merchant_id: merchant_6.id)
    item_7 = create(:item, merchant_id: merchant_6.id)
    invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
    invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2013-03-25 09:54:09 UTC")
    invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2014-03-25 09:54:09 UTC")
    transaction_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 10, unit_price: 5)
    invoice_item_7 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_7.id, status: 2, quantity: 1, unit_price: 5)
    invoice_item_8 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 10, unit_price: 5)

    visit '/admin/merchants'
    within "#top_five_merchants" do
      expect(page).to have_content("Top Selling Date: #{invoice_8.created_at}")
    end
  end

end
