require 'rails_helper'

RSpec.describe 'merchant invoice show page' do
  before :each do
    test_data
    visit merchant_invoice_path(@merchant_2, @invoice_2)
  end
  describe 'As a merchant, when I visit my merchant invoice show page' do
    it 'I see all of my items on the invoice including the item name, 
      quantity of item ordered,the price the Item sold for, and The Invoice Item status' do
  
      within "#invoice_item_#{@invoice_item_11.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@invoice_item_11.quantity)
        expect(page).to have_content(@invoice_item_11.unit_price)
        expect(page).to have_content(@invoice_item_11.status)

        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@invoice_item_2.unit_price)
      end

      within "#invoice_item_#{@invoice_item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@invoice_item_2.quantity)
        expect(page).to have_content(@invoice_item_2.unit_price)
        expect(page).to have_content(@invoice_item_2.status)

        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@invoice_item_11.unit_price)
      end
    end

    it 'I do not see any information related to Items for other merchants' do
      expect(page).to_not have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
      expect(page).to_not have_content(@item_7.name)
    end

    it 'I see the total revenue that will be generated
     from all of my items on the invoice' do
     within "#total_revenue" do
      expect(page).to have_content("Total Revenue: $80,000.00")
     end
    end
  end
end