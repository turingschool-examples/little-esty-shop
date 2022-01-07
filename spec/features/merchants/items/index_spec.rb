require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Ron Swanson')
    @merchant_2 = Merchant.create!(name: 'Leslie Knope')
    @merchant_3 = Merchant.create!(name: 'Tom Haverford')
    @merchant_4 = Merchant.create!(name: 'April Ludgate')

    @item_1 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100, status: 0)
    @item_2 = @merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100, status: 0)
    @item_3 = @merchant_1.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100, status: 1)

    @customer_1 = Customer.create!(first_name: "Billy", last_name: "Joel")
    @customer_2 = Customer.create!(first_name: "Britney", last_name: "Spears")
    @customer_3 = Customer.create!(first_name: "Prince", last_name: "Mononym")
    @customer_4 = Customer.create!(first_name: "Garfunkle", last_name: "Oates")
    @customer_5 = Customer.create!(first_name: "Rick", last_name: "James")
    @customer_6 = Customer.create!(first_name: "Dave", last_name: "Chappelle")

    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
    @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')
    @invoice_3 = @customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')
    @invoice_4 = @customer_4.invoices.create!(status: 1, created_at: '2012-03-26 01:54:09')
    @invoice_5 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')
    @invoice_6 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')
    @invoice_7 = @customer_3.invoices.create!(status: 1)
    @invoice_8 = @customer_4.invoices.create!(status: 1)
    @invoice_9 = @customer_1.invoices.create!(status: 1)
    @invoice_10 = @customer_1.invoices.create!(status: 1)
    @invoice_11 = @customer_3.invoices.create!(status: 1)
    @invoice_12 = @customer_3.invoices.create!(status: 1)
    @invoice_13 = @customer_4.invoices.create!(status: 1)
    @invoice_14 = @customer_4.invoices.create!(status: 1)
    @invoice_15 = @customer_5.invoices.create!(status: 1)
    @invoice_16 = @customer_5.invoices.create!(status: 1)
    @invoice_17 = @customer_5.invoices.create!(status: 1)
    @invoice_18 = @customer_5.invoices.create!(status: 1)
    @invoice_19 = @customer_5.invoices.create!(status: 1)
    @invoice_20 = @customer_6.invoices.create!(status: 1)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, status: 0)

    @transaction_1 = @invoice_1.transactions.create!(result: 'success')
    @transaction_2 = @invoice_2.transactions.create!(result: 'success')
    @transaction_3 = @invoice_3.transactions.create!(result: 'success')


    visit merchant_items_path(@merchant_1.id)
  end

  scenario 'visitor sees the name of all items of particular merchant as links' do
    expect(current_path).to eq(merchant_items_path(@merchant_1.id))

    expect(page).to have_link("#{@item_1.name}", href: merchant_item_path(@merchant_1.id, @item_1.id))
    expect(page).to have_link("#{@item_2.name}", href: merchant_item_path(@merchant_1.id, @item_2.id))
    expect(page).to have_link("#{@item_3.name}", href: merchant_item_path(@merchant_1.id, @item_3.id))
  end

  describe 'item disable/enable button' do 
    scenario 'visitor sees a button to disable that item' do 
      within "#enabled_item-#{@item_1.name}" do
        expect(page).to have_button("Disable")
        click_button "Disable"
      end
      
      expect(page).to have_button("Enable")
      expect(current_path).to eq(merchant_items_path(@merchant_1.id))
    end 

    scenario 'visitor sees a button to disable that item' do 
      within "#disabled_item-#{@item_3.name}" do
        expect(page).to have_button("Enable")
        click_button "Enable"
      end
      
      expect(page).to have_button("Disable")
      expect(current_path).to eq(merchant_items_path(@merchant_1.id))
    end  
  end 
end
