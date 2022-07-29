require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @walmart = Merchant.create!(name: "Wal-Mart")

    @target = Merchant.create!(name: "Target")

    @costco = Merchant.create!(name: "Costco")

    @pencil = Item.create!( name: "Pencil",
                            description: "Sharpen it and write with it.",
                            unit_price: 199,
                            merchant_id: @walmart.id)

    @marker = Item.create!( name: "Marker",
                            description: "Washable!",
                            unit_price: 159,
                            merchant_id: @walmart.id)

    @eraser = Item.create!( name: "Eraser",
                            description: "Use it to fix mistakes.",
                            unit_price: 205,
                            merchant_id: @walmart.id)

    @ruler = Item.create!( name: "Ruler",
                            description: "It measures things.",
                            unit_price: 105,
                            merchant_id: @walmart.id)

    @folder = Item.create!( name: "Folder",
                            description: "Store stuff in it.",
                            unit_price: 250,
                            merchant_id: @walmart.id)

    @raincoat = Item.create!( name: "Raincoat",
                            description: "Wear it so you don't get wet.",
                            unit_price: 5000,
                            merchant_id: @walmart.id)

    @highlighter = Item.create!( name: "Highlighter",
                            description: "Highlight things and make them yellow!",
                            unit_price: 305,
                            merchant_id: @target.id)
  end

  # User Story 6
  # Merchant Items Index Page

  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  it 'has a list of all of the items for a merchant' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@marker.name)
      expect(page).to have_content(@eraser.name)
      expect(page).to_not have_content(@highlighter.name)
    end
  end

  # User Story 7
  # Merchant Items Show Page

  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
  # And I see all of the item's attributes including:

  # Name
  # Description
  # Current Selling Price
  it 'has links to show pages of merchant items' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      expect(page).to_not have_content(@highlighter.name)

      within "#item-#{@pencil.id}" do
        expect(page).to have_link("#{@pencil.name}", href: "/merchants/#{@walmart.id}/items/#{@pencil.id}")
      end

      within "#item-#{@marker.id}" do
        expect(page).to have_link("#{@marker.name}", href: "/merchants/#{@walmart.id}/items/#{@marker.id}")
      end

      within "#item-#{@eraser.id}" do
        expect(page).to have_link("#{@eraser.name}", href: "/merchants/#{@walmart.id}/items/#{@eraser.id}")
      end
    end
  end

  it 'has links to take you to a merchant item show page' do
    visit "/merchants/#{@walmart.id}/items"

    click_link "#{@pencil.name}"

    expect(current_path).to eq("/merchants/#{@walmart.id}/items/#{@pencil.id}")
  end

  it 'has a button to enable/disable an item' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      within "#item-#{@pencil.id}" do
        expect(page).to have_button("Enable")
      end
    end
  end

  it 'can change the status to enabled' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      within "#item-#{@pencil.id}" do
        click_button 'Enable'
      end
    end

    expect(current_path).to eq("/merchants/#{@walmart.id}/items")

    within '#enabled-items-section' do
      within "#item-#{@pencil.id}" do
        expect(page).to have_content(@pencil.name)
        expect(page).to have_button("Disable")
      end
      expect(page).to_not have_content(@marker.name)
    end
  end

  it 'can change the status to disabled' do
    @pen = Item.create!(  name: "pen",
                          description: "Never needs to be sharpened.",
                          unit_price: 150,
                          merchant_id: @walmart.id,
                          status: 'enabled')
    visit "/merchants/#{@walmart.id}/items"
    within '#enabled-items-section' do
      within "#item-#{@pen.id}" do
        click_button 'Disable'
      end
    end

    expect(current_path).to eq("/merchants/#{@walmart.id}/items")

    within '#disabled-items-section' do
      within "#item-#{@pen.id}" do
        expect(page).to have_content(@pen.name)
        expect(page).to have_button("Enable")
      end
    end
  end

  it 'has a enabled section and a disabled section' do
    @pen = Item.create!(  name: "pen",
                          description: "Never needs to be sharpened.",
                          unit_price: 150,
                          merchant_id: @walmart.id,
                          status: 'enabled')
    visit "/merchants/#{@walmart.id}/items"

    within '#enabled-items-section' do
      within "#item-#{@pen.id}" do
        expect(page).to have_content(@pen.name)
        expect(page).to_not have_content(@marker.name)
      end
    end

    within '#disabled-items-section' do
      within "#item-#{@pencil.id}" do
        expect(page).to have_content(@pencil.name)
        expect(page).to_not have_content(@pen.name)
      end
    end
  end

  # User Story 12
  # Merchant Items Index: 5 most popular items
  # As a merchant
  # When I visit my items index page
  # Then I see the names of the top 5 most popular items ranked by total revenue generated
  # And I see that each item name links to my merchant item show page for that item
  # And I see the total revenue generated next to each item name

  # Notes on Revenue Calculation:

  # Only invoices with at least one successful transaction should count towards revenue
  # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
  it 'shows the names and total revenue generated of the top 5 most popular items ranked by total revenue generated, and has links to those items' do
    blake = Customer.create!( first_name: "Blake",
                                  last_name: "Saylor")

    invoice_1 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_2 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_3 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_4 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_5 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_6 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_item_1 = InvoiceItem.create!(quantity: 1,
                                          unit_price: 200,
                                          status: 'shipped',
                                          item_id: @pencil.id,
                                          invoice_id: invoice_1.id)

    invoice_item_2 = InvoiceItem.create!(quantity: 2,
                                          unit_price: 300,
                                          status: 'shipped',
                                          item_id: @marker.id,
                                          invoice_id: invoice_2.id)

    invoice_item_3 = InvoiceItem.create!(quantity: 3,
                                          unit_price: 400,
                                          status: 'shipped',
                                          item_id: @eraser.id,
                                          invoice_id: invoice_3.id)

    invoice_item_4 = InvoiceItem.create!(quantity: 4,
                                          unit_price: 500,
                                          status: 'shipped',
                                          item_id: @ruler.id,
                                          invoice_id: invoice_4.id)

    invoice_item_5 = InvoiceItem.create!(quantity: 5,
                                          unit_price: 600,
                                          status: 'shipped',
                                          item_id: @folder.id,
                                          invoice_id: invoice_5.id)

    invoice_item_6 = InvoiceItem.create!(quantity: 6,
                                          unit_price: 700,
                                          status: 'shipped',
                                          item_id: @raincoat.id,
                                          invoice_id: invoice_6.id)

    transaction_1 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_1.id)

    transaction_2 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_2.id)

    transaction_3 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_3.id)

    transaction_4 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_4.id)

    transaction_5 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_5.id)

    transaction_6 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_6.id)

    visit "/merchants/#{@walmart.id}/items"

    within '#top-5-revenue-generated' do
      expect(page).to_not have_content(@pencil)
      expect(@raincoat.name).to appear_before(@folder.name)
      expect(@folder.name).to appear_before(@ruler.name)
      expect(@ruler.name).to appear_before(@eraser.name)
      expect(@eraser.name).to appear_before(@marker.name)

      within '#number-1-revenue-earner' do
        expect(page).to have_content(@raincoat.name)
        expect(page).to have_link("#{@raincoat.name}", href: "/merchants/#{@walmart.id}/items/#{@raincoat.id}")
      end

      within '#number-2-revenue-earner' do
        expect(page).to have_content(@folder.name)
        expect(page).to have_link("#{@folder.name}", href: "/merchants/#{@walmart.id}/items/#{@folder.id}")
      end

      within '#number-3-revenue-earner' do
        expect(page).to have_content(@ruler.name)
        expect(page).to have_link("#{@ruler.name}", href: "/merchants/#{@walmart.id}/items/#{@ruler.id}")
      end

      within '#number-4-revenue-earner' do
        expect(page).to have_content(@eraser.name)
        expect(page).to have_link("#{@eraser.name}", href: "/merchants/#{@walmart.id}/items/#{@eraser.id}")
      end

      within '#number-5-revenue-earner' do
        expect(page).to have_content(@marker.name)
        expect(page).to have_link("#{@marker.name}", href: "/merchants/#{@walmart.id}/items/#{@marker.id}")
      end
    end
  end

  it 'next to each of the 5 most popular items I see the date with the most sales for each item' do
    blake = Customer.create!( first_name: "Blake",
                                  last_name: "Saylor")

    invoice_1 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_2 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_3 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_4 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_5 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_6 = Invoice.create!(status: 1,
                                customer_id: blake.id)

    invoice_item_1 = InvoiceItem.create!(quantity: 1,
                                          unit_price: 200,
                                          status: 'shipped',
                                          item_id: @pencil.id,
                                          invoice_id: invoice_1.id)

    invoice_item_2 = InvoiceItem.create!(quantity: 2,
                                          unit_price: 300,
                                          status: 'shipped',
                                          item_id: @marker.id,
                                          invoice_id: invoice_2.id)

    invoice_item_3 = InvoiceItem.create!(quantity: 3,
                                          unit_price: 400,
                                          status: 'shipped',
                                          item_id: @eraser.id,
                                          invoice_id: invoice_3.id)

    invoice_item_4 = InvoiceItem.create!(quantity: 4,
                                          unit_price: 500,
                                          status: 'shipped',
                                          item_id: @ruler.id,
                                          invoice_id: invoice_4.id)

    invoice_item_5 = InvoiceItem.create!(quantity: 5,
                                          unit_price: 600,
                                          status: 'shipped',
                                          item_id: @folder.id,
                                          invoice_id: invoice_5.id)

    invoice_item_6 = InvoiceItem.create!(quantity: 6,
                                          unit_price: 700,
                                          status: 'shipped',
                                          item_id: @raincoat.id,
                                          invoice_id: invoice_6.id)

    transaction_1 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_1.id)

    transaction_2 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_2.id)

    transaction_3 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_3.id)

    transaction_4 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_4.id)

    transaction_5 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_5.id)

    transaction_6 = Transaction.create!( credit_card_number: '1234',
                                          credit_card_expiration_date: 'never',
                                          result: 'success',
                                          invoice_id: invoice_6.id)

    visit "/merchants/#{@walmart.id}/items"

    within '#number-1-revenue-earner' do
      expect(page).to have_content(invoice_item_6.created_at.to_date.strftime("%m/%d/%Y"))
    end

    within '#number-2-revenue-earner' do
      expect(page).to have_content(invoice_item_5.created_at.to_date.strftime("%m/%d/%Y"))
    end

    within '#number-3-revenue-earner' do
      expect(page).to have_content(invoice_item_4.created_at.to_date.strftime("%m/%d/%Y"))
    end

    within '#number-4-revenue-earner' do
      expect(page).to have_content(invoice_item_3.created_at.to_date.strftime("%m/%d/%Y"))
    end

    within '#number-5-revenue-earner' do
      expect(page).to have_content(invoice_item_2.created_at.to_date.strftime("%m/%d/%Y"))
    end
  end
end
