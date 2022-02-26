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

  it 'displays all open invoices' do
    invoice1 = create(:invoice, status: "in progress")
    invoice2 = create(:invoice, status: "cancelled")
    invoice3 = create(:invoice, status: "completed")
    invoice4 = create(:invoice, status: "in progress")
    invoice5 = create(:invoice, status: "completed")
    invoice6 = create(:invoice, status: "in progress")

    visit ('/admin')

    expect(page).to have_content("Invoice Number: #{invoice1.id}")
    expect(page).to have_content("Invoice Number: #{invoice4.id}")
    expect(page).to have_content("Invoice Number: #{invoice6.id}")
    expect(page).to_not have_content("Invoice Number: #{invoice2.id}")
    expect(page).to_not have_content("Invoice Number: #{invoice3.id}")
    expect(page).to_not have_content("Invoice Number: #{invoice5.id}")
  end

  it 'displays invoice created dates in the correct format' do
    invoice1 = create(:invoice, status: "in progress", created_at: "Tue, 06 Mar 2012 15:54:17 UTC +00:00")

    visit ('/admin')

    expect(page).to have_content("Invoice Number: #{invoice1.id} - created Tuesday, March 06, 2012")
  end
end
