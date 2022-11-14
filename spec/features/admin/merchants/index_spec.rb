require "rails_helper"

RSpec.describe("admin merchants index page") do
  before(:each) do
    feb_third = DateTime.new(2022, 2, 3, 4, 5, 6)
    march_third = DateTime.new(2022, 3, 3, 6, 2, 3)
    april_first = DateTime.new(2022, 4, 1, 8, 9, 6)

    ####BREAK
    @merchant1 = Merchant.create!(    name: "Tokyos Tractors")
    @item1 = @merchant1.items.create!(    name: "A",     description: "Alpha",     unit_price: 2)
    @item2 = @merchant1.items.create!(    name: "B",     description: "Bravo",     unit_price: 2)
    @item3 = @merchant1.items.create!(    name: "C",     description: "Charlie",     unit_price: 3)
    @cx1 = Customer.create!(    first_name: "Tapanga",     last_name: "Toloza")
    @invoice_1 = @cx1.invoices.create!(    status: 1,     created_at: feb_third)
    @invoice_2 = @cx1.invoices.create!(    status: 1,     created_at: march_third)
    InvoiceItem.create!(    invoice: @invoice_1,     item: @item1,     quantity: 1,     unit_price: 2,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_2,     item: @item2,     quantity: 1,     unit_price: 2,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_2,     item: @item3,     quantity: 1,     unit_price: 3,     status: 2)
    @invoice_1.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")
    @invoice_2.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")

    ###LINE BREAK
    @merchant2 = Merchant.create!(    name: "Oslos Outdoor Market")
    @item4 = @merchant2.items.create!(    name: "D",     description: "Delta",     unit_price: 4)
    @item5 = @merchant2.items.create!(    name: "E",     description: "Echo",     unit_price: 5)
    @item6 = @merchant2.items.create!(    name: "F",     description: "Fox",     unit_price: 6)
    @cx2 = Customer.create!(    first_name: "Ocsar",     last_name: "Oreily")
    @invoice_3 = @cx2.invoices.create!(    status: 1,     created_at: april_first)
    InvoiceItem.create!(    invoice: @invoice_3,     item: @item4,     quantity: 1,     unit_price: 3,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_3,     item: @item5,     quantity: 1,     unit_price: 4,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_3,     item: @item6,     quantity: 1,     unit_price: 5,     status: 2)
    @invoice_3.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")

      ###LINE BREAK
    @merchant3 = Merchant.create!(    name: "Berlins Building Supply")
    @item7 = @merchant3.items.create!(    name: "G",     description: "Golf",     unit_price: 7)
    @item8 = @merchant3.items.create!(    name: "H",     description: "Hotel",     unit_price: 8)
    @item9 = @merchant3.items.create!(    name: "I",     description: "India",     unit_price: 9)
    @cx3 = Customer.create!(    first_name: "Bruce",     last_name: "Banner")
    @invoice_4 = @cx3.invoices.create!(    status: 1,     created_at: march_third)
    @invoice_5 = @cx3.invoices.create!(    status: 1,     created_at: feb_third)
    InvoiceItem.create!(    invoice: @invoice_4,     item: @item7,     quantity: 1,     unit_price: 4,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_4,     item: @item8,     quantity: 1,     unit_price: 5,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_5,     item: @item9,     quantity: 1,     unit_price: 6,     status: 2)
    @invoice_4.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")
    @invoice_5.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")

      ###LINE BREAK
    @merchant4 = Merchant.create!(    name: "Rios Radios")
    @item10 = @merchant4.items.create!(    name: "J",     description: "Juliet",     unit_price: 10)
    @item11 = @merchant4.items.create!(    name: "K",     description: "Kilo",     unit_price: 11)
    @item12 = @merchant4.items.create!(    name: "L",     description: "lima",     unit_price: 12)
    @cx4 = Customer.create!(    first_name: "Roy",     last_name: "Rodriguez")
    @invoice_6 = @cx4.invoices.create!(    status: 1,     created_at: feb_third)
    @invoice_7 = @cx4.invoices.create!(    status: 1,     created_at: march_third)
    InvoiceItem.create!(    invoice: @invoice_6,     item: @item10,     quantity: 1,     unit_price: 7,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_6,     item: @item11,     quantity: 1,     unit_price: 8,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_7,     item: @item12,     quantity: 1,     unit_price: 9,     status: 0)
    @invoice_6.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")
    @invoice_7.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")

      ###LINE BREAK
    @merchant5 = Merchant.create!(    name: "Moscows Mechanics")
    @item13 = @merchant5.items.create!(    name: "M",     description: "Mike",     unit_price: 13)
    @item14 = @merchant5.items.create!(    name: "N",     description: "November",     unit_price: 14)
    @item15 = @merchant5.items.create!(    name: "O",     description: "Oscar",     unit_price: 15)
    @cx5 = Customer.create!(    first_name: "Mary",     last_name: "Mccall")
    @invoice_8 = @cx5.invoices.create!(    status: 1,     created_at: march_third)
    @invoice_9 = @cx5.invoices.create!(    status: 1,     created_at: april_first)
    InvoiceItem.create!(    invoice: @invoice_8,     item: @item13,     quantity: 1,     unit_price: 10,     status: 0)
    InvoiceItem.create!(    invoice: @invoice_9,     item: @item14,     quantity: 1,     unit_price: 11,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_9,     item: @item15,     quantity: 1,     unit_price: 12,     status: 2)
    @invoice_8.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")
    @invoice_9.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "success")

      ###LINE BREAK
    @merchant6 = Merchant.create!(    name: "Denver Divers")
    @item16 = @merchant6.items.create!(    name: "P",     description: "Papa",     unit_price: 16)
    @item17 = @merchant6.items.create!(    name: "Q",     description: "Quebec",     unit_price: 17)
    @item18 = @merchant6.items.create!(    name: "R",     description: "Romeo",     unit_price: 18)
    @cx6 = Customer.create!(    first_name: "David",     last_name: "Dallal")
    @invoice_10 = @cx6.invoices.create!(    status: 1,     created_at: march_third)
    InvoiceItem.create!(    invoice: @invoice_10,     item: @item16,     quantity: 2,     unit_price: 16,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_10,     item: @item17,     quantity: 1,     unit_price: 17,     status: 2)
    InvoiceItem.create!(    invoice: @invoice_10,     item: @item18,     quantity: 1,     unit_price: 18,     status: 2)
    @invoice_10.transactions.create!(    credit_card_number: 123456789,     credit_card_expiration_date: "07/2023",     result: "failed")
  end

  describe("24.admin merchants index") do
    it("24.displays name of each merchant in the system") do
      visit(admin_merchants_path)
      expect(page).to(have_content(@merchant1.name))
      expect(page).to(have_content(@merchant2.name))
      expect(page).to(have_content(@merchant3.name))
    end
  end

  describe("25.I click on the name of a merchant from the admin merchants index page,") do
    it("25.I am taken to that merchant's admin show page (/admin/merchants/merchant_id)") do
      visit(admin_merchants_path)

      within("#Disabled") do
        click_link("Tokyos Tractors")
      end

      expect(current_path).to(eq(admin_merchant_path(@merchant1.id)))
      expect(page).to(have_content("Name: Tokyos Tractors"))
    end

    it("25.And I see the name of that merchant") do
      visit(admin_merchants_path)

      within("#Disabled") do
        click_link("#{@merchant1.name}")
      end

      expect(current_path).to(eq(admin_merchant_path(@merchant1.id)))
      expect(page).to(have_content("Name: Tokyos Tractors"))
    end
  end

  describe("27.I visit the admin merchants index") do
    describe("27.Then next to each merchant name I see a button to disable or enable that merchant.") do
      it("I click this button") do
        visit(admin_merchants_path)

        within("#Disabled") do
          within("#merchant-#{@merchant1.id}") do
            expect(page).to(have_button("Enable"))
            click_button("Enable")
          end

          within("#merchant-#{@merchant2.id}") do
            expect(page).to(have_button("Enable"))
            click_button("Enable")
          end

          within("#merchant-#{@merchant3.id}") do
            expect(page).to(have_button("Enable"))
            click_button("Enable")
          end
        end

        expect(current_path).to(eq(admin_merchants_path))

        within("#Enabled") do
          within("#merchant-#{@merchant1.id}") do
            expect(page).to(have_button("Disable"))
          end

          within("#merchant-#{@merchant2.id}") do
            expect(page).to(have_button("Disable"))
          end

          within("#merchant-#{@merchant3.id}") do
            expect(page).to(have_button("Disable"))
            click_button("Disable")
          end
        end

        expect(current_path).to(eq(admin_merchants_path))
      end
    end
  end

  describe("29.I see a link to create a new merchant") do
    describe("When I click on the link,I am taken to a form that allows me to add merchant information") do
      describe("When I click on the link,I am taken to a form that allows me to add merchant information") do
        it("29.And I see the merchant I just created displayed And I see my merchant was created with a default status of disabled.") do
          visit(admin_merchants_path)
          expect(page).to(have_link("Create New Merchant"))
          click_link("Create New Merchant")
          expect(current_path).to(eq(new_admin_merchant_path))
          fill_in(:name,           with: "Billy Bobs Banging Banjos")
          click_button("Create New Merchant")
          expect(current_path).to(eq(admin_merchants_path))
        end
      end
    end
  end

#Only invoices with at least one successful transaction should count towards revenue
#Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
#Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
  describe("29.I see the names of the top 5 merchants by total revenue generated") do
    describe("And I see that each merchant name links to the admin merchant show page for that merchant") do
      it("29.And I see the total revenue generated next to each merchant name") do
        visit(admin_merchants_path)

        within("#top-five-merchants") do
          expect("Moscows Mechanics - $33.00 in sales").to(appear_before("Rios Radios - $24.00 in sales",           only_text: true))
          expect("Rios Radios - $24.00 in sales").to(appear_before("Berlins Building Supply - $15.00 in sales",           only_text: true))
          expect("Berlins Building Supply - $15.00 in sales").to(appear_before("Oslos Outdoor Market - $12.00 in sales",           only_text: true))
          expect("Oslos Outdoor Market - $12.00 in sales").to(appear_before("Tokyos Tractors - $7.00 in sales",           only_text: true))
          expect(page).to(have_link("Moscows Mechanics",           href: admin_merchant_path(@merchant5)))
          expect(page).to(have_link("Rios Radios",           href: admin_merchant_path(@merchant4)))
          expect(page).to(have_link("Berlins Building Supply",           href: admin_merchant_path(@merchant3)))
          expect(page).to(have_link("Oslos Outdoor Market",           href: admin_merchant_path(@merchant2)))
          expect(page).to(have_link("Tokyos Tractors",           href: admin_merchant_path(@merchant1)))
        end
      end
    end

    describe("Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant") do
      it("And I see a label Top selling date for was ") do
        visit(admin_merchants_path)
        expect(page).to(have_content("Top day for Moscows Mechanics was 4/1/22"))
        expect(page).to(have_content("Top day for Rios Radios was 2/3/22"))
        expect(page).to(have_content("Top day for Berlins Building Supply was 3/3/22"))
        expect(page).to(have_content("Top day for Oslos Outdoor Market was 4/1/22"))
        expect(page).to(have_content("Top day for Tokyos Tractors was 3/3/22"))
      end
    end
  end
end
