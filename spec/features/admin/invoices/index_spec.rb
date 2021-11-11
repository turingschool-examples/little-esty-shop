require 'rails_helper'
# FactoryBot.find_definitions

RSpec.describe 'admin invoice index' do
  before :each do
    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)
    @invoice_5 = create(:invoice)
  end

  it 'lists all of the invoice ids' do
    visit '/admin/invoices'

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    expect(page).to have_content(@invoice_4.id)
    expect(page).to have_content(@invoice_5.id)
  end

  it 'links to the invoice show page' do
    visit '/admin/invoices'

    click_link("#{@invoice_1.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
  end
end
