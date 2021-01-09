require 'rails_helper'

RSpec.describe "admin invoices show page" do
  before :each do 
    @invoice = FactoryBot.create(:invoice )
    visit admin_invoice_path(@invoice.id)
  end

  it "see information related to current invoice" do 
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
  end
end