require 'rails_helper'

describe 'When I visit the admin dashboard (/admin)' do
    #i need to creat items
    #i need to invoices
    #i need to create ItemInvoices
    before (:each) do
      @invoice_1 = create(:invoice, status: 0)
      @invoice_2 = create(:invoice, status: 0)
      @invoice_3 = create(:invoice, status: 2)
      @invoice_4 = create(:invoice, status: 1)
      @invoice_5 = create(:invoice, status: 1)
      @invoice_6 = create(:invoice, status: 1)
      @invoice_7 = create(:invoice, status: 2)
    end

  it 'Then I see a section for "Incomplete Invoices"' do 
    visit "/admin"

    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_2.id}")
    expect(page).to have_link("#{@invoice_2.id}")
    expect(page).to have_content("#{@invoice_3.id}")
    expect(page).to have_link("#{@invoice_3.id}")
    expect(page).to have_content("#{@invoice_7.id}")
    expect(page).to have_link("#{@invoice_7.id}")
    expect(page).to have_no_content("#{@invoice_4.id}")
    expect(page).to have_no_content("#{@invoice_5.id}")
    expect(page).to have_no_content("#{@invoice_6.id}")
  end

  it 'Then I see a link to the admin merchants index (/admin/merchants)' do
    visit "/admin"

    expect(page).to have_link("#{@invoice_1.id}")
    click_link("#{@invoice_1.id}")
    
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
  end
end

# As an admin,
# When I visit the admin dashboard
# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page
