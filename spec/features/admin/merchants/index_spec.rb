require 'rails_helper'

RSpec.describe 'The Admin Merchants Index' do
  it 'displays the name of each merchant in the system' do
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    visit admin_merchants_path
    within '#enabled' do
      within '#the-duke' do
        expect(page).to have_content(merchant1.name)
      end
      within '#the-fluke' do
        expect(page).to have_content(merchant2.name)
      end
      within '#the-crook' do
        expect(page).to have_content(merchant3.name)
      end
    end
  end

  it 'displays each merchant name as a link to that merchants show page' do
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    visit admin_merchants_path

    within '#enabled' do
      expect(page).to have_link(merchant1.name)
      click_link(merchant1.name)
      expect(current_path).to eq(admin_merchant_path(merchant1.id))
    end
  end

  it 'displays a button an admin can use to disable an enabled merchants status' do
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    visit admin_merchants_path
    within '#enabled' do
      within '#the-duke' do
        expect(page).to have_button('disable merchant')
        expect(merchant1.status).to eq('enabled')
        expect(page).to have_no_button('enable merchant')
        click_button('disable merchant')
        expect(current_path).to eq(admin_merchants_path)
        merchant1.reload
        expect(merchant1.status).to eq('disabled')
      end
    end
  end

  it 'displays a button an admin can use to enable a disabled merchants status' do
    merchant1 = Merchant.create!(name: 'The Duke', status: :disabled)
    visit admin_merchants_path
    within '#disabled' do
      within '#the-duke' do
        expect(page).to have_button('enable merchant')
        expect(merchant1.status).to eq('disabled')
        expect(page).to have_no_button('disable merchant')
        click_button('enable merchant')
        expect(current_path).to eq(admin_merchants_path)
        merchant1.reload
        expect(merchant1.status).to eq('enabled')
      end
    end
  end

  it 'displays a section for enabled merchants' do
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    merchant4 = Merchant.create!(name: 'The Hook', status: :disabled)
    merchant5 = Merchant.create!(name: 'The Nook', status: :disabled)
    visit admin_merchants_path
    within '#enabled' do
      expect(page).to have_content('Enabled Merchants')
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(merchant3.name)
      expect(page).to have_no_content(merchant4.name)
    end
  end

  it 'displays a section for disabled merchants' do
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    merchant1 = Merchant.create!(name: 'The Duke')
    merchant2 = Merchant.create!(name: 'The Fluke')
    merchant3 = Merchant.create!(name: 'The Crook')
    merchant4 = Merchant.create!(name: 'The Hook', status: :disabled)
    merchant5 = Merchant.create!(name: 'The Nook', status: :disabled)

    visit admin_merchants_path
    within '#disabled' do
      expect(page).to have_content('Disabled Merchants')
      expect(page).to have_content(merchant4.name)
      expect(page).to have_content(merchant5.name)
      expect(page).to have_no_content(merchant3.name)
      expect(page).to have_no_content(merchant1.name)
    end
  end

  it 'has a button that brings the user to a form to create a new merchant' do
    visit admin_merchants_path
    within '#create' do
      expect(page).to have_button('Create New Merchant')
      click_button('Create New Merchant')
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end

  it 'displays the top five merchants and the total revenue they generated' do
    merchant1 = Merchant.create!(name: 'BuyMyThings1')
    merchant2 = Merchant.create!(name: 'BuyMyThings2')
    merchant3 = Merchant.create!(name: 'BuyMyThings3')
    merchant4 = Merchant.create!(name: 'BuyMyThings4')
    merchant5 = Merchant.create!(name: 'BuyMyThings5')
    merchant6 = Merchant.create!(name: 'BuyMyThings6')

    customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')

    invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
    invoice2 = Invoice.create!(status: 0, customer_id: customer1.id)

    item1 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant1.id)
    item2 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant1.id)
    item3 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant2.id)
    item4 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant2.id)
    item5 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant3.id)
    item6 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant3.id)
    item7 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant4.id)
    item8 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant4.id)
    item9 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant5.id)
    item10 = Item.create!(name: 'really good item0', description: 'really good', unit_price: 10_000,
                          merchant_id: merchant5.id)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 400,
                                        status: 1)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 2, unit_price: 200,
                                        status: 1)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice1.id, quantity: 5, unit_price: 100,
                                        status: 1)
    invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice1.id, quantity: 2, unit_price: 400,
                                        status: 1)
    invoice_item7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice1.id, quantity: 3, unit_price: 200,
                                        status: 1)
    invoice_item8 = InvoiceItem.create!(item_id: item8.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item9 = InvoiceItem.create!(item_id: item9.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item10 = InvoiceItem.create!(item_id: item10.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                         status: 1)

    transaction1 = Transaction.create!(result: 0, invoice_id: invoice1.id)
    transaction2 = Transaction.create!(result: 0, invoice_id: invoice2.id)

    visit admin_merchants_path
    within "#top_merchant-#{merchant1.id}" do
      expect(page).to have_link(merchant1.name)
      expect(page).to have_content('Rank: 1')
      expect(page).to have_content('Total Revenue: $28.00')
    end
    within '#top_five_merchants' do
      expect(page).to have_content('Top Merchants')
      expect(page).to have_no_content(merchant6.name)
    end
  end

  it 'displays the date where a top merchant had the highest revenue' do
    merchant1 = Merchant.create!(name: 'BuyMyThings1')
    merchant2 = Merchant.create!(name: 'BuyMyThings2')
    merchant3 = Merchant.create!(name: 'BuyMyThings3')
    merchant4 = Merchant.create!(name: 'BuyMyThings4')
    merchant5 = Merchant.create!(name: 'BuyMyThings5')
    merchant6 = Merchant.create!(name: 'BuyMyThings6')

    customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')

    invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
    invoice2 = Invoice.create!(status: 0, customer_id: customer1.id)

    item1 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant1.id)
    item2 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant1.id)
    item3 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant2.id)
    item4 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant2.id)
    item5 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant3.id)
    item6 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant3.id)
    item7 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant4.id)
    item8 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant4.id)
    item9 = Item.create!(name: 'really good item', description: 'really good', unit_price: 10_000,
                         merchant_id: merchant5.id)
    item10 = Item.create!(name: 'really good item0', description: 'really good', unit_price: 10_000,
                          merchant_id: merchant5.id)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 400,
                                        status: 1)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 2, unit_price: 200,
                                        status: 1)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice1.id, quantity: 5, unit_price: 100,
                                        status: 1)
    invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice1.id, quantity: 2, unit_price: 400,
                                        status: 1)
    invoice_item7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice1.id, quantity: 3, unit_price: 200,
                                        status: 1)
    invoice_item8 = InvoiceItem.create!(item_id: item8.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item9 = InvoiceItem.create!(item_id: item9.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item10 = InvoiceItem.create!(item_id: item10.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                         status: 1)

    transaction1 = Transaction.create!(result: 0, invoice_id: invoice1.id)
    transaction2 = Transaction.create!(result: 0, invoice_id: invoice2.id)

    visit admin_merchants_path
    within "#top_merchant-#{merchant1.id}" do
      expect(page).to have_content("Top selling date for #{merchant1.name} was #{merchant1.format_created_at(merchant1.top_merchant_best_day)}")
    end
    within "#top_merchant-#{merchant2.id}" do
      expect(page).to have_content("Top selling date for #{merchant2.name} was #{merchant2.format_created_at(merchant2.top_merchant_best_day)}")
    end
  end
end
