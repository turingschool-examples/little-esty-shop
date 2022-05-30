# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@merch_1 = Merchant.create!(name: "Two-Legs Fashion")

@item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
@item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
@item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
@item_4 = @merch_1.items.create!(name: "Double Legged Pant", description: "pants built for people with two legs", unit_price: 50000)
@item_5 = @merch_1.items.create!(name: "Stainless Steel, 5-Pocket Jean", description: "Shorts of Steel", unit_price: 3000000)
@item_6 = @merch_1.items.create!(name: "String of Numbers", description: "54921752964273", unit_price: 100)

@cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
@cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
@cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
@cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
@cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
@cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")
@cust_7 = Customer.create!(first_name: "Anten", last_name: "Branden")

@invoice_1 = @cust_1.invoices.create!(status: 1)
@invoice_2 = @cust_1.invoices.create!(status: 1)
@invoice_3 = @cust_1.invoices.create!(status: 1)
@invoice_4 = @cust_2.invoices.create!(status: 1)
@invoice_5 = @cust_2.invoices.create!(status: 1)
@invoice_6 = @cust_2.invoices.create!(status: 1)
@invoice_7 = @cust_3.invoices.create!(status: 1)
@invoice_8 = @cust_3.invoices.create!(status: 1)
@invoice_9 = @cust_4.invoices.create!(status: 1)
@invoice_10 = @cust_4.invoices.create!(status: 1)
@invoice_11 = @cust_5.invoices.create!(status: 1)
@invoice_12 = @cust_5.invoices.create!(status: 1)
@invoice_13 = @cust_6.invoices.create!(status: 1)
@invoice_14 = @cust_7.invoices.create!(status: 1)
@invoice_15 = @cust_7.invoices.create!(status: 2)

@ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_6 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_7 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_8 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_9 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_10 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_10.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)

@ii_11 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_12 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_12.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_13 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_13.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
@ii_14 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_14.id, quantity: 500, unit_price: @item_4.unit_price, status: 2)
@ii_15 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_14.id, quantity: 1, unit_price: @item_4.unit_price, status: 2)
@ii_16 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_1.unit_price, status: 2)
@ii_17 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_2.unit_price, status: 2)
@ii_18 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_3.unit_price, status: 2)
@ii_19 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_15.id, quantity: 700, unit_price: @item_4.unit_price, status: 0)

@transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4039485738495837, result: "success")
@transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4039485738495837, result: "success")
@transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4039485738495837, result: "success")
@transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4847583748374837, result: "success")
@transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4847583748374837, result: "success")
@transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4847583748374837, result: "success")
@transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4364756374652636, result: "success")
@transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4364756374652636, result: "success")
@transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4928294837461125, result: "success")
@transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4928294837461125, result: "success")
@transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4738473664751832, result: "success")
@transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4738473664751832, result: "success")
@transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4023948573948293, result: "success")
@transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4023948573948293, result: "success")
@transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4023948573948293, result: "success")

@merchant_1 = Merchant.create!(
  name: "Store Store",
  created_at: Date.current,
  updated_at: Date.current
)
@soccer = @merchant_1.items.create!(
  name: "Soccer Ball",
  description: "A ball of pure soccer.",
  unit_price: 32000,
  created_at: Date.current,
  updated_at: Date.current
)
@customer_1 = Customer.create!(
  first_name: "Malcolm",
  last_name: "Jordan",
  created_at: Date.current,
  updated_at: Date.current
)
@invoice_1 = @customer_1.invoices.create!(
  status: 1,
  created_at: Date.new(2020,12,12),
  updated_at: Date.current
)
@invoice_2 = @customer_1.invoices.create!(
  status: 1,
  created_at: Date.new(2020,12,12),
  updated_at: Date.current
)
@invoice_3 = @customer_1.invoices.create!(
  status: 1,
  created_at: Date.new(1999,12,12),
  updated_at: Date.current
)
@invoice_4 = @customer_1.invoices.create!(
  status: 1,
  created_at: Date.new(2022,12,12),
  updated_at: Date.current
)
@invoice_item_1 = InvoiceItem.create!(
  item_id: @soccer.id,
  invoice_id: @invoice_1.id,
  quantity: 1,
  unit_price: @soccer.unit_price,
  status: 0,
  created_at: Date.current,
  updated_at: Date.current
)
 @invoice_item_2 = InvoiceItem.create!(
  item_id: @soccer.id,
  invoice_id: @invoice_4.id,
  quantity: 50,
  unit_price: @soccer.unit_price,
  status: 1,
  created_at: Date.current,
  updated_at: Date.current
)
@invoice_item_3 = InvoiceItem.create!(
  item_id: @soccer.id,
  invoice_id: @invoice_3.id,
  quantity: 1,
  unit_price: @soccer.unit_price,
  status: 1,
  created_at: Date.current,
  updated_at: Date.current
)
 @invoice_item_4 = InvoiceItem.create!(
  item_id: @soccer.id,
  invoice_id: @invoice_2.id,
  quantity: 50,
  unit_price: @soccer.unit_price,
  status: 2,
  created_at: Date.current,
  updated_at: Date.current
)
