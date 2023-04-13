require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    visit merchant_dashboard_path(@merchant_1.id)
  end

  it 'has a header' do
    expect(page).to have_content('Merchant Dashboard')
  end

  it 'has the merchant name; User Story 1' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has a link to the merchant items index; User Story 2' do
    expect(page).to have_link('Items Index')

    click_link('Items Index')

    expect(current_path).to eq(merchant_items_path(@merchant_1.id))
  end

  it 'has a link to the merchant invoices index; User Story 2' do
    expect(page).to have_link('Invoices Index')

    click_link('Invoices Index')

    expect(current_path).to eq(merchant_invoices_path(@merchant_1.id))
  end

  it 'has a list of the top 5 customers' do
    expect(page).to have_content('Top 5 Customers')
  end
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant
end