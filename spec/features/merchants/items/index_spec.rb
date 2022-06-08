require 'rails_helper'

RSpec.describe 'merchants items index' do
  before :each do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')
    @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
    @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
    @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
    @item5 = @merch1.items.create!(name: 'Floopy Green', description: 'the best', unit_price: 450)
    @item6 = @merch1.items.create!(name: 'Floopy Blue', description: 'the better', unit_price: 950)
    @item7 = @merch1.items.create!(name: 'Floopy Red', description: 'the OG', unit_price: 550)
    @item8 = @merch1.items.create!(name: 'Floopy Black', description: 'the OG', unit_price: 550)
    @invoice1 = @customer1.invoices.create!(status: 2, updated_at: Time.parse('2012-03-30 14:54:09 UTC'))
    @invoice1.transactions.create!(result: 0)
    @invoice2 = @customer1.invoices.create!(status: 2)
    @invoice2.transactions.create!(result: 0)
    InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10_000, status: 0)
    InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 10_000, status: 1)
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 10_000, status: 1)
    InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 10_000, status: 2)
    InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 10_000, status: 0)
    InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 6, unit_price: 10_000, status: 2)
    InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 500, status: 2)
    InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 10_000, status: 2)
  end

  it 'shows the name of the items belonging to a merchant', :vcr do
    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    item3 = merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

    merch2 = Merchant.create!(name: 'Goopy Gopperations')
    item4 = merch2.items.create!(name: 'Goopy Original', description: 'the bester', unit_price: 1450)
    item5 = merch2.items.create!(name: 'Goopy Updated', description: 'the even better', unit_price: 1950)

    visit "/merchants/#{merch1.id}/items"

    expect(page).to have_content(merch1.name)
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
    expect(page).to_not have_content(item4.name)
    expect(page).to_not have_content(item5.name)
  end

  it 'allows me to enable / disable items belonging to a merchant', :vcr do
    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450, status: 0)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950, status: 1)

    visit "/merchants/#{merch1.id}/items"

    within "#item-#{item1.id}" do
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.status)
      expect(page).to have_button("Enable #{item1.name}")

      expect(page).to_not have_content(item2.name)
      expect(page).to_not have_content(item2.status)
      expect(page).to_not have_button("Disable #{item2.name}")
      expect(page).to_not have_button("Enable #{item2.name}")

      expect(page).to have_content('Current Status: disabled')
    end

    within "#item-#{item2.id}" do
      expect(page).to_not have_content(item1.name)
      expect(page).to_not have_content(item1.status)
      expect(page).to_not have_button("Disable #{item1.name}")
      expect(page).to_not have_button("Enable #{item1.name}")

      expect(page).to have_content(item2.name)
      expect(page).to have_content(item2.status)
      expect(page).to have_button("Disable #{item2.name}")
      expect(page).to have_content('Current Status: enabled')
    end

    click_button "Enable #{item1.name}"
    expect(current_path).to eq("/merchants/#{merch1.id}/items/")
    within "#item-#{item1.id}" do
      expect(page).to have_content('Current Status: enabled')
    end

    click_button "Disable #{item2.name}"
    expect(current_path).to eq("/merchants/#{merch1.id}/items/")
    within "#item-#{item2.id}" do
      expect(page).to have_content('Current Status: disabled')
    end
  end

  it 'groups the items by enabled or disabled status', :vcr do
    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450, status: 0)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950, status: 1)
    item3 = merch1.items.create!(name: 'Floopy Remix', description: 'the even better', unit_price: 1950, status: 0)
    item4 = merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 2950, status: 1)

    visit "/merchants/#{merch1.id}/items"

    expect(page).to have_content('Enabled Items')
    expect(page).to have_content('Disabled Items')

    within '#enabled-items' do
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item4.name)
    end

    within '#disabled-items' do
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item3.name)
    end
  end

  it 'can add an create a merchant item and have the default value be disabled', :vcr do
    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450, status: 0)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950, status: 1)
    item3 = merch1.items.create!(name: 'Floopy Remix', description: 'the even better', unit_price: 1950, status: 0)

    visit "/merchants/#{merch1.id}/items"

    click_link 'Create a new Item'
    expect(current_path).to eq("/merchants/#{merch1.id}/items/new")

    fill_in 'Name', with: 'Floopy Retro'
    fill_in 'Description', with: 'the OG'
    fill_in 'unit_price', with: 1950

    click_button 'Submit'
    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    within '#disabled-items' do
      expect(page).to have_content('Floopy Retro')
    end

    within '#enabled-items' do
      expect(page).to_not have_content('Floopy Retro')
    end
  end

  it 'has a sections for the top 5 most popular items', :vcr do
    visit "/merchants/#{@merch1.id}/items"
    within '#top-items' do
      expect(page).to have_content('Floopy Black')
      expect(page).to have_content('Total Revenue: 1000.00')
      expect(page).to have_content('Floopy Blue')
      expect(page).to have_content('Total Revenue: 600.00')
      expect(page).to have_content('Floopy Green')
      expect(page).to have_content('Total Revenue: 500.00')
      expect(page).to have_content('Floopy Geo')
      expect(page).to have_content('Total Revenue: 400.00')
      expect(page).to have_content('Floopy Retro')
      expect(page).to have_content('Total Revenue: 300.00')
      click_link @item8.name.to_s
      expect(current_path).to eq("/merchants/#{@merch1.id}/items/#{@item8.id}")
    end
  end

  it 'displays items best day', :vcr do
    visit "/merchants/#{@merch1.id}/items"
    # save_and_open_page
    within '#top-items' do
      expect(page).to have_content(@invoice1.updated_at)
      expect(page).to have_content(@merch1.top_five_items_by_revenue.first.item_best_day)
    end
  end
end
