require 'rails_helper'

RSpec.describe 'Admin Merchant Show', type: :feature do
  # let blocks
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
  let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Peanut Caramel Chews", unit_price: 1500) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Cholately Waffles of Deliciousness", unit_price: 900) }
  let!(:hummus) { carly.items.create!(name: "Hummus", description: "Creamy Hummus", unit_price: 1200) }

  let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
  let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
  let!(:studded_bracelet) { jewlery_city.items.create!(name: "Gold Studded Bracelet", description: "A bracet to make others jealous", unit_price: 2900) }
  let!(:dainty_anklet) { jewlery_city.items.create!(name: "Dainty Ankley", description: "An everyday ankley", unit_price: 2299) }
  let!(:stackable_rings) { jewlery_city.items.create!(name: "Stackable Gold Rings", description: "Small rings to be mixed and matched", unit_price: 1299) }

  let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
  let!(:whitney) { Customer.create!(first_name: "Whitney", last_name: "Gains")}
  let!(:sydney) { Customer.create!(first_name: "Sydney", last_name: "Lang")}
  let!(:eddie) { Customer.create!(first_name: "Eddie", last_name: "Young")}
  let!(:ryan) { Customer.create!(first_name: "Ryan", last_name: "Vergeront")}
  let!(:leah) { Customer.create!(first_name: "Leah", last_name: "Anderson")}
  let!(:polina) { Customer.create!(first_name: "Polina", last_name: "Eisenberg")}

  let!(:whitney_invoice1) { whitney.invoices.create!(status: "completed")}
  let!(:whitney_invoice2) { whitney.invoices.create!(status: "completed")}
  let!(:whitney_invoice3) { whitney.invoices.create!(status: "completed")}
  let!(:whitney_invoice4) { whitney.invoices.create!(status: "completed")}
  let!(:whitney_invoice5) { whitney.invoices.create!(status: "completed")}
  let!(:whitney_invoice6) { whitney.invoices.create!(status: "completed")}
  let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}
  let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}
  let!(:alaina_invoice3) { alaina.invoices.create!(status: "completed")}
  let!(:alaina_invoice4) { alaina.invoices.create!(status: "completed")}
  let!(:alaina_invoice5) { alaina.invoices.create!(status: "completed")}
  let!(:eddie_invoice1) { eddie.invoices.create!(status: "completed")}
  let!(:eddie_invoice2) { eddie.invoices.create!(status: "completed")}
  let!(:eddie_invoice3) { eddie.invoices.create!(status: "completed")}
  let!(:ryan_invoice1) { ryan.invoices.create!(status: "completed")}
  let!(:ryan_invoice2) { ryan.invoices.create!(status: "completed")}
  let!(:polina_invoice1) { polina.invoices.create!(status: "completed")}
  let!(:polina_invoice2) { polina.invoices.create!(status: "cancelled")}
  let!(:leah_invoice1) { leah.invoices.create!(status: "cancelled")}
  let!(:leah_invoice2) { leah.invoices.create!(status: "in_progress")}

  let!(:whitney_invoice1_transaction) { whitney_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice2_transaction) { whitney_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice3_transaction) { whitney_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice4_transaction) { whitney_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice5_transaction) { whitney_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice6_transaction) { whitney_invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice1_transaction) { alaina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice2_transaction) { alaina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice3_transaction) { alaina_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice4_transaction) { alaina_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice5_transaction) { alaina_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:eddie_invoice1_transaction) { eddie_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:eddie_invoice2_transaction) { eddie_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:eddie_invoice3_transaction) { eddie_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:polina_invoice1_transaction) { polina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:polina_invoice2_transaction) { polina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:ryan_invoice1_transaction) { ryan_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:ryan_invoice2_transaction) { ryan_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed")}
  let!(:leah_invoice1_transaction) { leah_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed")}
  let!(:leah_invoice2_transaction) { leah_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed")}

  let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
  let!(:alainainvoice2_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice2.id, item_id: gold_earrings.id, quantity: 40, unit_price: 1500, status:"shipped" )}
  let!(:alainainvoice3_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice3.id, item_id: gold_earrings.id, quantity: 12, unit_price: 1600, status:"shipped" )}
  let!(:alainainvoice4_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice4.id, item_id: gold_earrings.id, quantity: 4, unit_price: 2400, status:"shipped" )}
  let!(:alainainvoice5_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice5.id, item_id: gold_earrings.id, quantity: 243, unit_price: 27000, status:"shipped" )}

  let!(:whitneyinvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice1.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice2_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice2.id, item_id: silver_necklace.id, quantity: 31, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice3_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice3.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice4_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice4.id, item_id: silver_necklace.id, quantity: 10, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice5_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice5.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice6_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice6.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )}


  let!(:eddie_invoice1_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice1.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2199, status:"shipped" )}
  let!(:eddie_invoice2_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice2.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2700, status:"shipped" )}
  let!(:eddie_invoice3_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice3.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 10299, status:"shipped" )}

  let!(:polina_invoice1_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: polina_invoice1.id, item_id: dainty_anklet.id, quantity: 6, unit_price: 270, status:"shipped" )}
  let!(:polina_invoice2_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: polina_invoice2.id, item_id: dainty_anklet.id, quantity: 1, unit_price: 270, status:"shipped" )}
  
  describe 'As an admin, when I visit admin merchants show' do
    before(:each) do
      visit admin_merchant_path(carly)
    end

    it 'shows the name the right merchant' do
      within "#merchant-name" do
        expect(page).to have_content(carly.name)
      end
    end

    describe 'it has a link to update merchants information' do 
      it 'when I click the link then I am taken to a page to edit this merchant' do
        expect(page).to have_link("Update Merchant")
        click_on "Update Merchant"
        expect(current_path).to eq("/admin/merchants/#{carly.id}/edit")
      end
    end
  end
end