require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer1.invoices.create!(status: 0)
    @invoice3 = @customer1.invoices.create!(status: 1)
    @invoice4 = @customer1.invoices.create!(status: 2)
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

    expect(page).to have_content(@invoice1.id)

    expect(page).to have_content(@invoice2.id)

    expect(page).to have_content(@invoice3.id)

    expect(page).to_not have_content(@invoice4.id)
  end
end
