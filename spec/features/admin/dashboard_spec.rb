require 'rails_helper'

RSpec.describe 'admin dashboard page' do
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
end
