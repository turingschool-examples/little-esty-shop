require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'has link to merchants page' do
    visit "/"

    expect(page).to have_link("Admin")
    expect(page).to have_link("Admin Merchants")
    expect(page).to have_link("Admin Invoices")
  end
end