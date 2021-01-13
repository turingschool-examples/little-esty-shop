require 'rails_helper'

RSpec.describe "admin invoices index page" do
  before :each do 
    @invoices = FactoryBot.create_list(:invoice, 3)
    visit admin_invoices_path
  end

  it "displays a list of all invoice ids in the system" do 
    within("#all-invoices") do 
      @invoices.each do |invoice|
        within("#invoice-#{invoice.id}") do 
          expect(page).to have_content(invoice.id)
        end
      end
    end
  end

  it "has a link for each id that redirects to the invoice show page" do 
    @invoices.each do |invoice|
      within("#invoice-#{invoice.id}") do 
        expect(page).to have_link("#{invoice.id}")
        click_link "#{invoice.id}"
        expect(current_path).to eq(admin_invoice_path(invoice.id))
        visit admin_invoices_path
      end
    end
  end
end