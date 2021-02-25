require 'rails_helper'

describe 'When I visit the admin merchants (/admin/merchants)' do
    #i need to creat items
    #i need to merchants
    #i need to create Itemmerchants
    before (:each) do
      @invoice_1 = create(:invoice)
      @invoice_2 = create(:invoice)
      @invoice_3 = create(:invoice)
    end

  it 'When I click on the name of a invoice from the admin invoices index page' do
    visit "/admin/invoices"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_2.id}")
    expect(page).to have_link("#{@invoice_2.id}")
    expect(page).to have_content("#{@invoice_3.id}")
    expect(page).to have_link("#{@invoice_3.id}")
    save_and_open_page

  end

  it 'Then I am taken to that invoices admin show page (/admin/invoices/invoice_id)' do
    visit "/admin/invoices"

    expect(page).to have_link("#{@invoice_1.id}")
    click_link("#{@invoice_1.id}")
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.id}")
  end
end





# As an admin,
# When I visit the admin Invoices index ("/admin/invoices")
# Then I see a list of all Invoice ids in the system
# Each id links to the admin invoice show page
