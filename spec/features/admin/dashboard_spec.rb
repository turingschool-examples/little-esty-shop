require 'rails_helper'

RSpec.describe 'merchants dashboard' do
  before :each do
  end
  it 'shows admin dashboard' do
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'shows the admin dashboard with links' do
    visit '/admin'

    click_link('Admin Merchants Index')
    expect(current_path).to eq('/admin/merchants')

    visit '/admin'

    click_link('Admin Invoices Index')
    expect(current_path).to eq('/admin/invoices')
  end

  it 'shows incomplete invoices' do
    visit '/admin'

    expect(page).to have_content('Incomplete Invoices:')
  end
end
