require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  before :each do
    @merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    @merch2 = Merchant.create!(name: 'Molly Fine Arts')
    @merch3 = Merchant.create!(name: 'Treats and Things')
  end

  it 'shows the merchants name' do
    visit "/merchants/#{@merch1.id}"

    within('#merchant-details') do
      expect(page).to have_content('Jolly Roger Imports')
      expect(page).to_not have_content('Molly Fine Arts')
    end

    visit "/merchants/#{@merch2.id}"

    within('#merchant-details') do
      expect(page).to have_content('Molly Fine Arts')
      expect(page).to_not have_content('Treats and Things')
    end
  end
  it 'has a link to the merchants items page' do
    visit "/merchants/#{@merch1.id}"

    within('#merchant-links') do
      expect(page).to have_link('My Items')
      click_on('My Items')
      expect(current_path).to eq("/merchants/#{@merch1.id}/items")
    end
  end

  it 'has a link to the merchants invoices page' do
    visit "/merchants/#{@merch1.id}"

    within('#merchant-links') do
      expect(page).to have_link('My Invoices')
      click_on('My Invoices')
      expect(current_path).to eq("/merchants/#{@merch1.id}/invoices")
    end
  end

  describe 'Items Ready to Ship' do
    it 'lists items that are ready to ship ordered oldest to newest' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = @merch2.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = @merch2.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = @merch2.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)
      invoice_item3 = InvoiceItem.create!(invoice: invoice2, item: item2, quantity: 1, unit_price: 10, status: 2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 1, unit_price: 10, status: 1)

      visit "/merchants/#{@merch2.id}"

      within '#items-ready-to-ship' do
        expect(page).to have_content('Copper Bracelet')
        expect(page).to have_content('Lemongrass Extract')
        expect(page).to_not have_content('Copper Ring')
        expect(invoice_item1.id.to_s).to appear_before(invoice_item4.id.to_s)
        expect(invoice_item4.id.to_s).to appear_before(invoice_item2.id.to_s)
      end
    end

    it 'lists the date the invoice was created next to the item name' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = @merch2.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = @merch2.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = @merch2.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)
      invoice_item3 = InvoiceItem.create!(invoice: invoice2, item: item2, quantity: 1, unit_price: 10, status: 2)
      invoice_item4 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 10, status: 2)

      visit "/merchants/#{@merch2.id}"

      within "#invoice-item-#{invoice_item1.id}" do
        expect(page).to have_content(invoice_item1.invoice.formatted_date)
      end

      within "#invoice-item-#{invoice_item2.id}" do
        expect(page).to have_content(invoice_item2.invoice.formatted_date)
      end
    end
    it 'each invoice id is a link to that invoices show page' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = @merch2.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item3 = @merch2.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)

      visit "/merchants/#{@merch2.id}"

      within "#invoice-item-#{invoice_item1.id}" do
        expect(page).to have_link("Invoice ##{invoice_item1.invoice.id}")
      end
      within "#invoice-item-#{invoice_item2.id}" do
        expect(page).to have_link("Invoice ##{invoice_item2.invoice.id}")
      end
    end
    it 'invoice id link takes you to the invoices#show page' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      customer2 = Customer.create!(first_name: 'Vera', last_name: 'Wynn')

      item1 = @merch2.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item3 = @merch2.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)

      visit "/merchants/#{@merch2.id}"

      within "#invoice-item-#{invoice_item1.id}" do
        click_on("Invoice ##{invoice_item1.invoice.id}")
        expect(current_path).to eq("/merchants/#{@merch2.id}/invoices/#{invoice_item1.invoice.id}")
      end

      visit "/merchants/#{@merch2.id}"
      within "#invoice-item-#{invoice_item2.id}" do
        click_on("Invoice ##{invoice_item2.invoice.id}")
        expect(current_path).to eq("/merchants/#{@merch2.id}/invoices/#{invoice_item2.invoice.id}")
      end
    end
  end
end

