require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  before :each do


  end

  it 'should display a header indicating the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin Dashboard')
  end

  xit 'should have links to merchants and invoices index' do

    # uncomment out the first part of this test when we have
    # the admin invoices index page merged in!
    # It should fail since we don't have a link in our view -Katy

    # visit '/admin'
    # click_link "View invoices"

    # expect(current_path).to eq("/admin/invoices")

    visit '/admin'
    click_link "View merchants"

    expect(current_path).to eq("/admin/merchants")
  end
end
