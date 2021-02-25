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

    @invoice_item = create(:invoice_item_with_invoices, item_id: @item.id, status: 0)
    @invoice_item2 = create(:invoice_item_with_invoices, item_id: @item2.id, status: 1)
    @invoice_item3 = create(:invoice_item_with_invoices, item_id: @item3.id, status: 1)
    @invoice_item4 = create(:invoice_item_with_invoices, item_id: @item4.id, status: 0)
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

    describe "Next to each item I see id of the invoice that ordered the item" do
      it "And the invoice id is a link to merchants invoice show page" do

        visit merchant_dashboard_path(@merchant1)

        within("#item-#{@item.id}") do
          expect(page).to have_link("#{@invoice_item.invoice.id}")
          click_link("#{@invoice_item.invoice.id}")
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice_item.invoice.id}")
      end
    end
  end
end

#   As a merchant
# When I visit my merchant dashboard
# Then I see a section for "Items Ready to Ship"
# In that section I see a list of the names of all of my items that
# have been ordered and have not yet been shipped,
# And next to each Item I see the id of the invoice that ordered my item
# And each invoice id is a link to my merchant's invoice show page
