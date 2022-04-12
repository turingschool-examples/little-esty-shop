require "rails_helper"

Rspec.describe 'admin index page' do
  it 'has a header incidacting that i am on the admin dashboard' do
   visit "/admin"
  expect(page).to have_content('Admin Dashboard')
end
