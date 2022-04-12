require "rails_helper"

RSpec.describe 'admin index page' do
  it 'has a header incidacting that i am on the admin dashboard' do
   visit "/admin"
  expect(page).to have_content('Admin Dashboard')
end

  it 'has a link to the admin/merchant and admin/invoices indecise' do
    visit '/admin/'
    expect(page). to have_link('admin/merchants')
    expect(page). to have_link('admin/invoices')
  end
end
