require 'rails_helper'

RSpec.describe 'admin dashboard show page' do
  before(:each) do
    visit "/admin/"
  end

  it 'has a link to admin merchants' do
    click_link("Merchants")

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'has a link to admin invoices' do
    click_link("Invoices")

    expect(current_path).to eq(admin_invoices_path)
  end

  it 'exists' do 
  end

end