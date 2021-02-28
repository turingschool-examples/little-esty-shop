require 'rails_helper'
require 'time'

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
    expect(page).to have_no_content(@invoice_6.id) # when interpolated it was triggering fail/error due to "2021" BEING FOUND.
  end

  it 'Then I see a link to the admin merchants index (/admin/merchants)' do
    visit "/admin"
# question: is the above it string correct?
    expect(page).to have_link("#{@invoice_1.id}")
    click_link("#{@invoice_1.id}")
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
  end

  it "Displays the date created next to each invoice formatted 'Monday, July 18, 2019'" do
    visit "/admin"

    expect(page).to have_content("Invoice: #{@invoice_1.id} - #{@invoice_1.date_created}")
    expect(page).to have_content("Invoice: #{@invoice_2.id} - #{@invoice_2.date_created}")
    expect(page).to have_content("Invoice: #{@invoice_3.id} - #{@invoice_3.date_created}")
    expect(page).to have_content("Invoice: #{@invoice_7.id} - #{@invoice_7.date_created}")
  end

  it 'And I see that the list is ordered from oldest to newest' do
    Invoice.destroy_all
    invoice_1 = create(:invoice, status: 0, created_at: Time.parse("2015-10-31"))
    invoice_2 = create(:invoice, status: 0, created_at: Time.parse("2010-09-20"))
    invoice_3 = create(:invoice, status: 2, created_at: Time.parse("2019-03-25"))
    invoice_7 = create(:invoice, status: 2, created_at: Time.parse("2000-11-18"))
    visit "/admin"

    expect("Invoice: #{invoice_7.id} - #{invoice_7.date_created}").to appear_before("Invoice: #{invoice_2.id} - #{invoice_2.date_created}")
    expect("Invoice: #{invoice_2.id} - #{invoice_2.date_created}").to appear_before("Invoice: #{invoice_1.id} - #{invoice_1.date_created}")
    expect("Invoice: #{invoice_1.id} - #{invoice_1.date_created}").to appear_before("Invoice: #{invoice_3.id} - #{invoice_3.date_created}")    
  end
end
