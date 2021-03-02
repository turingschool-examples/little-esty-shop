require "rails_helper"

RSpec.describe "When I visit '/admin'" do
  before :each do
    @merchant1 = create(:merchant)

    @item = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)
    @item6 = create(:item, merchant_id: @merchant1.id)

    @invoice_item = create(:invoice_item_with_invoices, item_id: @item.id)
    @invoice_item2 = create(:invoice_item_with_invoices, item_id: @item2.id)
    @invoice_item3 = create(:invoice_item_with_invoices, item_id: @item3.id)
    @invoice_item4 = create(:invoice_item_with_invoices, item_id: @item4.id)
    @invoice_item5 = create(:invoice_item_with_invoices, item_id: @item5.id)
    @invoice_item6 = create(:invoice_item_with_invoices, item_id: @item6.id)

    @transactions = create_list(:transaction, 6, invoice_id: @invoice_item.invoice.id, result: "success")
    @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: "success")
    @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: "success")
    @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: "success")
    @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: "success")
    @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: "failed")

    @customer = @invoice_item.invoice.customer
    @customer2 = @invoice_item2.invoice.customer
    @customer3 = @invoice_item3.invoice.customer
    @customer4 = @invoice_item4.invoice.customer
    @customer5 = @invoice_item5.invoice.customer
    @customer6 = @invoice_item6.invoice.customer
  end

  it "Shows top 5 customers by successful transactions" do

    visit admin_index_path

    within("#top-customers") do
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer2.first_name)
      expect(page).to have_content(@customer3.first_name)
      expect(page).to have_content(@customer4.first_name)
      expect(page).to have_content(@customer5.first_name)
      expect(page).not_to have_content(@customer6.first_name)

      expect(@customer5.first_name).to appear_before(@customer4.first_name)
      expect(@customer4.first_name).to appear_before(@customer3.first_name)
      expect(@customer3.first_name).to appear_before(@customer2.first_name)
      expect(@customer2.first_name).to appear_before(@customer.first_name)
    end

    within("#customer-#{@customer5.id}") do
      expect(page).to have_content("Successful Transactions: 10")
    end
  end
end
