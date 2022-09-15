require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do

  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @merchant_2 = create(:merchant)
    @item_3 = create(:item, merchant: @merchant_2)

    @invoice_1 = create(:invoice, status: :in_progress)
    @inv_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @inv_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2)
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
      expect(page).to have_content("$#{@inv_item_1.price_convert}")
      expect(page).to have_content(@inv_item_1.status.titleize)
    end
    within("tr#invoice_item_#{@inv_item_2.id}") do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@inv_item_2.quantity)
      expect(page).to have_content("$#{@inv_item_2.price_convert}")
      expect(page).to have_content(@inv_item_2.status.titleize)
    end

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@inv_item_3.quantity)
  end

end