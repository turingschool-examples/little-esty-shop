require 'rails_helper'

RSpec.describe 'the admin_merchants index' do
  it 'shows the names of all of the merchants' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover")
    merchant_3 = Merchant.create!(name: "Powell's City of Books")

    visit '/admin/merchants'
    expect(current_path).to eq('/admin/merchants')

    expect(page).to have_content("Wizards Chest")
    expect(page).to have_content("Tattered Cover")
    expect(page).to have_content("Powell's City of Books")
  end

  it 'has links to the merchants show page' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover")
    merchant_3 = Merchant.create!(name: "Powell's City of Books")

    visit '/admin/merchants'

    expect(page).to have_link("Wizards Chest")
    expect(page).to have_link("Tattered Cover")
    expect(page).to have_link("Powell's City of Books")

    click_link("Wizards Chest")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    expect(page).to have_content("Wizards Chest")
    expect(page).to_not have_content("Powell's City of Books")
  end

  it "has button to enable/disable status" do
    merchant_1 = Merchant.create!(name: "Wizards Chest", status: "disabled")
    merchant_2 = Merchant.create!(name: "Tattered Cover")

    visit '/admin/merchants'

    within "#merchant_disabled-#{merchant_1.id}" do
      expect(page).to have_button("Enable #{merchant_1.name}")
      expect(page).to_not have_button("Disable #{merchant_1.name}")
    end

    within "#merchant_enabled-#{merchant_2.id}" do
      expect(page).to have_button("Disable #{merchant_2.name}")
      expect(page).to_not have_button("Enable #{merchant_2.name}")
    end
  end

  it "clicking button changes status" do
    merchant_1 = Merchant.create!(name: "Wizards Chest", status: "disabled")

    visit '/admin/merchants'

    within "#merchant_disabled-#{merchant_1.id}" do
      expect(page).to have_button("Enable #{merchant_1.name}")
    end

    click_button("Enable #{merchant_1.name}")
    expect(current_path).to eq('/admin/merchants')

    within "#merchant_enabled-#{merchant_1.id}" do
      expect(page).to have_button("Disable #{merchant_1.name}")
    end
  end

  it 'sort merchants into groups by status' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Powell's City of Books", status: "disabled")

    visit '/admin/merchants'

    within "#merchant_disabled-#{merchant_2.id}" do
      expect(page).to have_button("Enable #{merchant_2.name}")
      expect(page).to_not have_button("Enable #{merchant_1.name}")
    end

    within "#merchant_enabled-#{merchant_1.id}" do
      expect(page).to have_button("Disable #{merchant_1.name}")
      expect(page).to_not have_button("Enable #{merchant_2.name}")
    end
  end

  it 'can create new merchants' do
    visit '/admin/merchants'

    expect(page).to_not have_content("Cats!")
    expect(page).to_not have_button("Enable Cats!")

    expect(page).to have_link("Create Merchant")
    click_link("Create Merchant")
    expect(current_path).to eq("/admin/merchants/new")

    fill_in 'name', with: 'Cats!'

    click_on 'Submit'
    expect(current_path).to eq("/admin/merchants")

    expect(page).to have_content("Cats!")
    expect(page).to have_button("Enable Cats!")
  end

  it 'shows the top 5 merchants by revenue and when a merchant id is clicked, it redirects to that merchants admin show page' do

      customer_1 = Customer.create!(first_name: "A", last_name: "A")

      invoice_1 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_3 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_4 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_5 = Invoice.create!(status: "completed", customer_id: customer_1.id)
      invoice_6 = Invoice.create!(status: "completed", customer_id: customer_1.id)

      transaction_1 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_1.id)
      transaction_2 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_2.id)
      transaction_3 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_3.id)
      transaction_4 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_4.id)
      transaction_5 = Transaction.create!(result: "success", credit_card_number: "0000111122223333", invoice_id: invoice_5.id)
      transaction_6 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id)
      transaction_7 = Transaction.create!(result: "failed", credit_card_number: "0000111122223333", invoice_id: invoice_6.id) #both failed
        
      merchant_1 = Merchant.create!(name: "Wizards Chest")
      merchant_2 = Merchant.create!(name: "Pirates Chest")
      merchant_3 = Merchant.create!(name: "Pokemon Chest")
      merchant_4 = Merchant.create!(name: "Dungeons and Dragons Store")
      merchant_5 = Merchant.create!(name: "Star Trek Store")
      merchant_6 = Merchant.create!(name: "Star Wars Store")

      item_1 = Item.create!(name: "A", description: "A", unit_price: 400, merchant_id: merchant_1.id) #2000
      item_2 = Item.create!(name: "B", description: "B", unit_price: 200, merchant_id: merchant_2.id) #3000
      item_3 = Item.create!(name: "C", description: "C", unit_price: 500, merchant_id: merchant_3.id) #1500
      item_4 = Item.create!(name: "D", description: "D", unit_price: 100, merchant_id: merchant_4.id) #4000
      item_5 = Item.create!(name: "E", description: "E", unit_price: 300, merchant_id: merchant_5.id) #2500
      item_6 = Item.create!(name: "F", description: "F", unit_price: 600, merchant_id: merchant_6.id) #3600


      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: "shipped", quantity: 20, unit_price: 100) #2000
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: "shipped", quantity: 15, unit_price: 200) #3000
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: "shipped", quantity: 5, unit_price: 300) #1500
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: "shipped", quantity: 10, unit_price: 400) #4000
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: "shipped", quantity: 5, unit_price: 500) #2500
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: "shipped", quantity: 6, unit_price: 600) #3600

    visit '/admin/merchants'

    within "#merchants_by_revenue" do
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_content(merchant_4.name)
      expect(page).to have_content(merchant_5.name)
      expect(page).to have_no_content(merchant_6.name)
    end

    within "#merchants_by_revenue" do
      expect(merchant_4.name).to appear_before(merchant_2.name)
      expect(merchant_2.name).to appear_before(merchant_5.name)
      expect(merchant_5.name).to appear_before(merchant_1.name)
      expect(merchant_1.name).to appear_before(merchant_3.name)
    end

    within "#merchants_revenue-#{merchant_1.id}" do
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content("2000")
    end

    within "#merchants_revenue-#{merchant_2.id}" do
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content("3000")
    end

    within "#merchants_revenue-#{merchant_3.id}" do
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_content("1500")
    end

    within "#merchants_revenue-#{merchant_4.id}" do
      expect(page).to have_content(merchant_4.name)
      expect(page).to have_content("4000")
    end

    within "#merchants_revenue-#{merchant_5.id}" do
      expect(page).to have_content(merchant_5.name)
      expect(page).to have_content("2500")
    end

    within "#merchants_revenue-#{merchant_5.id}" do
      click_on "#{merchant_5.name}"

      expect(current_path).to eq("/admin/merchants/#{merchant_5.id}")
    end
  end
end
