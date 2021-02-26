require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/dashboard'" do
  before :each do
    @merchant1 = create(:merchant)

    @item = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)
    @item6 = create(:item, merchant_id: @merchant1.id)

    @invoice = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
    @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
    @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
    @invoice4 = create(:invoice, created_at: "2020-03-25 09:54:09 UTC")

    @invoice_item = create(:invoice_item, invoice_id: @invoice.id, item_id: @item.id, status: 0)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 1)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 0)
    @invoice_item5 = create(:invoice_item_with_invoices, item_id: @item5.id, status: 2)
    @invoice_item6 = create(:invoice_item_with_invoices, item_id: @item6.id, status: 2)
  end

  describe "I see a section for ~Items Ready to Ship~" do
    it "See names of items that have been ordered and not shipped" do

      visit merchant_dashboard_path(@merchant1)

      within('.items-ready') do
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)
        expect(page).to have_content(@item4.name)

        expect(page).not_to have_content(@item5.name)
        expect(page).not_to have_content(@item6.name)
      end
    end

    describe "Next to each item" do
      it "displays invoice id as a link to merchants invoice show page" do

        visit merchant_dashboard_path(@merchant1)

        within("#item-#{@item.id}") do
          expect(page).to have_link("#{@invoice_item.invoice.id}")
          click_link("#{@invoice_item.invoice.id}")
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice_item.invoice.id}")
      end
    end
    it "has the invoice created at date displayed as Day of Week, Month, Day, Year" do
      visit merchant_dashboard_path(@merchant1)

      within("#item-#{@item.id}") do
        expect(page).to have_content("Monday, March 25, 2013")
      end
    end
    it 'displays the invoice created_at date in oldest to newest' do
      visit merchant_dashboard_path(@merchant1)

      expect(@item3.name).to appear_before(@item2.name)
      expect(@item2.name).to appear_before(@item.name)
      expect(@item.name).to appear_before(@item4.name)
    end
  end
end
