# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
merch_1 = Merchant.create!(name: "Shop Here")

    item_1 = Item.create!(name:"jumprope", description:"Pink and sparkly.", unit_price:600, merchant_id:"#{merch_1.id}")
    item_2 = Item.create!(name:"hula hoop", description:"Get your groove on!", unit_price:700, merchant_id:"#{merch_1.id}")
    
    cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")
    
    invoice_1 = Invoice.create!(customer_id:"#{cust_1.id}", status:1)
    invoice_2 = Invoice.create!(customer_id:"#{cust_1.id}", status:1)
    invoice_3 = Invoice.create!(customer_id:"#{cust_1.id}", status:1)
        
    invoice_item_1 = InvoiceItem.create!(invoice_id:"#{invoice_1.id}", item_id:"#{item_1.id}", status: 2, quantity:1, unit_price:600)
    invoice_item_2 = InvoiceItem.create!(invoice_id:"#{invoice_2.id}", item_id:"#{item_2.id}", status: 2, quantity:1, unit_price:700)
    invoice_item_3 = InvoiceItem.create!(invoice_id:"#{invoice_3.id}", item_id:"#{item_2.id}", status: 2, quantity:1, unit_price:700)
