require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  before :each do


  end

  it 'should display a header indicating the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin Dashboard')
  end

  it 'should have links to merchants and invoices index' do
    visit '/admin'
    click_link "View invoices"

    expect(current_path).to eq("/admin/invoices")

    visit '/admin'
    click_link "View merchants"

    expect(current_path).to eq("/admin/merchants")
  end
end
