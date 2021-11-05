require 'rails_helper'

RSpec.describe "admin dashboard" do
  before do
    @merchant = create(:merchant)

    @customer1 = create :customer
    @customer2 = create :customer
    @customer3 = create :customer
    @customer4 = create :customer
    @customer5 = create :customer
    @customer6 = create :customer

    @item = create :item, { merchant_id: @merchant.id }

    @invoice1 = create :invoice, { customer_id: @customer1.id, status: 'in progress' }
    @invoice2 = create :invoice, { customer_id: @customer2.id, status: 'in progress' }
    @invoice3 = create :invoice, { customer_id: @customer3.id, status: 'in progress' }
    @invoice4 = create :invoice, { customer_id: @customer4.id, status: 'in progress' }
    @invoice5 = create :invoice, { customer_id: @customer5.id, status: 'completed' }
    @invoice6 = create :invoice, { customer_id: @customer6.id, status: 'cancelled' }

    @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
    @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
    @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
    @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
    @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
    @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

    @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id, status: "pending"}
    @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id, status: "pending"}
    @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id, status: "pending"}
    @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id, status: "packaged"}
    @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id, status: "packaged"}
    @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id, status: "shipped"}

    visit admin_dashboard_path
  end

  it 'shows that you are on the admin dashboard' do
    expect(page).to have_content("Admin Dashboard")
  end

  it 'can link to admin merchants index' do
    click_link("My Merchants")
    expect(current_path).to eq(admin_merchants_path)
  end

  it 'can link to admin invoices index' do
    click_link("My Invoices")
    expect(current_path).to eq(admin_invoices_path)
  end

  it 'i see the names of the top 5 cust (>success trans) with success trans count' do
    within("#top5") do
      within("#cust-#{@customer1.id}") do
        expect(page).to have_content(@customer1.full_name)
        expect(page).to have_content(1)
      end
    end
  end

  it 'I see a section for incomplete invoices, with a link to each invoice id, and the date it was created' do
    within("#incomplete_invoices") do
      within("#invoice-#{@invoice1.id}") do
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice1.created_at.strftime('%A, %B%e, %Y'))
        click_link(@invoice1.id)
        expect(current_path).to eq(admin_invoice_path(@invoice1))
      end
    end
  end

  it 'the incomplete invoices list is sorted from oldest to newest' do
    expect("(Invoice #{@invoice4.id})").to appear_before("(Invoice #{@invoice3.id})")
    expect("(Invoice #{@invoice2.id})").to appear_before("(Invoice #{@invoice1.id})")
  end

end

# Admin Dashboard Incomplete Invoices
#
# As an admin,
# When I visit the admin dashboard
# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page
# Admin Dashboard Invoices sorted by least recent
#
# As an admin,
# When I visit the admin dashboard
# In the section for "Incomplete Invoices",
# Next to each invoice id I see the date that the invoice was created
# And I see the date formatted like "Monday, July 18, 2019"
# And I see that the list is ordered from oldest to newest
