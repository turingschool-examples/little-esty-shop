require 'rails_helper'
describe 'Admin Invoice Index Page' do
  before :each do
    @customer = create(:customer)
    @invoice = []
    10.times {@invoice << create(:invoice, customer_id: @customer.id)}
  end

  it 'Lists all Invoice ids' do
    visit admin_invoices_path

    expect(page).to have_link(@invoice[0].id)
    expect(page).to have_link(@invoice[1].id)
    expect(page).to have_link(@invoice[2].id)
    expect(page).to have_link(@invoice[3].id)
    expect(page).to have_link(@invoice[4].id)
    expect(page).to have_link(@invoice[5].id)
    expect(page).to have_link(@invoice[6].id)
    expect(page).to have_link(@invoice[7].id)
    expect(page).to have_link(@invoice[8].id)
    expect(page).to have_link(@invoice[9].id)
  end
end