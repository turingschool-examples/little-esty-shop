require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant, is_enabled: true) #enabled to start
    @merchant_2 = create(:merchant, is_enabled: true) #enabled to start
    @merchant_3 = create(:merchant, is_enabled: true)
    @merchant_4 = create(:merchant, is_enabled: true)
    @merchant_5 = create(:merchant, is_enabled: true)
    @merchant_6 = create(:merchant, is_enabled: true)
    @merchant_7 = create(:merchant, is_enabled: false) #disabled to start (is_enabled: false by default)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, status: 'In Progress', created_at: '2023-01-01 20:54:10 UTC')
    @invoice_2 = create(:invoice, customer_id: @customer_2.id, status: 'In Progress', created_at: '2023-01-02 20:54:10 UTC')
    @invoice_3 = create(:invoice, customer_id: @customer_3.id, status: 'In Progress', created_at: '2023-01-03 20:54:10 UTC')
    @invoice_4 = create(:invoice, customer_id: @customer_1.id, status: 'In Progress', created_at: '2023-01-04 20:54:10 UTC')
    @invoice_5 = create(:invoice, customer_id: @customer_2.id, status: 'In Progress', created_at: '2023-01-05 20:54:10 UTC')
    @invoice_6 = create(:invoice, customer_id: @customer_3.id, status: 'In Progress', created_at: '2023-01-06 20:54:10 UTC')

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_2.id)
    @item_3 = create(:item, merchant_id: @merchant_3.id)
    @item_4 = create(:item, merchant_id: @merchant_4.id)
    @item_5 = create(:item, merchant_id: @merchant_5.id)
    @item_6 = create(:item, merchant_id: @merchant_6.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1000, unit_price: 6)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 1000, unit_price: 5)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 1000, unit_price: 4)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1000, unit_price: 3)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 1000, unit_price: 2)
    @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_6.id, quantity: 1000, unit_price: 1)

    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")
    @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "success")
    @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: "success")
    @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: "success")
  end

  describe "Admin Merchant Index Page (User Story 24)" do
    it "displays each merchant in system" do
      visit admin_merchants_path
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end
  end

  describe "Admin Merchant Show (User Story 25)" do
    it "Each merchant name is a link that takes you to their admin show page and it shows their name" do
      visit admin_merchants_path
      within ("#enabled-merchants") do
        click_link(@merchant_1.name)
      end
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
        expect(page).to have_content(@merchant_1.name)

        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_3.name)


      visit admin_merchants_path
      within ("#enabled-merchants") do
        click_link(@merchant_2.name)
      end
      expect(current_path).to eq(admin_merchant_path(@merchant_2))
      expect(page).to have_content(@merchant_2.name)

      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_3.name)

      visit admin_merchants_path
      within ("#enabled-merchants") do
        click_link(@merchant_3.name)
      end
      expect(page).to have_current_path(admin_merchant_path(@merchant_3))
      expect(page).to have_content(@merchant_3.name)

      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end


  describe "Admin Merchant Create (User Story 29)" do
    it "displays link, create new merchant, and clicking redirects to new merchant form" do
      visit admin_merchants_path
      expect(page).to_not have_content("Test Merchant 1")

      expect(page).to have_link("Create New Merchant")
      click_link("Create New Merchant")
      expect(page).to have_current_path(new_merchant_path)
      expect(page).to have_field('merchant_name')
      expect(page).to have_button('Submit')

    end

    it "filling information and submitting redirects to admin merchant index page" do
      visit new_merchant_path
      fill_in 'merchant_name', with: 'Test Merchant 1'
      click_button('Submit')
      expect(page).to have_current_path(admin_merchants_path)
      expect(page).to have_content("New merchant has been successfully created")
    end

    it "failing to fill the form displays error message" do
      visit new_merchant_path
      fill_in 'merchant_name', with: ''
      click_button('Submit')
      expect(page).to have_current_path(new_merchant_path)
      expect(page).to have_content("Error: Name can't be blank")
    end

    it "new merchant is displayed with a status of disabled" do
      test_merchant = create(:merchant, name: "Test Merchant 1")
      visit new_merchant_path
      fill_in 'merchant_name', with: test_merchant.name
      click_button('Submit')
      within("#merchant-#{test_merchant.id}") do
        expect(page).to have_content('Status: Disabled')
      end
    end
  end

  describe "Admin Merchant Enable / Disable (User Story 27)" do
    it 'shows a button to either enable or disable a merchant, based on their current activity status' do
      visit admin_merchants_path

      within ("#merchant-#{@merchant_1.id}") do
        expect(page).to have_button("Disable")
      end

      within ("#merchant-#{@merchant_2.id}") do
        expect(page).to have_button("Disable")
      end

      within ("#merchant-#{@merchant_7.id}") do
        expect(page).to have_button("Enable")
      end
    end

    it 'updates the activity status of the given merchant when clicked, and returns admin merchant index' do
      visit admin_merchants_path

      expect(@merchant_1.is_enabled).to be(true)
      expect(@merchant_2.is_enabled).to be(true)
      expect(@merchant_7.is_enabled).to be(false)

      within ("#merchant-#{@merchant_1.id}") do
        click_button("Disable")
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Enable")
      end

      within ("#merchant-#{@merchant_2.id}") do
        click_button("Disable")
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Enable")
      end

      within ("#merchant-#{@merchant_7.id}") do
        click_button("Enable")
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Disable")
      end

      expect(@merchant_1.reload.is_enabled).to be(false)
      expect(@merchant_2.reload.is_enabled).to be(false)
      expect(@merchant_3.reload.is_enabled).to be(true)
    end
  end

  describe 'Admin Merchants Grouped by Status (User Story 28)' do
    it 'displays two sections on the page that group Merchants by Enabled or Disabled' do
      visit admin_merchants_path

      within ("#enabled-merchants") do
        expect(page).to have_content("Enabled Merchants")

        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_7.name)

        expect(page).to have_content("Status: Enabled")
        expect(page).to_not have_content("Status: Disabled")

        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end

      within ("#disabled-merchants") do
        expect(page).to have_content("Disabled Merchants")

        expect(page).to have_content(@merchant_7.name)
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)

        expect(page).to have_content("Status: Disabled")
        expect(page).to_not have_content("Status: Enabled")

        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
      end
    end
  end

  describe "Admin Merchants: Top 5 Merchants by Revenue (User Story 30)" do
    it "displays the names of the top 5 merchants by revenue" do
      visit admin_merchants_path

      within("#top_5") do
        expect(page).to have_content("Top Merchants")
        expect(page).to have_content("Name: #{@merchant_5.name}")
        expect(page).to have_content("Name: #{@merchant_4.name}")
        expect(page).to have_content("Name: #{@merchant_3.name}")
        expect(page).to have_content("Name: #{@merchant_2.name}")
        expect(page).to have_content("Name: #{@merchant_1.name}")

        expect(page).to_not have_content("Name: #{@merchant_6.name}")
        expect(page).to_not have_content("Name: #{@merchant_7.name}")
      end
    end

    it "each merchant name links to the admin merchant show page for that merchant" do
      visit admin_merchants_path

      within("#top_5") do
        expect(page).to have_link("#{@merchant_5.name}")
        expect(page).to have_link("#{@merchant_4.name}")
        expect(page).to have_link("#{@merchant_3.name}")
        expect(page).to have_link("#{@merchant_2.name}")
        expect(page).to have_link("#{@merchant_1.name}")

        expect(page).to_not have_link("#{@merchant_6.name}")
        expect(page).to_not have_link("#{@merchant_7.name}")
      end

      within("#top_5") do
        click_link("#{@merchant_5.name}")
        expect(current_path).to eq(admin_merchant_path(@merchant_5))
      end
    end

    it "displays the total revenue generated next to each merchant name" do
      visit admin_merchants_path

      within("#top_5") do
        expect(page).to have_content("Total Revenue: $60")
        expect(page).to have_content("Total Revenue: $50")
        expect(page).to have_content("Total Revenue: $40")
        expect(page).to have_content("Total Revenue: $30")
        expect(page).to have_content("Total Revenue: $20")
      end
    end
  end

  describe "Admin Merchants: Top Merchant's Best Day (User Story 31)" do
    it 'displays a formatted date with the most revenue and label for each merchant in the top 5' do
      visit admin_merchants_path

      within("#top_5") do
        expect(page).to have_content("Top selling date for #{@merchant_1.name} was #{format_date(Time.new(2023, 1, 1))}")
        expect(page).to have_content("Top selling date for #{@merchant_2.name} was #{format_date(Time.new(2023, 1, 2))}")
        expect(page).to have_content("Top selling date for #{@merchant_3.name} was #{format_date(Time.new(2023, 1, 3))}")
        expect(page).to have_content("Top selling date for #{@merchant_4.name} was #{format_date(Time.new(2023, 1, 4))}")
        expect(page).to have_content("Top selling date for #{@merchant_5.name} was #{format_date(Time.new(2023, 1, 5))}")
        expect(page).to_not have_content(format_date(Time.new(2023, 1, 6)))
      end
    end
  end
end
