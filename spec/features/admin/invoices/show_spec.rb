require 'rails_helper'

RSpec.describe "Admin Invoice Show" do
    before :each do
      @merch1 = Merchant.create!(name: 'Floopy Fopperations')
      @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
      @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
      @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

      @merch2 = Merchant.create!(name: 'Goopy Gopperations')
      @item4 = @merch2.items.create!(name: 'Goopy Original', description: 'the bester', unit_price: 1450)
      @item5 = @merch2.items.create!(name: 'Goopy Updated', description: 'the even better', unit_price: 1950)

      @cust1 = Customer.create!(first_name: "Mark", last_name: "Ruffalo")

      @inv1 = @cust1.invoices.create!(status: "in progress")
      @inv2 = @cust1.invoices.create!(status: "completed")

      InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv1.id}")
      InvoiceItem.create!(item_id: "#{@item4.id}", invoice_id: "#{@inv2.id}")
    end

    it 'shows me the admin invoice index page with all the invoices' do


      # As an admin,
      # When I visit an admin invoice show page
      # Then I see information related to that invoice including:
      #
      # Invoice id
      # Invoice status
      # Invoice created_at date in the format "Monday, July 18, 2019"
      # Customer first and last name

      visit("/admin/invoices/#{@inv1.id}")
      save_and_open_page
      # binding.pry

      expect(page).to have_content("#{@inv1.id}")
      expect(page).to have_content("#{@inv1.status}")
      expect(page).to have_content(@inv1.created_at.strftime('%A, %B%e, %Y'))
      expect(page).to have_content("Mark Ruffalo")

    end


end
