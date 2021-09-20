require "rails_helper"

RSpec.describe 'admin invoice show page' do
  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer, created_at: Date.new(2021, 9, 17))
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1)
  end

  it 'shows relevant invoice information' do
    visit admin_invoice_path(@invoice_1)

    within('#invoice-information') do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Friday, September 17, 2021")
      expect(page).to have_content("#{@customer.first_name} #{@customer.last_name}")
    end
  end

  it 'shows invoice item info' do
    visit(admin_invoice_path(@invoice_1))

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)

    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@invoice_item_2.quantity)
    expect(page).to have_content(@invoice_item_2.unit_price)
    expect(page).to have_content(@invoice_item_2.status)
  end

  it 'shows total revenue' do
    visit(admin_invoice_path(@invoice_1))

    expect(page).to have_content(@invoice_1.revenue)
  end

  it 'can see and update invoice status' do
    visit(admin_invoice_path(@invoice_1))

    within('#change-status') do
      expect(page).to have_content(@invoice_1.status)
    end

    select('completed', from: 'invoice_status')

    within('#change-status') do
      click_button 'Update Invoice Status'
    end

    expect(current_path).to eq(admin_invoice_path(@invoice_1))

    within('#change-status') do
      expect(page).to have_content('completed')
    end
  end
end
