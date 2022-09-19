# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# carly_silo = Merchant.create!(name: "Carly Simon's Candy Silo")
# jewlery_city = Merchant.create!(name: "Jewlery City Merchant")

#   licorice = carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200) 
#   peanut = carly_silo.items.create!(name: "Peanut Bronzinos", description: "Peanut Caramel Chews", unit_price: 1500) 
#   choco_waffle = carly_silo.items.create!(name: "Chocolate Waffles Florentine", description: "Cholately Waffles of Deliciousness", unit_price: 900) 
#   hummus = carly_silo.items.create!(name: "Hummus", description: "Creamy Hummus", unit_price: 1200) 

#   gold_earrings = jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) 
#   silver_necklace = jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) 
#   studded_bracelet = jewlery_city.items.create!(name: "Gold Studded Bracelet", description: "A bracet to make others jealous", unit_price: 2900) 
#   dainty_anklet = jewlery_city.items.create!(name: "Dainty Ankley", description: "An everyday ankley", unit_price: 2299) 
#   stackable_rings = jewlery_city.items.create!(name: "Stackable Gold Rings", description: "Small rings to be mixed and matched", unit_price: 1299) 

#   alaina = Customer.create!(first_name: "Alaina", last_name: "Kneiling")
#   whitney = Customer.create!(first_name: "Whitney", last_name: "Gains")
#   sydney = Customer.create!(first_name: "Sydney", last_name: "Lang")
#   eddie = Customer.create!(first_name: "Eddie", last_name: "Young")
#   ryan = Customer.create!(first_name: "Ryan", last_name: "Vergeront")
#   leah = Customer.create!(first_name: "Leah", last_name: "Anderson")
#   polina = Customer.create!(first_name: "Polina", last_name: "Eisenberg")

#   whitney_invoice1 = whitney.invoices.create!(status: "completed")
#   whitney_invoice2 = whitney.invoices.create!(status: "completed")
#   whitney_invoice3 = whitney.invoices.create!(status: "completed")
#   whitney_invoice4 = whitney.invoices.create!(status: "completed")
#   whitney_invoice5 = whitney.invoices.create!(status: "completed")
#   whitney_invoice6 = whitney.invoices.create!(status: "completed")
#   alaina_invoice1 = alaina.invoices.create!(status: "completed")
#   alaina_invoice2 = alaina.invoices.create!(status: "in_progress")
#   alaina_invoice3 = alaina.invoices.create!(status: "completed")
#   alaina_invoice4 = alaina.invoices.create!(status: "completed")
#   alaina_invoice5 = alaina.invoices.create!(status: "completed")
#   eddie_invoice1 = eddie.invoices.create!(status: "completed")
#   eddie_invoice2 = eddie.invoices.create!(status: "completed")
#   eddie_invoice3 = eddie.invoices.create!(status: "completed")
#   ryan_invoice1 = ryan.invoices.create!(status: "completed")
#   ryan_invoice2 = ryan.invoices.create!(status: "completed")
#   polina_invoice1 = polina.invoices.create!(status: "completed")
#   polina_invoice2 = polina.invoices.create!(status: "cancelled")
#   leah_invoice1 = leah.invoices.create!(status: "cancelled")
#   leah_invoice2 = leah.invoices.create!(status: "in_progress")

#   whitney_invoice1_transaction = whitney_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   whitney_invoice2_transaction = whitney_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   whitney_invoice3_transaction = whitney_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   whitney_invoice4_transaction = whitney_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   whitney_invoice5_transaction = whitney_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   whitney_invoice6_transaction = whitney_invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   alaina_invoice1_transaction = alaina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   alaina_invoice2_transaction = alaina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   alaina_invoice3_transaction = alaina_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   alaina_invoice4_transaction = alaina_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   alaina_invoice5_transaction = alaina_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   eddie_invoice1_transaction = eddie_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   eddie_invoice2_transaction = eddie_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   eddie_invoice3_transaction = eddie_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   polina_invoice1_transaction = polina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   polina_invoice2_transaction = polina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   ryan_invoice1_transaction = ryan_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   ryan_invoice2_transaction = ryan_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   leah_invoice1_transaction = leah_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
#   leah_invoice2_transaction = leah_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")

#   alainainvoice1_itemgold_earrings = InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )
#   alainainvoice2_itemgold_earrings = InvoiceItem.create!(invoice_id: alaina_invoice2.id, item_id: gold_earrings.id, quantity: 40, unit_price: 1500, status:"shipped" )
#   alainainvoice3_itemgold_earrings = InvoiceItem.create!(invoice_id: alaina_invoice3.id, item_id: gold_earrings.id, quantity: 12, unit_price: 1600, status:"shipped" )
#   alainainvoice4_itemgold_earrings = InvoiceItem.create!(invoice_id: alaina_invoice4.id, item_id: gold_earrings.id, quantity: 4, unit_price: 2400, status:"shipped" )
#   alainainvoice5_itemgold_earrings = InvoiceItem.create!(invoice_id: alaina_invoice5.id, item_id: gold_earrings.id, quantity: 243, unit_price: 27000, status:"shipped" )

#   whitneyinvoice1_itemsilver_necklace = InvoiceItem.create!(invoice_id: whitney_invoice1.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )
#   whitneyinvoice2_itemsilver_necklace = InvoiceItem.create!(invoice_id: whitney_invoice2.id, item_id: silver_necklace.id, quantity: 31, unit_price: 270, status:"shipped" )
#   whitneyinvoice3_itemsilver_necklace = InvoiceItem.create!(invoice_id: whitney_invoice3.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )
#   whitneyinvoice4_itemsilver_necklace = InvoiceItem.create!(invoice_id: whitney_invoice4.id, item_id: silver_necklace.id, quantity: 10, unit_price: 270, status:"shipped" )
#   whitneyinvoice5_itemsilver_necklace = InvoiceItem.create!(invoice_id: whitney_invoice5.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )
#   whitneyinvoice6_itemsilver_necklace = InvoiceItem.create!(invoice_id: whitney_invoice6.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )


#   eddie_invoice1_itemstudded_bracelet = InvoiceItem.create!(invoice_id: eddie_invoice1.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2199, status:"shipped" )
#   eddie_invoice2_itemstudded_bracelet = InvoiceItem.create!(invoice_id: eddie_invoice2.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2700, status:"shipped" )
#   eddie_invoice3_itemstudded_bracelet = InvoiceItem.create!(invoice_id: eddie_invoice3.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 10299, status:"shipped" )

#   polina_invoice1_itemstudded_bracelet = InvoiceItem.create!(invoice_id: polina_invoice1.id, item_id: dainty_anklet.id, quantity: 6, unit_price: 270, status:"shipped" )
#   polina_invoice2_itemstudded_bracelet = InvoiceItem.create!(invoice_id: polina_invoice2.id, item_id: dainty_anklet.id, quantity: 1, unit_price: 270, status:"shipped" )
