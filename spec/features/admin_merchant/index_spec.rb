require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")
    @customer7 = Customer.create!(first_name: "Molly", last_name: "Rae")

    @merchant1 = Merchant.create!(name: "Jimbo")
    @merchant2 = Merchant.create!(name: "Linda")
    @merchant3 = Merchant.create!(name: "Johnny")
    @merchant4 = Merchant.create!(name: "Miranda")
    @merchant5 = Merchant.create!(name: "Charlie")
    @merchant6 = Merchant.create!(name: "Kim")

    @item1 = Item.create!(name: "spatula", description: "fold them eggs", unit_price: 14.00, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bowling ball", description: "roll em if you got em", unit_price: 68.00, merchant_id: @merchant2.id)

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled", created_at: "1990-03-23 21:40:46")
    @invoice2 = Invoice.create!(customer_id: @customer2.id, status: "in progress")
    @invoice3 = Invoice.create!(customer_id: @customer3.id, status: "completed", created_at: "1991-03-23 21:40:46")
    @invoice4 = Invoice.create!(customer_id: @customer4.id, status: "cancelled")
    @invoice5 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice6 = Invoice.create!(customer_id: @customer6.id, status: "completed")
    @invoice7 = Invoice.create!(customer_id: @customer7.id, status: "completed")

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 28.00, status: "pending" )
    @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 68.00, status: "shipped" )
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 68.00, status: "packaged" )

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction2 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction3 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction4 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction5 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction6 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction7 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction8 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction9 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction10 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction11 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction12 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction13 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction14 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction15 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction16 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction17 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction18 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction19 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction20 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction21 = Transaction.create!(invoice_id: @invoice6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction22 = Transaction.create!(invoice_id: @invoice7.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
  end
  it 'When I visit the admin merchants index (/admin/merchants)
    Then I see the name of each merchant in the system' do

    visit admin_merchants_path

    expect(page).to have_content("Admin Merchants Index")

    expect(page).to have_link("#{@merchant1.name}")
    expect(page).to have_link("#{@merchant2.name}")
  end
  it 'When I click on the name of a merchant from the admin merchants index page,
    Then I am taken to that merchants admin show page (/admin/merchants/merchant_id)
    And I see the name of that merchant' do
    visit admin_merchants_path

    within("#admin_merchants-#{@merchant1.id}") do
      click_on("#{@merchant1.name}")
    end

    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_content(@merchant1.name)
  end
  it 'When I visit the admin merchants index
    Then next to each merchant name I see a button to disable or enable that merchant.' do
    visit admin_merchants_path

    within("#admin_merchants-#{@merchant1.id}") do
      expect(page).to have_button("Disable")
    end
  end
  it 'When I click this button Then I am redirected back to the admin merchants index
    And I see that the merchants status has changed' do
    visit admin_merchants_path

    within("#admin_merchants-#{@merchant1.id}") do
      click_on("Disable")
    end

    expect(current_path).to eq(admin_merchants_path)

    within("#admin_merchants-#{@merchant1.id}") do
      expect(page).to have_button("Enable")
    end
  end
  it 'I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
    And I see that each Merchant is listed in the appropriate section' do
    visit admin_merchants_path

    within("#enabled_merchants") do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
    end

    within("#disabled_merchants") do
      expect(page).to_not have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    within("#admin_merchants-#{@merchant1.id}") do
      click_on("Disable")
    end

    expect(current_path).to eq(admin_merchants_path)

    within("#admin_merchants-#{@merchant1.id}") do
      expect(page).to have_button("Enable")
    end

    within("#enabled_merchants") do
      expect(page).to_not have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
    end

    within("#admin_merchants-#{@merchant1.id}") do
      click_on("Enable")
    end

    expect(current_path).to eq(admin_merchants_path)

    within("#disabled_merchants") do
      expect(page).to_not have_content(@merchant1.name)
    end
  end

  it 'I see a link to create a new merchant.' do
    visit admin_merchants_path

    expect(page).to have_link("Create New Merchant")
  end

  it 'When I click on the link, I am taken to a form that allows me
    to add merchant information. When I fill out the form I click ‘Submit’. Then I am taken
    back to the admin merchants index page. And I see the merchant I just created displayed.
    And I see my merchant was created with a default status of enabled.' do
    visit admin_merchants_path

    click_on("Create New Merchant")

    expect(current_path).to eq(new_admin_merchant_path)

    fill_in "name", with: "Sweet baby Jake"

    click_on "Submit"

    expect(current_path).to eq(admin_merchants_path)

    within("#enabled_merchants") do
      expect(page).to have_content("Sweet baby Jake")
    end
  end
  it 'I see the names of the top 5 merchants by total revenue generated And I see the
    total revenue generated next to each merchant name' do
    visit admin_merchants_path

    within(".top_five_merchants") do
      save_and_open_page
      expect(page).to have_link(@merchant1.name)
      # expect(page).to have_link(@merchant2.name)
      # expect(page).to have_link(@merchant3.name)
      # expect(page).to have_link(@merchant4.name)
      # expect(page).to have_link(@merchant5.name)
      # expect(page).to_not have_link(@merchant6.name)
    end

    within("#top_five_merchants-#{@merchant1.id}") do
      expect(page).to have_content("Revenue: $948")
    end
  end

  it "When I click on merchant name link, I am taken to the admin merchant show page
    for that merchant " do
    visit admin_merchants_path

    within("#top_five_merchants-#{@merchant1.id}") do
      click_on(@merchant1.name)
    end

    expect(current_path).to eq(admin_merchant_path(@merchant1))
  end
end

# Notes on Revenue Calculation:
# - Only invoices with at least one successful transaction should count towards revenue
# - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
