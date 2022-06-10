
InvoiceItem.destroy_all
Item.destroy_all
BulkDiscount.destroy_all
Merchant.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Customer.destroy_all
#
merchant1 = Merchant.create(name: "Largo" )
merchant2 = Merchant.create(name: "Dok-Ondar" )
merchant3 = Merchant.create(name: "Sylvestri Yarrow" )
merchant4 = Merchant.create(name: "Mungo Baobab" )
merchant5 = Merchant.create(name: "Chancey Yarrow" )
merchant6 = Merchant.create(name: "W. Wald" )


customer1 = Customer.create(first_name: 'Luke', last_name: 'Skywalker')
customer2 = Customer.create(first_name: 'Padme', last_name: 'Amidala')
customer3 = Customer.create(first_name: 'Boba', last_name: 'Fett')
customer4 = Customer.create(first_name: 'Baby', last_name: 'Yoda')
customer5 = Customer.create(first_name: 'Darth', last_name: 'Vader')
customer6 = Customer.create(first_name: 'Obi', last_name: 'Wan Kenobi')

item1 = Item.create(name: "Lightsaber", description: "Will burn flesh" , unit_price: 10000, status: 1, merchant_id: merchant1.id )
item2 = Item.create(name: "Pistol" , description: "It shoots pew pew" , unit_price: 20000 , status: 1, merchant_id: merchant2.id )
item3 = Item.create(name: "Baby Yoda Carriage", description: "It carries the baby", unit_price: 30000, status: 1, merchant_id: merchant3.id )
item4 = Item.create(name: 'Shoes', description: 'You wear them', unit_price: 20000, status: 1, merchant_id: merchant4.id )
item5 = Item.create(name: 'Jetpack', description: "Flllllllyyyy" , unit_price: 30000, status: 1, merchant_id: merchant5.id )
item6 = Item.create(name: 'Storm Trooper Helmet', description: 'You wish you can see', unit_price: 10000, status: 1, merchant_id: merchant6.id )


bulk_discount1 = BulkDiscount.create(threshold: 10, discount_percentage: 20, merchant_id: merchant1.id)
bulk_discount2 = BulkDiscount.create(threshold: 15, discount_percentage: 15, merchant_id: merchant1.id )
bulk_discount3 = BulkDiscount.create(threshold: 15, discount_percentage: 30, merchant_id: merchant2.id)

invoice1 = Invoice.create(customer_id: customer1.id, created_at: "2012-03-10 00:54:09 UTC")
invoice2 = Invoice.create(customer_id: customer2.id, created_at: "2013-03-10 00:54:09 UTC")
invoice3 = Invoice.create(customer_id: customer3.id, created_at: "2014-03-10 00:54:09 UTC")
invoice4 = Invoice.create(customer_id: customer4.id, created_at: "2014-03-10 00:54:09 UTC")
invoice5 = Invoice.create(customer_id: customer5.id, created_at: "2014-03-10 00:54:09 UTC")
invoice6 = Invoice.create(customer_id: customer6.id, created_at: "2014-03-10 00:54:09 UTC")

transaction1 = Transaction.create(credit_card_number: 1234567891234567 , invoice_id: invoice1.id, result: 0)
transaction2 = Transaction.create(credit_card_number: 8473628405085728 , invoice_id: invoice1.id, result: 0)
transaction3 = Transaction.create(credit_card_number: 1723648234978178 , invoice_id: invoice2.id, result: 1)
transaction4 = Transaction.create(credit_card_number: 1287457641238021 , invoice_id: invoice2.id, result: 0)
transaction5 = Transaction.create(credit_card_number: 9492190573475643 , invoice_id: invoice3.id, result: 1)
transaction6 = Transaction.create(credit_card_number: 9248398023747473 , invoice_id: invoice3.id, result: 1)
transaction7 = Transaction.create(credit_card_number: 8457893895734857 , invoice_id: invoice4.id, result: 0)
transaction8 = Transaction.create(credit_card_number: 8347593203485853 , invoice_id: invoice5.id, result: 0)
transaction9 = Transaction.create(credit_card_number: 9834578092034598 , invoice_id: invoice6.id, result: 0)
transaction10 = Transaction.create(credit_card_number: 9438593485983458 , invoice_id: invoice6.id, result: 0)
transaction11 = Transaction.create(credit_card_number: 2380921389472427 , invoice_id: invoice6.id, result: 0)

invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 100, status: 2)
invoice_item2 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice3.id, quantity: 6, unit_price: 4, status: 1)
invoice_item3 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice1.id, quantity: 3, unit_price: 200, status: 0)
invoice_item4 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 22, unit_price: 200, status: 2)
invoice_item5 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 5, unit_price: 300, status: 1)
invoice_item6 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice1.id, quantity: 63, unit_price: 400, status: 0)
invoice_item7 = InvoiceItem.create(item_id: item4.id, invoice_id: invoice2.id, quantity: 16, unit_price: 500, status: 2)
invoice_item8 = InvoiceItem.create(item_id: item4.id, invoice_id: invoice3.id, quantity: 1, unit_price: 500, status: 1)
invoice_item9 = InvoiceItem.create(item_id: item5.id, invoice_id: invoice2.id, quantity: 2, unit_price: 500, status: 0)
invoice_item10 = InvoiceItem.create(item_id: item5.id, invoice_id: invoice1.id, quantity: 7, unit_price: 200, status: 2)
invoice_item11 = InvoiceItem.create(item_id: item6.id, invoice_id: invoice3.id, quantity: 1, unit_price: 100, status: 1)
invoice_item12 = InvoiceItem.create(item_id: item6.id, invoice_id: invoice3.id, quantity: 1, unit_price: 250, status: 0)
invoice_item13 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice1.id, quantity: 0, unit_price: 0, status: 0)
invoice_item14 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice2.id, quantity: 0, unit_price: 0, status: 1)
invoice_item15 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 0, unit_price: 0, status: 1)
invoice_item16 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice4.id, quantity: 0, unit_price: 0, status: 0)
invoice_item17 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice5.id, quantity: 0, unit_price: 0, status: 0)
invoice_item18 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice6.id, quantity: 0, unit_price: 0, status: 1)
