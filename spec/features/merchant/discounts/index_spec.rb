require "rails_helper"

RSpec.describe 'Discounts index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")

    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
    @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
    @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
    @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
    @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
    @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_6.id)
    @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_6.id)

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)

    InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
    InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
    InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
    
    @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_6.id)
    @transaction_7 = Transaction.create!(credit_card_number: "4654407418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: "4653405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_8.id)
    @transaction_9 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_9.id)
    @transaction_10 = Transaction.create!(credit_card_number: "4654435418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_10.id)
    @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_11.id)
    @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
    @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)

    @discount_1 = Discount.create!(name: "Sale Time", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
    @discount_2 = Discount.create!(name: "Labor Day Sale", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
    @discount_3 = Discount.create!(name: "Holiday Sale", threshold: 15, percentage: 30, merchant_id: @merchant_1.id)
    @discount_4 = Discount.create!(name: "Halloween Sale", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
    @discount_5 = Discount.create!(name: "Christmas Sale", threshold: 15, percentage: 30, merchant_id: @merchant_1.id)
    @discount_6 = Discount.create!(name: "Buy it", threshold: 20, percentage: 35, merchant_id: @merchant_2.id)
  end
  it 'lists all of the merchants discounts and their attributes' do
    visit merchant_discounts_path(@merchant_1)

    within("#discount_list") do
      @merchant_1.discounts.each do |discount|
        expect(page).to have_content(discount.name)
        expect(page).to have_content(discount.threshold)
        expect(page).to have_content(discount.percentage)
      end
    end

    expect(page).to_not have_content(@discount_6.name)
  end

  it 'has links to all the discounts show pages' do
    visit merchant_discounts_path(@merchant_1)

    within("#discount_list") do
      @merchant_1.discounts.each do |discount|
        expect(page).to have_link(discount.name)
      end

      click_link "#{@discount_1.name}"
    end

    expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1))
  end

  it 'has a link to create a new discount for this merchant' do
    visit merchant_discounts_path(@merchant_1)

    expect(page).to have_link("Create Discount")

    click_link "Create Discount"

    expect(current_path).to eq(new_merchant_discount_path(@merchant_1))
  end

  it 'has a button to delete a bulk discount' do
    visit merchant_discounts_path(@merchant_1)

    within("#discount_list") do
      expect(page).to have_button("Delete #{@discount_1.name}")

      click_button "Delete #{@discount_1.name}"

      expect(current_path).to eq(merchant_discounts_path(@merchant_1))
      expect(page).to_not have_content(@discount_1.name)
    end
  end

  it 'has a section that lists the next 3 holidays and their dates' do
    visit merchant_discounts_path(@merchant_1)
    @holidays = HolidaySearch.new

    within("#next_three_holidays") do
      expect(page).to have_content("Upcoming Holidays:")
      expect(page).to have_content(@holidays.next_three_holidays.first.local_name)
      expect(page).to have_content(@holidays.next_three_holidays.second.local_name)
      expect(page).to have_content(@holidays.next_three_holidays.third.local_name)
      expect(page).to have_content(@holidays.next_three_holidays.first.date)
      expect(page).to have_content(@holidays.next_three_holidays.second.date)
      expect(page).to have_content(@holidays.next_three_holidays.third.date)
    end
  end
end