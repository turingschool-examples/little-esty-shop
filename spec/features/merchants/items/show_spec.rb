require "rails_helper"

RSpec.describe "Merchant items show page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
    @merchant2 = Merchant.create!(name: 'Jays Foot Made Jewlery')

    @item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'darrel', description: 'Bracelet', unit_price: 40, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'don', description: 'Necklace', unit_price: 30, merchant_id: @merchant1.id)

    @item4 = Item.create!(name: 'fake', description: 'Toe Ring', unit_price: 30, merchant_id: @merchant2.id)

    @customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
    @customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer1.id)

    @invoice4 = Invoice.create!(status: 1, customer_id: @customer2.id)

    @transaction1 = Transaction.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07', invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07', invoice_id: @invoice3.id)

    @transaction4 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: @invoice4.id)

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
    @ii3 = InvoiceItem.create!(quantity: 5, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice3.id)

    @ii4 = InvoiceItem.create!(quantity: 5, unit_price: @item4.unit_price, item_id: @item4.id, invoice_id: @invoice4.id)
  end
  describe "story 7" do 
#     As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
# And I see all of the item's attributes including:

# - Name
# - Description
# - Current Selling Price
    it 'can click on the names of items and take me to the merchant show page' do
      visit merchant_item_index_path(@merchant1)
      click_on('Chips')

      expect(page).to have_current_path("/merchant/#{@merchant1.id}/item/#{@item1.id}")
    end
    it 'I see all of its attributes' do
      # visit merchant_item_path(@merhcant1, @item1)
      visit "/merchant/#{@merchant1.id}/item/#{@item1.id}"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end
  end

  describe "story 8" do 
#     As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
    it "has a link to update information page" do 
      visit "/merchant/#{@merchant1.id}/item/#{@item1.id}"

      expect(page).to have_link("Update Item")
      click_on("Update Item")

      expect(page).to have_current_path("/items/#{@item1.id}/edit")
    end
    it "has a form with existing item attributes" 
    it "can click sumbmit and update the information and go back to the item show page"
    it "displays a flash message stating the information has been succesfully updated"
  end

end