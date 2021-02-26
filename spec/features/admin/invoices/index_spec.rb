require 'rails_helper'

RSpec.describe 'Admin/invoice index' do
  describe 'When I visit the admin/invoice index (/admin/invoice)' do
    before (:each) do
      @invoice_1 = create(:invoice)
      @invoice_2 = create(:invoice)
      @invoice_3 = create(:invoice)
      @invoice_4 = create(:invoice)
      @invoice_5 = create(:invoice)
      @invoice_6 = create(:invoice)
      @invoice_7 = create(:invoice)
      @invoice_8 = create(:invoice)
      @invoice_9 = create(:invoice)
      @invoice_10 = create(:invoice)
      @invoice_11 = create(:invoice)
      @invoice_12 = create(:invoice)
    end
    it 'Then I see the ID of each invoice in the system' do
      visit "/admin/invoices"
      
      expect(current_path).to eq("/admin/invoices")
      expect(page).to have_content("#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_2.id}")
      expect(page).to have_content("#{@invoice_3.id}")
      expect(page).to have_content("#{@invoice_4.id}")
      expect(page).to have_content("#{@invoice_5.id}")
      expect(page).to have_content("#{@invoice_6.id}")
      expect(page).to have_content("#{@invoice_7.id}")
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_4.id}")
      expect(page).to have_link("#{@invoice_5.id}")
      expect(page).to have_link("#{@invoice_6.id}")
      expect(page).to have_link("#{@invoice_7.id}")
    end
  end
end
