require 'rails_helper'

RSpec.describe "admin invoice show" do
  before do
    @merchant = create(:merchant)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)

    @customer3 = create :customer
    @customer4 = create :customer

    @item7 = create :item, { merchant_id: @merchant1.id }
    @item8 = create :item, { merchant_id: @merchant1.id }
    @item9 = create :item, { merchant_id: @merchant2.id }
    @item10 = create :item, { merchant_id: @merchant3.id }
    @item11 = create :item, { merchant_id: @merchant.id }

    @invoice8 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 5) }

    visit admin_invoice_path(@invoice8.id)
  end

  it 'shows invoice info' do
    expect(page).to have_content(@invoice8.id)
    expect(page).to have_content(@invoice8.status)
    expect(page).to have_content(@invoice8.created_at.strftime('%A, %B%e, %Y'))
    expect(page).to have_content(@invoice8.customer.full_name)
  end
end
