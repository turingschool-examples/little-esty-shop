require 'rails_helper'

RSpec.describe "admin dashboard" do
  before :each do
    @customer1 = Customer.create!(first_name: "First1", last_name: "Last1")
    @customer2 = Customer.create!(first_name: "First2", last_name: "Last2")
    @customer3 = Customer.create!(first_name: "First3", last_name: "Last3")
    @customer4 = Customer.create!(first_name: "First4", last_name: "Last4")
    @customer5 = Customer.create!(first_name: "First5", last_name: "Last5")
    @customer6 = Customer.create!(first_name: "First6", last_name: "Last6")

    @invoice2 = @customer2.invoices.create!(status: 1)
    @transaction2 = @invoice2.transactions.create!(result: 0)
    @invoice3 = @customer3.invoices.create!(status: 1)
    @transaction3 = @invoice3.transactions.create!(result: 0)
    @invoice1 = @customer2.invoices.create!(status: 1)
    @transaction1 = @invoice1.transactions.create!(result: 0)
    @invoice7 = @customer5.invoices.create!(status: 1)
    @transaction7 = @invoice7.transactions.create!(result: 0)
    @invoice5 = @customer4.invoices.create!(status: 1)
    @transaction5 = @invoice5.transactions.create!(result: 0)
    @invoice6 = @customer5.invoices.create!(status: 0)
    @transaction6 = @invoice6.transactions.create!(result: 0)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @transaction4 = @invoice4.transactions.create!(result: 0)
    @invoice8 = @customer5.invoices.create!(status: 1)
    @transaction8 = @invoice8.transactions.create!(result: 0)
    @invoice9 = @customer5.invoices.create!(status: 2)
    @transaction9 = @invoice9.transactions.create!(result: 0)
    @invoice10 = @customer6.invoices.create!(status: 1)
    @transaction10 = @invoice10.transactions.create!(result: 0)
    @invoice11 = @customer6.invoices.create!(status: 0)
    @transaction11 = @invoice11.transactions.create!(result: 0)
    @invoice12 = @customer6.invoices.create!(status: 0)
    @transaction12 = @invoice12.transactions.create!(result: 0)


  end
  describe "when I visit the admin dashboard" do
    it "shows a header indicating that I am on the admin dashboard" do
      visit '/admin'

      within("header") do
        expect(page).to have_content("Admin Dashboard")
      end
    end

    it "has links to the admin merchant index page and admin invoice index page" do
      visit "/admin"

      within("header") do
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Invoices")
      end
    end

    it "shows the top 5 customers, and the number of transactions they have completed" do
      visit "/admin"

      within(".top_customers") do
        expect(@customer5.first_name).to appear_before(@customer6.first_name)
        expect(@customer6.first_name).to appear_before(@customer2.first_name)
        expect(@customer2.first_name).to appear_before(@customer4.first_name)
        expect(@customer4.first_name).to appear_before(@customer3.first_name)

        within("#customer_id_#{@customer2.id}") do
          expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}")
          expect(page).to have_content(2)
        end

        within("#customer_id_#{@customer3.id}") do
          expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}")
          expect(page).to have_content(1)
        end

        within("#customer_id_#{@customer4.id}") do
          expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}")
          expect(page).to have_content(2)
        end

        within("#customer_id_#{@customer5.id}") do
          expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}")
          expect(page).to have_content(4)
        end

        within("#customer_id_#{@customer6.id}") do
          expect(page).to have_content("#{@customer6.first_name} #{@customer6.last_name}")
          expect(page).to have_content(3)
        end
      end
    end

    it "shows a list of all the incomplete invoices in order of creation" do
      visit "/admin"

      within ".incomplete_invioces" do
        expect("Invoice: #{@invoice2.id}").to appear_before("Invoice: #{@invoice3.id}")
        expect("Invoice: #{@invoice3.id}").to appear_before("Invoice: #{@invoice1.id}")
        expect("Invoice: #{@invoice1.id}").to appear_before("Invoice: #{@invoice7.id}")
        expect("Invoice: #{@invoice7.id}").to appear_before("Invoice: #{@invoice5.id}")
        expect("Invoice: #{@invoice5.id}").to appear_before("Invoice: #{@invoice6.id}")
        expect("Invoice: #{@invoice6.id}").to appear_before("Invoice: #{@invoice8.id}")
      end
    end

    it "shows each invice id as a link and has the date next to it" do
      visit "/admin"
save_and_open_page
      within ".incomplete_invioces" do
        within("#invoice_id_#{@invoice1.id}") do
          expect(page).to have_link("#{@invoice1.id}")
          expect(page).to have_content("Created at: #{@invoice1.created_at.strftime('%A, %b %d, %Y')}")
        end

        within("#invoice_id_#{@invoice2.id}") do
          expect(page).to have_link("#{@invoice2.id}")
          expect(page).to have_content("Created at: #{@invoice2.created_at.strftime('%A, %b %d, %Y')}")
        end

        within("#invoice_id_#{@invoice3.id}") do
          expect(page).to have_link("#{@invoice3.id}")
          expect(page).to have_content("Created at: #{@invoice3.created_at.strftime('%A, %b %d, %Y')}")
        end
      end
    end
  end
end
