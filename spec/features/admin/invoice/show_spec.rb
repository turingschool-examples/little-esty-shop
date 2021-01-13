require 'rails_helper'

RSpec.describe "admin invoices show page" do
  before :each do 
    @invoice = FactoryBot.create(:invoice)
    FactoryBot.create_list(:invoice_item, 4, invoice_id: @invoice.id )
    visit admin_invoice_path(@invoice.id)
  end

  it "displays information related to current invoice" do 
    within("#invoice-information") do 
      expect(page).to have_content(@invoice.id)
      expect(page).to have_content(@invoice.status)
      expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
    end
  end

  it "displays customer information related to current invoice" do 
    within("#customer-information") do 
      expect(page).to have_content(@invoice.customer.first_name)
      expect(page).to have_content(@invoice.customer.last_name)
      expect(page).to have_content(@invoice.customer.address)
    end
  end

  it "displays items' information related to invoice" do 
    within("#invoice-items-information") do 
      @invoice.invoice_items.each do |ii|
        within("#invoice-item-#{ii.id}") do 
          expect(page).to have_content(ii.item.name)
          expect(page).to have_content(ii.quantity)
          expect(page).to have_content(ii.unit_price)
          expect(page).to have_content(ii.status)
        end
      end
    end
  end

  it "displays total revenue of the current invoice" do 
    within("#invoice-information") do 
      expect(page).to have_content(@invoice.invoice_items.invoice_amount)
    end
  end

  describe "admin invoice status link" do 
    it "has a select field for status with the current status selected" do 
      within("#invoice-information") do 
        expect(page).to have_selector(:id, 'status', text: @invoice.status)
      end
    end
    it "can select a new status and update the status" do 
      within("#invoice-information") do 
        expect(page).to have_select('status', selected: @invoice.status, options: ['in progress', 'completed', 'cancelled'])
        page.select('completed', from: 'status')
        click_on 'Save'
        expect(current_path).to eq(admin_invoice_path(@invoice.id))
        expect(page).to have_content('completed')
      end
    end
  end

end