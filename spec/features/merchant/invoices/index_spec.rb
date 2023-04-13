require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page', type: :feature do
  before(:each) do
    # @merchant_1 = create(:merchant)
    visit merchant_invoices_path(@merchant_1.id)
  end

  it 'has a header' do
    expect(page).to have_content("#{@merchant_1.name} Invoices")
  end

  it 'it has invoice ids as links' do
    within "#invoice-#{@invoice_1.id}" do
      expect(page).to have_link("ID: #{@invoice_1.id}")
    end
  end
end
