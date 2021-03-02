require "rails_helper"

RSpec.describe "When I visit '/admin' I see the admin dashboard" do
  before :each do
    @merchant1 = create(:merchant)

    @customer1 = create(:customer)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)

    @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
    @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
    @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
    @invoice4 = create(:invoice, created_at: "2020-03-25 09:54:09 UTC")

    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 4, unit_price: 100)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)
  end

  it "displays all incomplete invoices as links" do
    visit admin_index_path

    within("#incomplete-invoices") do
      expect(page).to have_link("#{@invoice1.id}")
      expect(page).to have_link("#{@invoice2.id}")
      expect(page).to have_link("#{@invoice3.id}")
      expect(page).not_to have_link("#{@invoice4.id}")
    end
  end

  it 'displays incomplete invoices oldest to newest' do
    visit admin_index_path

    within("#incomplete-invoices") do
      expect("#{@invoice3.id}").to appear_before("#{@invoice2.id}")
      expect("#{@invoice2.id}").to appear_before("#{@invoice1.id}")
      expect("#{@invoice3.id}").to appear_before("#{@invoice1.id}")
    end
  end
end
