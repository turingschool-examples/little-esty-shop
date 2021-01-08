require 'rails_helper'

RSpec.describe "admin invoices index" do
  before :each do 
    @invoices = FactoryBot.create_list(:invoice, 3)
  end

  it "displays a list of all invoice ids in the system" do 
    visit admin_invoices_path

    @invoices.each do |invoice|
      expect(page).to have_content(invoice.id)
    end
  end
end