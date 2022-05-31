# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
    @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 400, description: 'Writes things, but dark.')
    @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 400, description: 'Writes things, but dark, and thicc.')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @invoice_7 = @customer_1.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-27 14:54:09 UTC"))
    @item_2.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 5, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-28 14:54:09 UTC"))
    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

    @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
    @invoice_2 = @customer_2.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-29 14:54:09 UTC"))
    @invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

    @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
    @invoice_3 = @customer_3.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-30 14:54:09 UTC"))
    @invoice_3.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

    @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
    @invoice_4 = @customer_4.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-01 14:54:09 UTC"))
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_5 = Customer.create!(first_name: 'Mark', last_name: 'Brains')
    @invoice_5 = @customer_5.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-02 14:54:09 UTC"))
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
    @invoice_6 = @customer_6.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-03 14:54:09 UTC"))
    @invoice_6.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    merchant = Merchant.create!(name: 'Yeti')
     merchant_2 = Merchant.create!(name: 'Hydroflask')
     item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
     item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
     item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
     item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')

     merchant = Merchant.create!(name: 'Brylan')

      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      invoice_1 = customer_1.invoices.create!(status: 'completed')
      item_1 = merchant.items.create!(name: 'Pencil', unit_price: 1, description: 'Writes things.')
      item_2 = merchant.items.create!(name: 'Eraser', unit_price: 2, description: 'Does things.')
      item_3 = merchant.items.create!(name: 'Pen', unit_price: 3, description: 'Helps things.')
      item_4 = merchant.items.create!(name: 'Calculator', unit_price: 4, description: 'Considers things.')
      item_5 = merchant.items.create!(name: 'Stapler', unit_price: 5, description: 'Wishes things.')
      item_6 = merchant.items.create!(name: 'Computer', unit_price: 6, description: 'Hopes things.')
      item_7 = merchant.items.create!(name: 'Backpack', unit_price: 7, description: 'Forgets things.')
      item_1.invoice_items.create!(invoice_id: invoice_1.id, quantity: 1, unit_price: 4, status: 2)
      item_2.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 5, status: 2)
      item_3.invoice_items.create!(invoice_id: invoice_1.id, quantity: 3, unit_price: 6, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_1.id, quantity: 4, unit_price: 7, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_1.id, quantity: 5, unit_price: 8, status: 2)
      invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')

      customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
      invoice_2 = customer_2.invoices.create!(status: 'completed')
      item_3.invoice_items.create!(invoice_id: invoice_2.id, quantity: 1, unit_price: 4, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_2.id, quantity: 2, unit_price: 5, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_2.id, quantity: 3, unit_price: 6, status: 2)
      item_6.invoice_items.create!(invoice_id: invoice_2.id, quantity: 4, unit_price: 7, status: 2)
      item_7.invoice_items.create!(invoice_id: invoice_2.id, quantity: 5, unit_price: 8, status: 2)
      invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')

      merchant = Merchant.create!(name: 'Brylan')

      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      invoice_1 = customer_1.invoices.create!(status: 'completed')
      item_1 = merchant.items.create!(name: 'Pencil', unit_price: 100, description: 'Writes things.')
      item_2 = merchant.items.create!(name: 'Eraser', unit_price: 200, description: 'Does things.')
      item_3 = merchant.items.create!(name: 'Pen', unit_price: 300, description: 'Helps things.')
      item_4 = merchant.items.create!(name: 'Calculator', unit_price: 400, description: 'Considers things.')
      item_5 = merchant.items.create!(name: 'Stapler', unit_price: 500, description: 'Wishes things.')
      item_6 = merchant.items.create!(name: 'Computer', unit_price: 600, description: 'Hopes things.')
      item_7 = merchant.items.create!(name: 'Backpack', unit_price: 700, description: 'Forgets things.')
      item_1.invoice_items.create!(invoice_id: invoice_1.id, quantity: 1, unit_price: 400, status: 2)
      item_2.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 500, status: 2)
      item_3.invoice_items.create!(invoice_id: invoice_1.id, quantity: 3, unit_price: 600, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_1.id, quantity: 4, unit_price: 700, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_1.id, quantity: 5, unit_price: 800, status: 2)
      invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')

      customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
      invoice_2 = customer_2.invoices.create!(status: 'completed')
      item_3.invoice_items.create!(invoice_id: invoice_2.id, quantity: 1, unit_price: 400, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_2.id, quantity: 2, unit_price: 500, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_2.id, quantity: 3, unit_price: 600, status: 2)
      item_6.invoice_items.create!(invoice_id: invoice_2.id, quantity: 4, unit_price: 700, status: 2)
      item_7.invoice_items.create!(invoice_id: invoice_2.id, quantity: 5, unit_price: 800, status: 2)
      invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')

      merchant = Merchant.create!(name: 'Brylan')

      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      invoice_1 = customer_1.invoices.create!(status: 'completed',
                                   created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                   updated_at: Time.parse('2012-03-27 14:54:09 UTC'))
      item_1 = merchant.items.create!(name: 'Pencil', unit_price: 1, description: 'Writes things.')
      item_1.invoice_items.create!(invoice_id: invoice_1.id, quantity: 4, unit_price: 4, status: 2)
      invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')

      customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
      invoice_2 = customer_2.invoices.create!(status: 'completed',
                                            created_at: Time.parse('2012-03-26 09:54:09 UTC'),
                                            updated_at: Time.parse('2012-03-26 09:54:09 UTC'))
      item_1.invoice_items.create!(invoice_id: invoice_2.id, quantity: 5, unit_price: 4, status: 2)
      invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')

      @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
    @item_2 = @merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
    @invoice_1 = @customer.invoices.create(status: "in progress")
    @invoice_2 = @customer.invoices.create(status: "in progress")
    @invoice_item_1 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 10, status: "packaged")
    @invoice_item_2 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 10, status: "packaged")

    @customer_2 = Customer.create!(first_name: "Illy", last_name: "Jonson")
    @invoice_3 = @customer_2.invoices.create(status: "in progress")
    @invoice_4 = @customer_2.invoices.create(status: "in progress")
    @invoice_item_3 = InvoiceItem.create(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 10, status: "packaged")
    @invoice_item_4 = InvoiceItem.create(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 10, status: "packaged")

    @merchant_2 = Merchant.create!(name: 'Chris')
    @item_3 = @merchant_2.items.create!(name: 'Ball', unit_price: 5, description: 'Fun')
    @customer_3 = Customer.create!(first_name: "Illy", last_name: "Jonson")
    @invoice_5 = @customer_2.invoices.create(status: "in progress")
    @invoice_item_5 = InvoiceItem.create(item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 10, unit_price: 10, status: "packaged")

    @merchant = Merchant.create!(name: 'Brylan')
        @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
        @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 400, description: 'Writes things, but dark.')
        @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 400, description: 'Writes things, but dark, and thicc.')

        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
        @invoice_1 = @customer_1.invoices.create!(status: 'completed')
        @invoice_7 = @customer_1.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-03-27 14:54:09 UTC"))
        @item_2.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 5, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-03-28 14:54:09 UTC"))
        @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
        @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

        @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
        @invoice_2 = @customer_2.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-03-29 14:54:09 UTC"))
        @invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
        @invoice_2.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
        @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
        @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
        @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

        @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
        @invoice_3 = @customer_3.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-03-30 14:54:09 UTC"))
        @invoice_3.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
        @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
        @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
        @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

        @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
        @invoice_4 = @customer_4.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-04-01 14:54:09 UTC"))
        @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
        @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
        @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

        @customer_5 = Customer.create!(first_name: 'Mark', last_name: 'Brains')
        @invoice_5 = @customer_5.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-04-02 14:54:09 UTC"))
        @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
        @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

        @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
        @invoice_6 = @customer_6.invoices.create!(status: 'completed')
        @item_1.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                           created_at: Time.parse("2012-04-03 14:54:09 UTC"))
        @invoice_6.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

        customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
              invoice_1 = customer.invoices.create(status: "in progress")
              invoice_2 = customer.invoices.create(status: "in progress")
              invoice_3 = customer.invoices.create(status: "in progress")


              merchant_1 = Merchant.create!(name: 'Brylan', status: 1)
                    merchant_2 = Merchant.create!(name: 'Antonio', status: 1)
                    merchant_3 = Merchant.create!(name: 'Chris', status: 1)
                    merchant_4 = Merchant.create!(name: 'Craig', status: 1)

                    customer = Customer.create!(first_name: 'Ralph', last_name: 'Jones')

                            #merchant_1 total revenue: $25.00
                            merchant_1 = Merchant.create!(name: 'Brylan')
                            item_1 = merchant_1.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
                            invoice_1 = customer.invoices.create!(status: 'completed')
                            invoice_1.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_1.invoice_items.create!(item_id: item_1.id, unit_price: 500, quantity: 5, status: 'shipped')

                            #merchant_2 total revenue: $50.00
                            merchant_2 = Merchant.create!(name: 'Chris')
                            item_2 = merchant_2.items.create!(name: 'Marker', unit_price: 500, description: 'Writes things, but dark, and thicc.')
                            invoice_2 = customer.invoices.create!(status: 'completed')
                            invoice_2a = customer.invoices.create!(status: 'completed')
                            invoice_2.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_2a.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_2.invoice_items.create!(item_id: item_2.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_2a.invoice_items.create!(item_id: item_2.id, unit_price: 500, quantity: 5, status: 'shipped')

                            #merchant_3 total revenue: $75.00
                            merchant_3 = Merchant.create!(name: 'Antonio')
                            item_3 = merchant_3.items.create!(name: 'Marker', unit_price: 500, description: 'Writes things, but dark, and thicc.')
                            invoice_3 = customer.invoices.create!(status: 'completed')
                            invoice_3a = customer.invoices.create!(status: 'completed')
                            invoice_3b = customer.invoices.create!(status: 'completed')
                            invoice_3.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_3a.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_3b.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_3.invoice_items.create!(item_id: item_3.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_3a.invoice_items.create!(item_id: item_3.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_3b.invoice_items.create!(item_id: item_3.id, unit_price: 500, quantity: 5, status: 'shipped')

                            #merchant_4 total revenue: $100.00
                            merchant_4 = Merchant.create!(name: 'Craig')
                            item_4 = merchant_4.items.create!(name: 'Marker', unit_price: 500, description: 'Writes things, but dark, and thicc.')
                            invoice_4 = customer.invoices.create!(status: 'completed')
                            invoice_4a = customer.invoices.create!(status: 'completed')
                            invoice_4b = customer.invoices.create!(status: 'completed')
                            invoice_4c = customer.invoices.create!(status: 'completed')
                            invoice_4.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_4a.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_4b.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_4c.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_4.invoice_items.create!(item_id: item_4.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_4a.invoice_items.create!(item_id: item_4.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_4b.invoice_items.create!(item_id: item_4.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_4c.invoice_items.create!(item_id: item_4.id, unit_price: 500, quantity: 5, status: 'shipped')

                            #merchant_5 total revenue: $125.00
                            merchant_5 = Merchant.create!(name: 'Hubert')
                            item_5 = merchant_5.items.create!(name: 'Marker', unit_price: 500, description: 'Writes things, but dark, and thicc.')
                            invoice_5 = customer.invoices.create!(status: 'completed')
                            invoice_5a = customer.invoices.create!(status: 'completed')
                            invoice_5b = customer.invoices.create!(status: 'completed')
                            invoice_5c = customer.invoices.create!(status: 'completed')
                            invoice_5d = customer.invoices.create!(status: 'completed')
                            invoice_5.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_5a.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_5b.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_5c.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_5d.transactions.create!(credit_card_number: '898989', result: 'success')
                            invoice_5.invoice_items.create!(item_id: item_5.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_5a.invoice_items.create!(item_id: item_5.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_5b.invoice_items.create!(item_id: item_5.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_5c.invoice_items.create!(item_id: item_5.id, unit_price: 500, quantity: 5, status: 'shipped')
                            invoice_5d.invoice_items.create!(item_id: item_5.id, unit_price: 500, quantity: 5, status: 'shipped')

                            #this merchant has a failed transaction, 0 revenue
                            merchant_failed = Merchant.create!(name: 'Chungus')
                            item_6 = merchant_failed.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
                            invoice_6 = customer.invoices.create!(status: 'completed')
                            invoice_6.transactions.create!(credit_card_number: '898989', result: 'failed')
                            invoice_6.invoice_items.create!(item_id: item_6.id, unit_price: 500, quantity: 5, status: 'packaged')
