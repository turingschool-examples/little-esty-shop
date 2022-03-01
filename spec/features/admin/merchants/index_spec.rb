require 'rails_helper'

RSpec.describe 'the admin merchant index' do

  # describe 'github api' do
  #   it "has the repo name" do
  #     visit "/admin/merchants"
  #
  #     within ".github-info" do
  #       expect(page).to have_content("SullyBirashk/little-esty-shop")
  #     end
  #   end
  # end

  it 'list the merchants' do
    merchant_1 = Merchant.create!(name: "Staples")
    merchant_2 = Merchant.create!(name: "Home Depot")

    visit '/admin/merchants'

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
  end

  it "lists the top 5 merchants by total revenue generated as links" do
    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

    invoice_1 = customer_1.invoices.create!(status: "completed")
    invoice_2 = customer_1.invoices.create!(status: "cancelled")
    invoice_3 = customer_1.invoices.create!(status: "in progress")
    invoice_4 = customer_1.invoices.create!(status: "completed")
    invoice_5 = customer_1.invoices.create!(status: "cancelled")
    invoice_6 = customer_1.invoices.create!(status: "in progress")
    invoice_7 = customer_1.invoices.create!(status: "completed")
    invoice_8 = customer_1.invoices.create!(status: "cancelled")

    transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
    transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "failed")
    transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
    transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249638", result: "success")

    merchant_1 = Merchant.create!(name: "Staples")
    merchant_2 = Merchant.create!(name: "Home Depot")
    merchant_3 = Merchant.create!(name: "Office Depot")
    merchant_4 = Merchant.create!(name: "Lowes")
    merchant_5 = Merchant.create!(name: "Frys")
    merchant_6 = Merchant.create!(name: "Sears")
    merchant_7 = Merchant.create!(name: "Walmart")
    merchant_8 = Merchant.create!(name: "Target")

    item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    item_2 = merchant_2.items.create!(name: "paper", description: "construction", unit_price: 29)
    item_3 = merchant_3.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    item_4 = merchant_4.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
    item_5 = merchant_5.items.create!(name: "pencil", description: "24 Count", unit_price: 35)
    item_6 = merchant_6.items.create!(name: "fountain pen", description: "24 Count", unit_price: 45)
    item_7 = merchant_7.items.create!(name: "Sticky Notes", description: "24 Count", unit_price: 55)
    item_8 = merchant_8.items.create!(name: "Scissors", description: "2 Count", unit_price: 22)

    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: "shipped")
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: "shipped")
    invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: "shipped")
    invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 20, status: "shipped")
    invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 25, status: "shipped")
    invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 30, status: "shipped")
    invoice_item_7 = InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, unit_price: 35, status: "shipped")
    invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, unit_price: 40, status: "shipped")

    visit '/admin/merchants'

    within ".top_merchants" do
      expect(page).to_not have_link(merchant_1.name)
      expect(page).to have_link(merchant_2.name)
      expect(page).to have_link(merchant_3.name)
      expect(page).to have_link(merchant_4.name)
      expect(page).to_not have_link(merchant_5.name)
      expect(page).to_not have_link(merchant_6.name)
      expect(page).to have_link(merchant_7.name)
      expect(page).to have_link(merchant_8.name)
    end
  end

  it "each top merchant is a link to it's admin show page" do
    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    invoice_1 = customer_1.invoices.create!(status: "completed")
    transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    merchant_1 = Merchant.create!(name: "Staples")
    item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: "shipped")

    visit '/admin/merchants'

    within ".top_merchants" do
      click_link(merchant_1.name)
    end

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    expect(page).to have_content(merchant_1.name)
  end

  it "each merchant's total revenue generated is next to their name" do
    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

    invoice_1 = customer_1.invoices.create!(status: "completed")
    invoice_2 = customer_1.invoices.create!(status: "cancelled")
    invoice_3 = customer_1.invoices.create!(status: "in progress")
    invoice_4 = customer_1.invoices.create!(status: "completed")
    invoice_5 = customer_1.invoices.create!(status: "cancelled")
    invoice_6 = customer_1.invoices.create!(status: "in progress")
    invoice_7 = customer_1.invoices.create!(status: "completed")
    invoice_8 = customer_1.invoices.create!(status: "cancelled")

    transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
    transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "failed")
    transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
    transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249638", result: "success")

    merchant_1 = Merchant.create!(name: "Staples")
    merchant_2 = Merchant.create!(name: "Home Depot")
    merchant_3 = Merchant.create!(name: "Office Depot")
    merchant_4 = Merchant.create!(name: "Lowes")
    merchant_5 = Merchant.create!(name: "Frys")
    merchant_6 = Merchant.create!(name: "Sears")
    merchant_7 = Merchant.create!(name: "Walmart")
    merchant_8 = Merchant.create!(name: "Target")

    item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    item_2 = merchant_2.items.create!(name: "paper", description: "construction", unit_price: 29)
    item_3 = merchant_3.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    item_4 = merchant_4.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
    item_5 = merchant_5.items.create!(name: "pencil", description: "24 Count", unit_price: 35)
    item_6 = merchant_6.items.create!(name: "fountain pen", description: "24 Count", unit_price: 45)
    item_7 = merchant_7.items.create!(name: "Sticky Notes", description: "24 Count", unit_price: 55)
    item_8 = merchant_8.items.create!(name: "Scissors", description: "2 Count", unit_price: 22)

    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: "shipped")
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: "shipped")
    invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: "shipped")
    invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 20, status: "shipped")
    invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 25, status: "shipped")
    invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 30, status: "shipped")
    invoice_item_7 = InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, unit_price: 35, status: "shipped")
    invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, unit_price: 40, status: "shipped")

    visit '/admin/merchants'

    within ".top_merchants" do
      expect(page).to have_content("$10")
      expect(page).to have_content("$15")
      expect(page).to have_content("$20")
      expect(page).to_not have_content("$25")
      expect(page).to_not have_content("$30")
      expect(page).to have_content("$35")
      expect(page).to have_content("$40")
    end
  end

  it "each merchant's best day is listed " do
    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

    invoice_1 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 21))
    invoice_2 = customer_1.invoices.create!(status: "cancelled", created_at: DateTime.new(2022, 2, 22))
    invoice_3 = customer_1.invoices.create!(status: "in progress", created_at: DateTime.new(2022, 2, 23))
    invoice_4 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 24))
    invoice_5 = customer_1.invoices.create!(status: "cancelled", created_at: DateTime.new(2022, 2, 25))
    invoice_6 = customer_1.invoices.create!(status: "in progress", created_at: DateTime.new(2022, 2, 26))
    invoice_7 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 27))
    invoice_8 = customer_1.invoices.create!(status: "cancelled", created_at: DateTime.new(2022, 2, 28))

    transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
    transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "failed")
    transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
    transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249638", result: "success")

    merchant_1 = Merchant.create!(name: "Staples")
    merchant_2 = Merchant.create!(name: "Home Depot")
    merchant_3 = Merchant.create!(name: "Office Depot")
    merchant_4 = Merchant.create!(name: "Lowes")
    merchant_5 = Merchant.create!(name: "Frys")
    merchant_6 = Merchant.create!(name: "Sears")
    merchant_7 = Merchant.create!(name: "Walmart")
    merchant_8 = Merchant.create!(name: "Target")

    item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    item_2 = merchant_2.items.create!(name: "paper", description: "construction", unit_price: 29)
    item_3 = merchant_3.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    item_4 = merchant_4.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
    item_5 = merchant_5.items.create!(name: "pencil", description: "24 Count", unit_price: 35)
    item_6 = merchant_6.items.create!(name: "fountain pen", description: "24 Count", unit_price: 45)
    item_7 = merchant_7.items.create!(name: "Sticky Notes", description: "24 Count", unit_price: 55)
    item_8 = merchant_8.items.create!(name: "Scissors", description: "2 Count", unit_price: 22)

    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: "shipped")
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: "shipped")
    invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: "shipped")
    invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 20, status: "shipped")
    invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 25, status: "shipped")
    invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 30, status: "shipped")
    invoice_item_7 = InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, unit_price: 35, status: "shipped")
    invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, unit_price: 40, status: "shipped")

    visit '/admin/merchants'

    within ".top_merchants" do
      expect(page).to have_content(invoice_2.created_at)
      expect(page).to have_content(invoice_3.created_at)
      expect(page).to have_content(invoice_4.created_at)
      expect(page).to_not have_content(invoice_5.created_at)
      expect(page).to_not have_content(invoice_6.created_at)
      expect(page).to have_content(invoice_7.created_at)
      expect(page).to have_content(invoice_8.created_at)
    end
  end

  it "has enabled merchants who can become disabled" do
    enabled_merchant = Merchant.create!(name: "Staples", status: "enabled")
    disabled_merchant = Merchant.create!(name: "Home Depot", status: "disabled")

    visit '/admin/merchants'

    within ".enabled_merchants" do
      expect(page).to_not have_content(disabled_merchant.name)
      expect(page).to have_content(enabled_merchant.name)

      click_button("Disable #{enabled_merchant.name}")
    end

    expect(current_path).to eq("/admin/merchants")

    within ".enabled_merchants" do
      expect(page).to_not have_content(disabled_merchant.name)
      expect(page).to_not have_content(enabled_merchant.name)
    end

    within ".disabled_merchants" do
      expect(page).to have_content(disabled_merchant.name)
      expect(page).to have_content(enabled_merchant.name)
    end
  end

  it "has disabled merchants who can become enabled" do
    enabled_merchant = Merchant.create!(name: "Staples", status: "enabled")
    disabled_merchant = Merchant.create!(name: "Home Depot", status: "disabled")

    visit '/admin/merchants'

    within ".disabled_merchants" do
      expect(page).to have_content(disabled_merchant.name)
      expect(page).to_not have_content(enabled_merchant.name)

      click_button("Enable #{disabled_merchant.name}")
    end

    expect(current_path).to eq("/admin/merchants")

    within ".disabled_merchants" do
      expect(page).to_not have_content(disabled_merchant.name)
      expect(page).to_not have_content(enabled_merchant.name)
    end

    within ".enabled_merchants" do
      expect(page).to have_content(disabled_merchant.name)
      expect(page).to have_content(enabled_merchant.name)
    end
  end


end
