require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do

  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @merchant_2 = create(:merchant)
    @item_3 = create(:item, merchant: @merchant_2)

    @invoice_1 = create(:invoice, status: :in_progress)
    @inv_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: :packaged)
    @inv_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, status: :packaged)
    @inv_item_3 = create(:invoice_item, invoice: @invoice_1, item: @item_3)

    visit merchant_invoice_path(@merchant_1.id, @invoice_1.id)
  end

  it 'shows the status of the invoice' do
    expect(page).to have_content("Status: In Progress")
  end

  it 'shows the date created in the correct format' do
    expect(page).to have_content("Created On: #{@invoice_1.created_at.strftime("%A, %B %-d, %Y")}")
  end

  it 'shows the customer name' do
    customer = @invoice_1.customer
    expect(page).to have_content("Customer: #{customer.first_name} #{customer.last_name}")
  end

  it 'has a list of the merchants items on the invoice' do
    within("tr#invoice_item_#{@inv_item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@inv_item_1.quantity)
      expect(page).to have_content("#{price_convert(@inv_item_1.unit_price)}")
      expect(page).to have_content(@inv_item_1.status.titleize)
    end
    within("tr#invoice_item_#{@inv_item_2.id}") do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@inv_item_2.quantity)
      expect(page).to have_content("#{price_convert(@inv_item_2.unit_price)}")
      expect(page).to have_content(@inv_item_2.status.titleize)
    end

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@inv_item_3.quantity)
  end

  it 'each invoice item has status dropdown with update button' do
    within("tr#invoice_item_#{@inv_item_1.id}") do
      select "Shipped", from: "invoice_item_status"
      click_button "Update Status"
      
      expect(current_path).to eq(merchant_invoice_path(@merchant_1.id, @invoice_1.id))
      expect(@inv_item_1.reload.status).to eq("shipped")
    end
    within("tr#invoice_item_#{@inv_item_2.id}") do
      select "Pending", from: "invoice_item_status"
      click_button "Update Status"
      
      expect(current_path).to eq(merchant_invoice_path(@merchant_1.id, @invoice_1.id))
      expect(@inv_item_2.reload.status).to eq("pending")
    end
  end

  it 'lists the total revenue for the merchants items on the invoice' do
    integer_total_revenue = @invoice_1.merchant_items(@merchant_1).total_revenue
    expect(page).to have_content("Total Revenue: #{price_convert(integer_total_revenue)}")
  end
end