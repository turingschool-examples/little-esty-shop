require 'rails_helper'

RSpec.describe 'admin dashboard page' do
  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer)
    @invoice_2 = create(:invoice, customer: @customer)
    @invoice_3 = create(:invoice, customer: @customer)
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @invoice_items_1 = create(:invoice_item, item: @item_1, status: 'shipped', invoice: @invoice_1)
    @invoice_items_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2)
    @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3)
    
  end

  it "has a header" do

    visit '/admin/dashboard'

    expect(page).to have_content('Admin Dashboard')
  end

  it "has links to merchants and invoices" do
    visit '/admin/dashboard'

    expect(page).to have_link('Merchants')
    expect(page).to have_link('Invoices')

    click_on 'Merchants'

    expect(current_path).to eq('/admin/merchants')

    visit '/admin/dashboard'

    click_on 'Invoices'

    expect(current_path).to eq('/admin/invoices')
  end

#   As an admin,
# When I visit the admin dashboard
# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page

  it "has a section for incomplete invoices and a list of the ids of the invoices that have not been shipped and links them to the admin show page" do
    visit '/admin/dashboard'


  end
end
