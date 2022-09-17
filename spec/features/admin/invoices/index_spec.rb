require 'rails_helper'

RSpec.describe 'the Admin Invoices Index' do
  before :each do
    @invoices = create_list(:invoice, 20)
    visit admin_invoices_path
  end

  it 'has a list of all invoice IDs' do
    @invoices.each do |inv|
      expect(page).to have_content(inv.id)
    end
  end

  # it 'each id links to the admin invoice show page' do
  #   within "#all_invoices" do
  #     @invoices.each do |inv|
  #       within "inv_#{inv.id}" do
  #         click_link(inv.id)
  #         expect(current_path).to eq(admin_invoice_path(inv.id))
  #       end
  #     end
  #   end
  # end

  it 'each id links to the admin invoice show page' do
    click_link(@invoices[0].id)
    expect(current_path).to eq(admin_invoice_path(@invoices[0].id))
  end
  



end