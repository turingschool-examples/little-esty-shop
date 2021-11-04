require 'rails_helper'

RSpec.describe "admin dashboard" do
  before do
    @merchant = create(:merchant)

    @customer1 = create :customer
    @customer2 = create :customer
    @customer3 = create :customer
    @customer4 = create :customer
    @customer5 = create :customer
    @customer6 = create :customer

    @item = create :item, { merchant_id: @merchant.id }

    @invoice1 = create :invoice, { customer_id: @customer1.id, status: 'in progress' }
    @invoice2 = create :invoice, { customer_id: @customer2.id, status: 'in progress' }
    @invoice3 = create :invoice, { customer_id: @customer3.id, status: 'in progress' }
    @invoice4 = create :invoice, { customer_id: @customer4.id, status: 'in progress' }
    @invoice5 = create :invoice, { customer_id: @customer5.id, status: 'completed' }
    @invoice6 = create :invoice, { customer_id: @customer6.id, status: 'cancelled' }

    @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
    @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
    @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
    @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
    @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
    @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

    @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id}
    @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id}
    @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id}
    @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id}
    @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id}
    @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id}

    visit admin_dashboard_path
  end

  it 'shows that you are on the admin dashboard' do
    expect(page).to have_content("Admin Dashboard")
  end

  it 'can link to admin merchants index' do
    click_link("My Merchants")
    expect(current_path).to eq(admin_merchants_path)
  end

  it 'can link to admin invoices index' do
    click_link("My Invoices")
    expect(current_path).to eq(admin_invoices_path)
  end

end
