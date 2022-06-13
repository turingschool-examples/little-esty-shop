# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BulkDiscount.destroy_all
InvoiceItem.destroy_all
Item.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Merchant.destroy_all
Customer.destroy_all

@merchant1 = Merchant.create!(name: 'Suzy Hernandez')
@merchant2 = Merchant.create!(name: 'Juan Lopez')

@five = BulkDiscount.create!(name: 'Five', percent_discount: 0.05, quantity_threshold: 5, merchant_id: @merchant1.id)
@ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
@fifteen = BulkDiscount.create!(name: 'Fifteen', percent_discount: 0.15, quantity_threshold: 15,
                                merchant_id: @merchant1.id)
@fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50, merchant_id: @merchant1.id)

@six = BulkDiscount.create!(name: 'Six', percent_discount: 0.06, quantity_threshold: 6, merchant_id: @merchant2.id)
@eleven = BulkDiscount.create!(name: 'Eleven', percent_discount: 0.11, quantity_threshold: 11,
                               merchant_id: @merchant2.id)
@sixteen = BulkDiscount.create!(name: 'Sixteen', percent_discount: 0.16, quantity_threshold: 16,
                                merchant_id: @merchant2.id)
@fifty_one = BulkDiscount.create!(name: 'Fifty One', percent_discount: 0.51, quantity_threshold: 51,
                                  merchant_id: @merchant2.id)

@item1 = @merchant2.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400, item_status: 1)
@item2 = @merchant2.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
@item3 = @merchant2.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
@item4 = @merchant2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000, item_status: 1)
@item5 = @merchant2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
@item6 = @merchant2.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
@item7 = @merchant2.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405, item_status: 1)
@item8 = @merchant2.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)

@item9 = @merchant1.items.create!(name: 'cheese1', description: 'americancheese', unit_price: 2400, item_status: 1)
@item10 = @merchant1.items.create!(name: 'onion1', description: 'white onion', unit_price: 3450, item_status: 1)
@item11 = @merchant1.items.create!(name: 'earing1', description: 'long earings', unit_price: 2375)
@item12 = @merchant1.items.create!(name: 'bracelet1', description: 'pink bracelet', unit_price: 1908, item_status: 1)
@item13 = @merchant1.items.create!(name: 'ring1', description: 'flower ring', unit_price: 2345)
@item14 = @merchant1.items.create!(name: 'skirt1', description: 'Top skirt', unit_price: 2175, item_status: 1)
@item15 = @merchant1.items.create!(name: 'shirt1', description: "Tz's Yellow Shirt", unit_price: 5405, item_status: 1)
@item16 = @merchant1.items.create!(name: 'socks1', description: 'Dog Socks', unit_price: 934)

@customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
@customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
@customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
@customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
@customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
@customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')
@customer7 = Customer.create!(first_name: 'Sue', last_name: 'Pine')
@customer8 = Customer.create!(first_name: 'Laughs', last_name: 'Apples')
@customer9 = Customer.create!(first_name: 'Joe', last_name: 'Sticky')
@customer10 = Customer.create!(first_name: 'Sneezes', last_name: 'Yellow')

@invoice1 = Invoice.create!(status: 2, customer_id: @customer1.id)
@invoice2 = Invoice.create!(status: 2, customer_id: @customer2.id)
@invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
@invoice4 = Invoice.create!(status: 0, customer_id: @customer4.id)
@invoice5 = Invoice.create!(status: 2, customer_id: @customer4.id)
@invoice6 = Invoice.create!(status: 2, customer_id: @customer5.id)
@invoice7 = Invoice.create!(status: 2, customer_id: @customer6.id)
@invoice8 = Invoice.create!(status: 2, customer_id: @customer7.id)
@invoice9 = Invoice.create!(status: 2, customer_id: @customer7.id)
@invoice10 = Invoice.create!(status: 2, customer_id: @customer8.id)
@invoice11 = Invoice.create!(status: 2, customer_id: @customer8.id)
@invoice12 = Invoice.create!(status: 1, customer_id: @customer9.id)
@invoice13 = Invoice.create!(status: 2, customer_id: @customer1.id)
@invoice14 = Invoice.create!(status: 2, customer_id: @customer3.id)
@invoice15 = Invoice.create!(status: 2, customer_id: @customer7.id)
@invoice16 = Invoice.create!(status: 0, customer_id: @customer10.id)

@invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 6, unit_price: 2400,
                                     status: 1)
@invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 12, unit_price: 3450,
                                     status: 0)
@invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 14_500,
                                     status: 2)
@invoice_item4 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 5405,
                                     status: 2)
@invoice_item5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 14_500,
                                     status: 2)
@invoice_item6 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice6.id, quantity: 7, unit_price: 76_000,
                                     status: 2)
@invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                     status: 2)
@invoice_item8 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice1.id, quantity: 25, unit_price: 934,
                                     status: 2)
@invoice_item9 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 21, unit_price: 3450,
                                     status: 2)
@invoice_item10 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 76_000,
                                      status: 2)
@invoice_item11 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 6, unit_price: 2400,
                                      status: 2)
@invoice_item12 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 11, unit_price: 2345,
                                      status: 2)
@invoice_item13 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 5, unit_price: 2175,
                                      status: 2)
@invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 57, unit_price: 934,
                                      status: 2)
@invoice_item15 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 2400,
                                      status: 2)
@invoice_item16 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 5405,
                                      status: 2)
@invoice_item17 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 8, unit_price: 2175,
                                      status: 2)
@invoice_item18 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2345,
                                      status: 2)

@invoice_item19 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 76_000,
                                      status: 2)
@invoice_item20 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice11.id, quantity: 11, unit_price: 2375,
                                      status: 2)
@invoice_item21 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice7.id, quantity: 23, unit_price: 2345,
                                      status: 2)
@invoice_item22 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 934,
                                      status: 2)
@invoice_item23 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 3450,
                                      status: 2)
@invoice_item24 = InvoiceItem.create!(item_id: @item14.id, invoice_id: @invoice7.id, quantity: 6, unit_price: 2175,
                                      status: 2)
@invoice_item25 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice8.id, quantity: 2, unit_price: 2400,
                                      status: 2)
@invoice_item26 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice16.id, quantity: 2, unit_price: 1908,
                                      status: 2)
@invoice_item27 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice9.id, quantity: 34, unit_price: 2375,
                                      status: 2)
@invoice_item28 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 5405,
                                      status: 2)
@invoice_item29 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice10.id, quantity: 53, unit_price: 934,
                                      status: 2)
@invoice_item30 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 2400,
                                      status: 2)
@invoice_item31 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice11.id, quantity: 2, unit_price: 934,
                                      status: 2)
@invoice_item32 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice12.id, quantity: 22, unit_price: 1908,
                                      status: 2)
@invoice_item33 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice13.id, quantity: 2, unit_price: 2375,
                                      status: 2)
@invoice_item34 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice14.id, quantity: 17, unit_price: 3450,
                                      status: 2)
@invoice_item35 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice15.id, quantity: 2, unit_price: 2345,
                                      status: 2)
@invoice_item36 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice16.id, quantity: 2, unit_price: 5405,
                                      status: 2)
@invoice_item37 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice16.id, quantity: 2, unit_price: 3450,
                                      status: 2)
@invoice_item38 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice9.id, quantity: 57, unit_price: 934,
                                      status: 2)

@transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
@transaction2 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
@transaction3 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
@transaction4 = Transaction.create!(result: 1, invoice_id: @invoice3.id)
@transaction5 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
@transaction6 = Transaction.create!(result: 0, invoice_id: @invoice5.id)
@transaction7 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
@transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice7.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice8.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice9.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice10.id)
@transaction8 = Transaction.create!(result: 1, invoice_id: @invoice11.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice12.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice13.id)
@transaction8 = Transaction.create!(result: 1, invoice_id: @invoice14.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice14.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice15.id)
@transaction8 = Transaction.create!(result: 0, invoice_id: @invoice16.id)
