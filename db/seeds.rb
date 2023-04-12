# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Transaction.destroy_all
Invoice.destroy_all
Customer.destroy_all
Item.destroy_all
Merchant.destroy_all

@merchant_1 = Merchant.create!(name: 'Etsy')
@merchant_2 = Merchant.create!(name: 'Build-a-Bear')
@item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
@item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
@item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
@item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
@item_5 = @merchant_2.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 50)
@customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
@customer_2 = Customer.create!(first_name: 'Jan', last_name: 'Jones')
@customer_3 = Customer.create!(first_name: 'Jin', last_name: 'Jones')
@customer_4 = Customer.create!(first_name: 'Joon', last_name: 'Jones')
@customer_5 = Customer.create!(first_name: 'Joc', last_name: 'Jones')
@customer_6 = Customer.create!(first_name: 'JakJak', last_name: 'Jones')
@invoice_1 = @customer_1.invoices.create!(status: 'completed')
@transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_2 = @customer_2.invoices.create!(status: 'completed')
@transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_3 = @customer_2.invoices.create!(status: 'completed')
@transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_4 = @customer_3.invoices.create!(status: 'completed')
@transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_5 = @customer_3.invoices.create!(status: 'completed')
@transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_6 = @customer_6.invoices.create!(status: 'completed')
@transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_7 = @customer_5.invoices.create!(status: 'completed')
@transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_8 = @customer_4.invoices.create!(status: 'completed')
@transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_9 = @customer_4.invoices.create!(status: 'completed')
@transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_10 = @customer_5.invoices.create!(status: 'completed')
@transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')
@invoice_11 = @customer_6.invoices.create!(status: 'completed')
@transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: '2012-03-27', result: 'success')