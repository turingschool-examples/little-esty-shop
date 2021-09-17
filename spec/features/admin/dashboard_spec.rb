require 'rails_helper'

RSpec.describe 'admin dashboard page' do
  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer)
    @invoice_2 = create(:invoice, customer: @customer)
    @invoice_3 = create(:invoice, customer: @customer, created_at: Date.yesterday)
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, item: @item_1, status: 'shipped', invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3)

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

  it "has a section for incomplete invoices and a list of the ids of the invoices that have not been shipped and links them to the admin show page" do
    visit '/admin/dashboard'

    expect(page).to have_content("Incomplete Invoices")
    within("#incomplete-invoices") do
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)

      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).not_to have_link("#{@invoice_1.id}")
    end

    click_on "#{@invoice_2.id}"
    expect(current_path).to eq(admin_invoice_path(@invoice_2))
  end

  it 'sorts incomplete invoices by oldest first' do
    visit '/admin/dashboard'


    expect("#{@invoice_3.id}").to appear_before("#{@invoice_2.id}")

  end


#   As an admin,
# When I visit the admin dashboard
# In the section for "Incomplete Invoices",
# Next to each invoice id I see the date that the invoice was created
end
