require 'rails_helper'

RSpec.describe 'merchants dashboard' do
  before :each do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')
    @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
    @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
    @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 2)
    InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 0)
    InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 1)
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 1)
    InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 2)
  end
  it 'shows the name of the merchant' do
    visit "/merchants/#{@merch1.id}/dashboard"

    expect(page).to have_content(@merch1.name)
  end

  it 'shows links to the merchants items index and invoices index' do
    visit "/merchants/#{@merch1.id}/dashboard"

    expect(page).to have_link('Items Index')

    expect(page).to have_link('Invoices Index')
  end

  it "has a section for items ready to ship" do
    visit "/merchants/#{@merch1.id}/dashboard"
    within "#ready-items" do
      expect(page).to have_content("Items Ready to Ship") 
      expect(page).to have_content("Floopy Updated")
      expect(page).to have_content("#{@invoice1.id}")
      expect(page).to have_content("Floopy Retro") 
      expect(page).to have_content("#{@invoice2.id}")
      expect(page).to_not have_content("Floopy Original") 
      expect(page).to_not have_content("Floopy Geo") 
    end
  end

  it "has link from items ready to ship that leads to merchant invoice show page" do
    visit "/merchants/#{@merch1.id}/dashboard"
    within "#ready-items" do
      expect(page).to have_content("#{@invoice1.id}")
      click_link "#{@invoice1.id}"
    end
    expect(current_path).to eq("/merchants/#{@merch1.id}/invoices/#{@invoice1.id}")
  end
  
  
end
