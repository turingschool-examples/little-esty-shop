require 'rails_helper'

RSpec.describe "admin/merchants index", type: :feature do
  before (:each) do
    stub_request(:get, "https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
      .to_return(status: 200, body: File.read('./spec/fixtures/merchant.json'))
    stub_request(:get, "https://api.unsplash.com/photos/5Fxuo7x-eyg?client_id=aOXB56mTdUD88zHCvISJODxwbTPyRRsOk0rA8Ha-cbc")
      .to_return(status: 200, body: File.read('./spec/fixtures/app_logo.json'))
  end
  describe "display" do
    before do
      test_data
    end
    
    it "displays all merchants" do
      visit admin_merchants_path
      
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_5.name)
      expect(page).to have_content(@merchant_6.name)
    end

    it "has links to merchant show pages" do
      visit admin_merchants_path
      
      expect(page).to have_link(@merchant_1.name, href: admin_merchant_path(@merchant_1))
      expect(page).to have_link(@merchant_2.name, href: admin_merchant_path(@merchant_2))
      expect(page).to have_link(@merchant_3.name, href: admin_merchant_path(@merchant_3))
      expect(page).to have_link(@merchant_4.name, href: admin_merchant_path(@merchant_4))
      expect(page).to have_link(@merchant_5.name, href: admin_merchant_path(@merchant_5))
      expect(page).to have_link(@merchant_6.name, href: admin_merchant_path(@merchant_6))
    end
  end

  describe "functionality" do 
    before do
      test_data
    end

    it "links to show pages are functional" do
      visit admin_merchants_path
      within "#disabled_merchants" do

        click_link(@merchant_1.name)
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
      end

      visit admin_merchants_path
      within "#disabled_merchants" do

        click_link(@merchant_2.name)
        expect(current_path).to eq(admin_merchant_path(@merchant_2))
      end
    end

    it "has buttons to enable/disable merchants" do
      visit admin_merchants_path 

      expect(page.all(:button, "Enable").count).to eq(6)
    end

    it "enable/disable buttons are functional" do
      visit admin_merchants_path

      expect(@merchant_1.status).to eq("disabled")

      click_button("enable_#{@merchant_1.id}")
      expect(current_path).to eq(admin_merchants_path)
      expect(@merchant_1.status).to eq("disabled")

      @merchant_1.reload
      visit admin_merchants_path

      expect(page.all(:button, "Enable").count).to eq(5)
      expect(page.all(:button, "Disable").count).to eq(1)
    end
  end

  describe 'User Story 28' do
    before(:each) do
      test_data
    end

    it 'shows a list of enabled merchants' do
      @merchant_1.update(status: "enabled")
      @merchant_2.update(status: "enabled")
      visit admin_merchants_path
      within "#enabled_merchants" do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_3.name)
        expect(page).to_not have_content(@merchant_4.name)
      end
    end

    it 'shows a list of disabled merchants' do
      @merchant_1.update(status: "enabled")
      @merchant_2.update(status: "enabled")
      visit admin_merchants_path
      within "#disabled_merchants" do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_4.name)
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
      end
    end
  end

  describe "user story 29" do
    before do
      test_data
    end

    it "has a link to create new merchants" do
      visit admin_merchants_path

      expect(page).to have_link("Add New Merchant", href: new_admin_merchant_path)
      click_link("Add New Merchant")
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end
  describe 'User Story 30' do 
    before (:each) do
      test_data
      @transaction_21 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_22 = @invoice_2.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_23 = @invoice_3.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_24 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_25 = @invoice_5.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_26 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_27 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_28 = @invoice_8.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_29 = @invoice_9.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_30 = @invoice_10.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_31 = @invoice_11.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_32 = @invoice_12.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_33 = @invoice_13.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_34 = @invoice_14.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_35 = @invoice_15.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_36 = @invoice_16.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_37 = @invoice_17.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_38 = @invoice_18.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_39 = @invoice_19.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_40 = @invoice_20.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @invoice_item_53 = @invoice_13.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_54 = @invoice_14.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_55 = @invoice_15.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_56 = @invoice_16.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_57 = @invoice_17.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_58 = @invoice_18.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_59 = @invoice_19.invoice_items.create!(item: @item_35, quantity: 1, unit_price: 2400, status: 1)
      @invoice_item_60 = @invoice_20.invoice_items.create!(item: @item_35, quantity: 1, unit_price: 2400, status: 1)
    end

    it 'I see the names of the top 5 merchants by total revenue generated' do
      visit admin_merchants_path

      within("#top_five_merchants") do
        expect("#{@merchant_3.name}").to appear_before("#{@merchant_1.name}")
        expect("#{@merchant_1.name}").to appear_before("#{@merchant_5.name}")
        expect("#{@merchant_5.name}").to appear_before("#{@merchant_2.name}")
        expect("#{@merchant_2.name}").to appear_before("#{@merchant_4.name}")
        expect(page).to_not have_content(@merchant_6.name)
      end
    end

    it 'I see the total revenue generated next to each merchant name' do
      visit admin_merchants_path
      
      within("#top_five_merchants") do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content("$2,268.00")
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content("$1,512.00")
        expect("$2,268.00").to appear_before("$1,512.00")
      end
    end
    
    it "shows the top merchants best day" do
      @invoice_item_61 = @invoice_4.invoice_items.create!(item: @item_35, quantity: 1000, unit_price: 2400, status: 1)
      @invoice_1.update(created_at: "06/04/2023")
      @invoice_item_1.update(quantity: 1000)
      @invoice_8.update(created_at: "16/04/2023")
      @invoice_item_28.update(quantity: 1000)
      @invoice_12.update(created_at: "09/04/2023")
      @invoice_item_32.update(quantity: 1000)
      @invoice_13.update(created_at: "31/03/2023")
      @invoice_item_53.update(quantity: 10000)
      @invoice_4.update(created_at: "27/03/2023")

      visit admin_merchants_path
      within "#top_five_merchants" do

        expect(page).to have_content("Top day for #{@merchant_3.name} was 04/09/2023")
        expect(page).to have_content("Top day for #{@merchant_1.name} was 04/06/2023")
        expect(page).to have_content("Top day for #{@merchant_5.name} was 03/27/2023")
        expect(page).to have_content("Top day for #{@merchant_2.name} was 04/16/2023")
        expect(page).to have_content("Top day for #{@merchant_4.name} was 03/31/2023")
      end
    end
  end
end