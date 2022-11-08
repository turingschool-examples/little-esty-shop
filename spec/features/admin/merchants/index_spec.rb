require 'rails_helper'

RSpec.describe 'the admin merchants index page' do 
  before (:each) do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones", status: "Disabled")
    @whb = Merchant.create!(name: "WHB", status: "Enabled")
    @lisa_frank = Merchant.create!(name: 'Lisa Frank Knockoffs', status: 'Enabled')
    @burger = Merchant.create!(name: 'Burger King', status: 'Disabled')
    @dogs = Merchant.create!(name: 'Dogs')
    @whoopee_cushions = Merchant.create!(name: 'Whoopee Cushions')

    @customer1 = Customer.create!(first_name: 'Sean', last_name: 'Sux')

    @merch1item = @klein_rempel.items.create!(name: 'Item')
    @merch2item = @whb.items.create!(name: 'Item')
    @merch3item = @lisa_frank.items.create!(name: 'Item')
    @merch4item = @burger.items.create!(name: 'Item')
    @merch5item = @dogs.items.create!(name: 'Item')

    @inv1 = @customer1.invoices.create!(status: 2, created_at: Date.new(2022,11,07))
    @inv2 = @customer1.invoices.create!(status: 2)
    @inv3 = @customer1.invoices.create!(status: 2)
    @inv4 = @customer1.invoices.create!(status: 2)
    @inv5 = @customer1.invoices.create!(status: 2)

    InvoiceItem.create!(invoice: @inv1, item: @merch1item, quantity: 5, unit_price: 20000)
    InvoiceItem.create!(invoice: @inv2, item: @merch2item, quantity: 5, unit_price: 10000)
    InvoiceItem.create!(invoice: @inv3, item: @merch3item, quantity: 5, unit_price: 40000)
    InvoiceItem.create!(invoice: @inv4, item: @merch4item, quantity: 5, unit_price: 50000)
    InvoiceItem.create!(invoice: @inv5, item: @merch5item, quantity: 5, unit_price: 30000)

    @inv1.transactions.create!(result: 0)
    @inv2.transactions.create!(result: 0)
    @inv3.transactions.create!(result: 0)
    @inv4.transactions.create!(result: 0)
    @inv5.transactions.create!(result: 0)

    visit admin_merchants_path
  end

  describe 'merchants' do 
    it 'lists the name of all merchants in the system' do 
      expect(page).to have_content(@klein_rempel.name)
      expect(page).to have_content(@whb.name)
    end

    # link to Admin Merchant create
    it 'has a link to create a new merchant' do 
      click_button 'Create New Merchant'

      expect(current_path).to eq(new_admin_merchant_path)
    end
  end

  # Admin Merchant Enable/Disable
  describe 'enabling and disabling merchants' do 
    it 'has an enable and disable button next to each merchant name' do
      within "#merchant-#{@klein_rempel.id}" do 
        expect(page).to have_button("Enable")
      end
      within "#merchant-#{@whb.id}" do 
        expect(page).to have_button("Disable")
      end
    end

    it 'changes status of merchant when button is pressed' do 
      within "#merchant-#{@klein_rempel.id}" do 
        click_button 'Enable' 
        @klein_rempel = Merchant.find(@klein_rempel.id)

        expect(current_path).to eq(admin_merchants_path)
        expect(@klein_rempel.status).to eq("Enabled")
      end
      within "#merchant-#{@whb.id}" do 
        click_button 'Disable' 
        @whb = Merchant.find(@whb.id)

        expect(current_path).to eq(admin_merchants_path)
        expect(@whb.status).to eq("Disabled")
      end
    end

    it 'organizes merchants by enabled/disabled' do 
      within '#enabled' do 
        expect(page).to have_content(@whb.name)
        expect(page).to have_content(@lisa_frank.name)
      end
      within '#disabled' do 
        expect(page).to have_content(@klein_rempel.name)
        expect(page).to have_content(@burger.name)
      end
    end
  end

  # Top 5 Merchants
  describe 'top 5 merchants by revenue' do 
    it 'it shows the top 5 merchants by revenue' do 
      within '#top_merchants' do 
        expect(@burger.name).to appear_before(@lisa_frank.name)
        expect(@lisa_frank.name).to appear_before(@dogs.name)
        expect(@dogs.name).to appear_before(@klein_rempel.name)
        expect(@klein_rempel.name).to appear_before(@whb.name)
      end
    end

    it 'each merchant name links to the admin merchant show page' do 
      within '#top_merchants' do 
        click_link @lisa_frank.name

        expect(current_path).to eq(admin_merchant_path(@lisa_frank))
      end
    end

    it 'shows total revenue generated next to each merchant' do 
      within '#top_merchants' do 
        expect(page).to have_content("#{@lisa_frank.name} - Total Revenue: $2000")
      end
    end
  end

  # Top Merchant's Best Day
  describe 'top merchants best day' do 

    it 'next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant. I see a label (Top selling date for was)' do 
      within '#top_merchants' do
        expect(page).to have_content("Highest Sales Date: 2022-11-07")
      end 
    end
  end
end