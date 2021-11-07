require 'rails_helper'

RSpec.describe "admin invoices index" do
  before do
    @merchant = create(:merchant)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant, status: 'enabled')

    @customer3 = create :customer
    @customer4 = create :customer

    @item7 = create :item, { merchant_id: @merchant1.id }
    @item8 = create :item, { merchant_id: @merchant1.id }
    @item9 = create :item, { merchant_id: @merchant2.id }
    @item10 = create :item, { merchant_id: @merchant3.id }
    @item11 = create :item, { merchant_id: @merchant4.id }

    @invoice8 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 5) }
    @invoice9 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 6) }
    @invoice10 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }
    @invoice11 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }
    @invoice12 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }

    @transaction11 = create :transaction, { invoice_id: @invoice8.id, result: 'success' }
    @transaction12 = create :transaction, { invoice_id: @invoice9.id, result: 'success' }
    @transaction13 = create :transaction, { invoice_id: @invoice10.id, result: 'success' }
    @transaction14 = create :transaction, { invoice_id: @invoice11.id, result: 'success' }
    @transaction15 = create :transaction, { invoice_id: @invoice12.id, result: 'success' }

    @inv_item11 = create :invoice_item, { item_id: @item7.id, invoice_id: @invoice8.id, unit_price: 10000, quantity: 4}
    @inv_item12 = create :invoice_item, { item_id: @item8.id, invoice_id: @invoice9.id, unit_price: 3000, quantity: 6}
    @inv_item13 = create :invoice_item, { item_id: @item9.id, invoice_id: @invoice10.id, unit_price: 300, quantity: 30}
    @inv_item14 = create :invoice_item, { item_id: @item10.id, invoice_id: @invoice11.id, unit_price: 45, quantity: 3000}
    @inv_item15 = create :invoice_item, { item_id: @item11.id, invoice_id: @invoice12.id, unit_price: 1200, quantity: 7}

    visit admin_invoices_path
  end

  it 'lists all invoice ids as links to show pages' do
    expect(current_path).to eq(admin_invoices_path)

    expect(page).to have_content(@invoice8.id)
    expect(page).to have_content(@invoice9.id)
    expect(page).to have_content(@invoice10.id)
    expect(page).to have_content(@invoice11.id)
    expect(page).to have_content(@invoice12.id)

    within('#invoice-index') do
      within("#invoice-#{@invoice8.id}") do
        expect(page).to have_link(@invoice8.id)
        click_link "#{@invoice8.id}"
        expect(current_path).to eq(admin_invoice_path(@invoice8.id))
      end
    end
  end
end
