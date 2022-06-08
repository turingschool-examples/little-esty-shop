require 'rails_helper'

RSpec.describe 'merchants dashboard' do
  before :each do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')
    @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
    @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
    @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 2)
    @invoice3 = @customer1.invoices.create!(status: 2)
    @invoice4 = @customer1.invoices.create!(status: 1)
    InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 0,
                        created_at: '2022-06-02 21:08:18 UTC')
    InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 1,
                        created_at: '2022-06-01 21:08:15 UTC')
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 5, unit_price: 1000, status: 1,
                        created_at: '2022-06-03 21:08:15 UTC')
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 1000, status: 2,
                        created_at: '2022-06-03 21:08:15 UTC')
  end
  it 'shows the name of the merchant', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"

    expect(page).to have_content(@merch1.name)
  end

  it 'shows links to the merchants items index and invoices index', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"

    expect(page).to have_link('Items Index')

    expect(page).to have_link('Invoices Index')
  end

  it 'has a section for items ready to ship', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"
    within '#ready-items' do
      expect(page).to have_content('Items Ready to Ship')
      expect(page).to have_content('Floopy Updated')
      expect(page).to have_content(@invoice2.id.to_s)
      expect(page).to have_content('Floopy Retro')
      expect(page).to have_content(@invoice3.id.to_s)
      expect(page).to_not have_content('Floopy Original')
      expect(page).to_not have_content('Floopy Geo')
    end
  end

  it 'has link from items ready to ship that leads to merchant invoice show page', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"
    within '#ready-items' do
      expect(page).to have_content(@invoice2.id.to_s)
      click_link @invoice2.id.to_s
    end
    expect(current_path).to eq("/merchants/#{@merch1.id}/invoices/#{@invoice2.id}")
  end

  it 'shows invoice dates and lists them oldest to newest', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"
    within '#ready-items' do
      expect(@invoice2.get_invoice_item(@item2.id).created_at.strftime('%A %B %e %Y')).to appear_before(@invoice3.get_invoice_item(@item3.id).created_at.strftime('%A %B %e %Y'))
    end
  end

  it 'shows the top customers of my merchant', :vcr do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')
    @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    @item2 = @merch1.items.create!(name: 'A-Team Original', description: 'the better', unit_price: 950)

    @cust1 = Customer.create!(first_name: 'Mark', last_name: 'Ruffalo')
    @cust2 = Customer.create!(first_name: 'Jim', last_name: 'Raddle')
    @cust3 = Customer.create!(first_name: 'Bryan', last_name: 'Cranston')
    @cust4 = Customer.create!(first_name: 'Walter', last_name: 'White')
    @cust5 = Customer.create!(first_name: 'Hank', last_name: 'Williams')
    @cust6 = Customer.create!(first_name: 'Sammy', last_name: 'Sosa')
    @cust7 = Customer.create!(first_name: 'Barry', last_name: 'Bonds')

    @inv1 = @cust1.invoices.create!(status: 'in progress')
    @inv2 = @cust2.invoices.create!(status: 'completed')
    @inv3 = @cust3.invoices.create!(status: 'completed')
    @inv4 = @cust4.invoices.create!(status: 'completed')
    @inv5 = @cust5.invoices.create!(status: 'completed')
    @inv6 = @cust6.invoices.create!(status: 'completed')
    @inv7 = @cust7.invoices.create!(status: 'completed')

    InvoiceItem.create!(item_id: @item1.id.to_s, invoice_id: @inv1.id.to_s, quantity: 100, unit_price: 1000,
                        status: 1)
    InvoiceItem.create!(item_id: @item2.id.to_s, invoice_id: @inv2.id.to_s, quantity: 200, unit_price: 2000,
                        status: 1)
    InvoiceItem.create!(item_id: @item1.id.to_s, invoice_id: @inv3.id.to_s, quantity: 200, unit_price: 2000,
                        status: 1)
    InvoiceItem.create!(item_id: @item2.id.to_s, invoice_id: @inv4.id.to_s, quantity: 200, unit_price: 2000,
                        status: 1)
    InvoiceItem.create!(item_id: @item1.id.to_s, invoice_id: @inv5.id.to_s, quantity: 200, unit_price: 2000,
                        status: 1)
    InvoiceItem.create!(item_id: @item2.id.to_s, invoice_id: @inv6.id.to_s, quantity: 200, unit_price: 2000,
                        status: 1)
    InvoiceItem.create!(item_id: @item1.id.to_s, invoice_id: @inv7.id.to_s, quantity: 200, unit_price: 2000,
                        status: 1)

    @inv1.transactions.create!(result: 0)
    @inv1.transactions.create!(result: 0)
    @inv1.transactions.create!(result: 0)

    @inv2.transactions.create!(result: 0)
    @inv2.transactions.create!(result: 0)
    @inv2.transactions.create!(result: 0)

    @inv3.transactions.create!(result: 0)
    @inv3.transactions.create!(result: 0)
    @inv3.transactions.create!(result: 0)
    @inv3.transactions.create!(result: 0)

    @inv4.transactions.create!(result: 0)
    @inv4.transactions.create!(result: 0)
    @inv4.transactions.create!(result: 0)
    @inv4.transactions.create!(result: 1)
    @inv4.transactions.create!(result: 1)
    @inv4.transactions.create!(result: 1)
    @inv4.transactions.create!(result: 1)

    @inv5.transactions.create!(result: 0)
    @inv5.transactions.create!(result: 0)
    @inv5.transactions.create!(result: 0)
    @inv5.transactions.create!(result: 0)
    @inv5.transactions.create!(result: 0)

    @inv6.transactions.create!(result: 1)
    @inv6.transactions.create!(result: 1)
    @inv6.transactions.create!(result: 1)
    @inv6.transactions.create!(result: 1)

    @inv7.transactions.create!(result: 0)

    # top 5 should be Hank Williams, then Bryan, Jim, Mark and Walter.  Sammy and Barry should not appear on this page

    visit "/merchants/#{@merch1.id}/dashboard"

    within "#customer-#{@cust5.id}" do
      expect(page).to have_content("#{@cust5.first_name} #{@cust5.last_name}")
      expect(page).to have_content('5 successful transactions')
    end

    within "#customer-#{@cust1.id}" do
      expect(page).to have_content("#{@cust1.first_name} #{@cust1.last_name}")
      expect(page).to have_content('3 successful transactions')
    end

    within "#customer-#{@cust2.id}" do
      expect(page).to have_content("#{@cust2.first_name} #{@cust2.last_name}")
      expect(page).to have_content('3 successful transactions')
    end

    within "#customer-#{@cust3.id}" do
      expect(page).to have_content("#{@cust3.first_name} #{@cust3.last_name}")
      expect(page).to have_content('4 successful transactions')
    end

    within "#customer-#{@cust4.id}" do
      expect(page).to have_content("#{@cust4.first_name} #{@cust4.last_name}")
      expect(page).to have_content('3 successful transactions')
    end

    expect(page).to_not have_content("#{@cust6.first_name} #{@cust6.last_name}")
    expect(page).to_not have_content("#{@cust7.first_name} #{@cust7.last_name}")
  end

  it 'displays repo name', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"
    expect(page).to have_content('little-esty-shop')
  end

  it 'displays repo logins', :vcr do
    visit "/merchants/#{@merch1.id}/dashboard"

    expect(page).to have_content('z-prince')

    expect(page).to have_content('jimriddle1')

    expect(page).to have_content('amsalmeron')

    expect(page).to have_content('Deming-Matt')
  end
end
