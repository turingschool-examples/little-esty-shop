require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")
    @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
    @merchant_3 = Merchant.create!(name: "Sheena Yeaston")
    @merchant_4 = Merchant.create!(name: "Taylor Sift")
    @merchant_5 = Merchant.create!(name: "Rye-n Rye-nolds")
    @merchant_6 = Merchant.create!(name: "Bread Paisley")
  end

  describe 'US6' do
    it 'shows the name of all the merchants in the system' do
      visit "/admin/merchants"

      expect(page).to have_content("Bread Pitt")
      expect(page).to have_content("Carrie Breadshaw")
      expect(page).to have_content("Sheena Yeaston")
      expect(page).to have_content("Taylor Sift")
      expect(page).to_not have_content("Meat Loaf") #customer name
    end
  end

  describe 'US7' do
    it 'has a link on each merchants name taking you to their individual show page with their name' do
      visit "/admin/merchants"
      click_link "#{@merchant_1.name}"

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
      expect(page).to have_content("Bread Pitt")
      expect(page).to_not have_content("Carrie Breadshaw")
    end
  end

  describe 'US9' do
    it 'can disable merchants' do
      yeasty = Merchant.create!(name: "The Yeasty Boys", status: :Enabled)
       # As an admin,
      # When I visit the admin merchants index
      visit "/admin/merchants"
      # Then next to each merchant name I see a button to disable or enable that merchant.
      within("#enabled_merchant-#{yeasty.id}") do

        expect(page).to have_button("Disable")

        click_button("Disable")
        # Then I am redirected back to the admin merchants index
        expect(current_path).to eq("/admin/merchants")
      end

      within("#disabled_merchant-#{yeasty.id}") do
        # And I see that the merchant's status has changed
        expect(page).to have_button("Enable")
      end
    end

    it 'can enable merchants' do
      yeasty = Merchant.create!(name: "The Yeasty Boys", status: :Disabled)

      visit "/admin/merchants"

      within("#disabled_merchant-#{yeasty.id}") do
        expect(page).to have_button("Enable")
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants")
      end

      within("#enabled_merchant-#{yeasty.id}") do
        expect(page).to have_button("Disable")
      end
   end

  end

  describe 'US10' do
    it 'can sort between currently enabled and disabled merchants' do
      Merchant.create!(name: "The Yeasty Boys", status: :Disabled)
      Merchant.create!(name: "Cake Me Home Tonight", status: :Disabled)
      Merchant.create!(name: "Bake That", status: :Enabled)
      Merchant.create!(name: "Nutty Baker", status: :Enabled)
      # As an admin,
      visit "/admin/merchants"
      # When I visit the admin merchants index
      # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")
      # And I see that each Merchant is listed in the appropriate section
      within '.enabled' do
        expect(page).to have_content("Bake That")
        expect(page).to have_content("Nutty Baker")
        expect(page).to_not have_content("The Yeasty Boys")
      end

      within '.disabled' do
        expect(page).to have_content("The Yeasty Boys")
        expect(page).to have_content("Cake Me Home Tonight")
        expect(page).to_not have_content("Bake That")
      end
    end
  end

  describe 'US11' do
    it 'admin merchant create' do
      # As an admin,
      # When I visit the admin merchants index
      visit "/admin/merchants"
      # I see a link to create a new merchant.
      click_link("New Merchant")
      # When I click on the link,
      # I am taken to a form that allows me to add merchant information.
      expect(current_path).to eq("/admin/merchants/new")
    end
  end

  describe 'US12' do
    before :each do
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_2.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_3.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_4.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_5.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_6.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_2.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_3.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_4.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_5.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_2.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_3.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_4.id)
      @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_1.id)
      @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_2.id)
      @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_3.id)
      @item_5 = Item.create!(name: "Rye Bread", description: "Too many jokes to be had", unit_price: 500, merchant_id: @merchant_1.id)

      @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
      @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
      @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")
      @customer_4 = Customer.create!(first_name: "Walter", last_name: "Wheat")
      @customer_5 = Customer.create!(first_name: "David", last_name: "Dowie")
      @customer_6 = Customer.create!(first_name: "Clint", last_name: "Yeastwood")

      @invoice_1 = Invoice.create!(status: :completed, customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: :completed, customer_id: @customer_2.id)
      @invoice_3 = Invoice.create!(status: :completed, customer_id: @customer_3.id)
      @invoice_4 = Invoice.create!(status: :completed, customer_id: @customer_4.id)
      @invoice_5 = Invoice.create!(status: :completed, customer_id: @customer_5.id)
      @invoice_6 = Invoice.create!(status: :completed, customer_id: @customer_6.id)

      @transaction_1 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_2 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_3 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_4 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_5 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_6 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")

      @transaction_7 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_8 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_9 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_10 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_11 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")

      @transaction_12 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
      @transaction_13 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
      @transaction_14 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
      @transaction_15 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")

      @transaction_16 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")
      @transaction_17 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")
      @transaction_18 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")

      @transaction_19 = Transaction.create!(result: :success, invoice_id: @invoice_5.id, credit_card_number: "987654321")
      @transaction_20 = Transaction.create!(result: :success, invoice_id: @invoice_5.id, credit_card_number: "987654321")

      @transaction_21 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")
      @transaction_22 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")

      @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 2, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
      @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_3.id)
      @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1200, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
      @invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 500, status: 2, item_id: @item_5.id, invoice_id: @invoice_5.id)
      @invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 2, item_id: @item_5.id, invoice_id: @invoice_6.id)
    end

    it 'will show the top 5 merchants by revenue' do
      visit "/admin/merchants"
      # When I visit the admin merchants index
      expect(page).to have_content("Top Merchants")
      # Then I see the names of the top 5 merchants by total revenue generated
      within '.top_merchants' do
        expect("Bread Paisley").to appear_before("Rye-n Rye-nolds")
        expect("Rye-n Rye-nolds").to appear_before("Taylor Sift")
        expect("Taylor Sift").to appear_before("Sheena Yeaston")
        expect("Sheena Yeaston").to appear_before("Bread Pitt")
        expect(page).to_not have_content("Carrie Breadshaw")
        # And I see that each merchant name links to the admin merchant show page for that merchant
        click_on("Rye-n Rye-nolds")
        expect(current_path).to eq("/admin/merchants/#{@merchant_5.id}")
      end
    end

    it 'will show the revenue generated next to each merchant' do
      visit "/admin/merchants"

      within("#top_merchant-#{@merchant_5.id}") do
        expect(page).to have_content("$13,000.00")
        expect(page).to_not have_content("$7,200.00")#Sheena Yeaston revenue
        # And I see the total revenue generated next to each merchant name
      end
    end
  end

  describe 'US13' do
    before :each do
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_2.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_3.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_4.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_5.id)
      @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_6.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_2.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_3.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_4.id)
      @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_5.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_2.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_3.id)
      @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_4.id)
      @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_1.id)
      @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_2.id)
      @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_3.id)
      @item_5 = Item.create!(name: "Rye Bread", description: "Too many jokes to be had", unit_price: 500, merchant_id: @merchant_1.id)

      @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
      @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
      @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")
      @customer_4 = Customer.create!(first_name: "Walter", last_name: "Wheat")
      @customer_5 = Customer.create!(first_name: "David", last_name: "Dowie")
      @customer_6 = Customer.create!(first_name: "Clint", last_name: "Yeastwood")

      @invoice_1 = Invoice.create!(status: :completed, customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: :completed, customer_id: @customer_2.id)
      @invoice_3 = Invoice.create!(status: :completed, customer_id: @customer_3.id)
      @invoice_4 = Invoice.create!(status: :completed, customer_id: @customer_4.id)
      @invoice_5 = Invoice.create!(status: :completed, customer_id: @customer_5.id)
      @invoice_6 = Invoice.create!(status: :completed, customer_id: @customer_6.id)

      @transaction_1 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_2 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_3 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_4 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_5 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
      @transaction_6 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")

      @transaction_7 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_8 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_9 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_10 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
      @transaction_11 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")

      @transaction_12 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
      @transaction_13 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
      @transaction_14 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
      @transaction_15 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")

      @transaction_16 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")
      @transaction_17 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")
      @transaction_18 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")

      @transaction_19 = Transaction.create!(result: :success, invoice_id: @invoice_5.id, credit_card_number: "987654321")
      @transaction_20 = Transaction.create!(result: :success, invoice_id: @invoice_5.id, credit_card_number: "987654321")

      @transaction_21 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")
      @transaction_22 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")

      @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 2, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
      @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_3.id)
      @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1200, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
      @invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 500, status: 2, item_id: @item_5.id, invoice_id: @invoice_5.id)
      @invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 2, item_id: @item_5.id, invoice_id: @invoice_6.id)
    end

    it 'show the top merchants best day' do
      visit "/admin/merchants"
      # When I visit the admin merchants index
      within("#top_merchant-#{@merchant_5.id}") do
        expect(page).to have_content("Top selling date for #{@merchant_5.name} was #{@merchant_5.best_day.strftime("%-m/%d/%y")}")
        # Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
        # And I see a label “Top selling date for <merchant name> was <date with most sales>"
      end
    end
  end


end
