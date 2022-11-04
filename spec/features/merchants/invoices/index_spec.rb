require 'rails_helper'

RSpec.describe "Merchant Invoice Index" do 
  before :each do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
    @dk = Merchant.create!(name: "Dickinson-Klein")
    
    @watch = @klein_rempel.items.create!(name: "Watch", description: "Tells time on your wrist", unit_price: 300)
    @radio = @klein_rempel.items.create!(name: "Radio", description: "Broadcasts radio stations", unit_price: 150)
    @speaker = @klein_rempel.items.create!(name: "Speakers", description: "Listen to your music LOUD", unit_price: 250)

    @ufo = @dk.items.create!(name: "UFO Board", description: "Out of this world MotherBoard", unit_price: 400)
    @funnypowder = @dk.items.create!(name: "Funny Brick of Powder", description: "White Powder with Gasoline Smell", unit_price: 5000)
    @binocular = @dk.items.create!(name: "Binoculars", description: "See everything from afar", unit_price: 300)
    @tent = @dk.items.create!(name: "Tent", description: "Spend the night under the stars... or under THEM!", unit_price: 500)

    @sean = Customer.create!(first_name: "Sean", last_name: "Culliton")
    @sergio = Customer.create!(first_name: "Sergio", last_name: "Azcona")
    @emily = Customer.create!(first_name: "Emily", last_name: "Port")
    @kevin = Customer.create!(first_name: "Kevin", last_name: "Ta") 

    @invoice1 = Invoice.create!(status: 1, customer_id: @sergio.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice2 = Invoice.create!(status: 1, customer_id: @sean.id, created_at: "2022-11-02 11:00:00 UTC")
    @invoice3 = Invoice.create!(status: 1, customer_id: @emily.id, created_at: "2022-11-03 11:00:00 UTC")
    @invoice4 = Invoice.create!(status: 1, customer_id: @kevin.id, created_at: "2022-11-04 11:00:00 UTC")

    @funny_invoice = InvoiceItem.create!(quantity: 1, unit_price: 5000, status: 0, item_id: @funnypowder.id, invoice_id: @invoice1.id)
    @tent_invoice=InvoiceItem.create!(quantity: 2, unit_price: 5000, status: 1, item_id: @tent.id, invoice_id: @invoice2.id)
    @ufo_invoice = InvoiceItem.create!(quantity: 54, unit_price: 8000, status: 2, item_id: @ufo.id, invoice_id: @invoice3.id)

    @speaker_invoice= InvoiceItem.create!(quantity: 54, unit_price: 8000, status: 2, item_id: @speaker.id, invoice_id: @invoice4.id)
  end

  describe "When I visit my merchant's invoices index (/merchants/merchant_id/invoices)" do
    describe "I see all of the invoices that include at least one of my merchant's items" do
      it "for each invoice I see its id" do
        visit ("/merchants/#{@dk.id}/invoices")

        expect(page).to have_content("#{@dk.name} Invoices")

        expect(page).to_not have_content("#{@invoice4.id}")

        expect(page).to have_content("#{@invoice1.id}")
        expect(page).to have_content("#{@invoice2.id}")
        expect(page).to have_content("#{@invoice3.id}")
      end

      it "each id links to the merchant invoice show page" do
        visit ("/merchants/#{@dk.id}/invoices")
        click_on "#{@invoice1.id}"
        
        expect(current_path).to_not eq("/merchants/#{@klein_rempel.id}/invoices/#{@invoice4.id}")
        expect(current_path).to_not eq("/merchants/#{@dk.id}/invoices/#{@invoice3.id}")

        expect(current_path).to eq("/merchants/#{@dk.id}/invoices/#{@invoice1.id}")
        
        visit ("/merchants/#{@dk.id}/invoices")
        click_on "#{@invoice3.id}"

        expect(current_path).to_not eq("/merchants/#{@dk.id}/invoices/#{@invoice1.id}")
        expect(current_path).to_not eq("/merchants/#{@dk.id}/invoices/#{@invoice2.id}")
        
        expect(current_path).to eq("/merchants/#{@dk.id}/invoices/#{@invoice3.id}")
      end
    end
  end
end