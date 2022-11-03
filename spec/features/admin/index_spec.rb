require "rails_helper"

RSpec.describe "Admin Dashboard (Index", type: :feature do
  
  before(:each) do
    @customer_1 = Customer.create!(first_name: "Luke", last_name: "Harison")
    @customer_2 = Customer.create!(first_name: "Angela", last_name: "Leizer")
    @customer_3 = Customer.create!(first_name: "Matt", last_name: "Sorry")
    @customer_4 = Customer.create!(first_name: "Drake",last_name: "Pointer")
    @customer_5 = Customer.create!(first_name: "Fannie", last_name: "May")
    @customer_6 = Customer.create!(first_name: "Lorelai", last_name: "Gillmore")
    @customer_7 = Customer.create!(first_name: "Simon", last_name: "Garfunkle")
  
    @invoice_1 = @customer_1.invoices.create!(status: 0)
    @invoice_2 = @customer_1.invoices.create!(status: 0)
    @invoice_3 = @customer_1.invoices.create!(status: 1)
    @invoice_4 = @customer_1.invoices.create!(status: 2)
    @invoice_5 = @customer_1.invoices.create!(status: 2)
    @invoice_6 = @customer_2.invoices.create!(status: 0)
    @invoice_7 = @customer_2.invoices.create!(status: 0)
    @invoice_8 = @customer_3.invoices.create!(status: 0)
    @invoice_9 = @customer_3.invoices.create!(status: 0)
    @invoice_10 = @customer_3.invoices.create!(status: 2)
    @invoice_11 = @customer_3.invoices.create!(status: 0)
    @invoice_12 = @customer_4.invoices.create!(status: 1)
    @invoice_13 = @customer_4.invoices.create!(status: 1)
    @invoice_14 = @customer_4.invoices.create!(status: 2)
    @invoice_15 = @customer_5.invoices.create!(status: 0)
    @invoice_16 = @customer_5.invoices.create!(status: 0)
    @invoice_17 = @customer_6.invoices.create!(status: 1)
    @invoice_18 = @customer_6.invoices.create!(status: 2)
    @invoice_19 = @customer_6.invoices.create!(status: 2)
    @invoice_20 = @customer_7.invoices.create!(status: 0)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4580251236515201, result: "success")
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4354495077693036, result: "failed")
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4515551623735607, result: "failed")
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4844518708741275, result: "failed")
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4203696133194408, result: "success")
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4801647818676136, result: "success")
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4540842003561938, result: "success")
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4140149827486249, result: "success")
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4923661117104166, result: "failed")
    @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4800749911485986, result: "success")
    @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4017503416578382, result: "failed")
    @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4536896898764278, result: "failed")
    @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4411510861233607, result: "failed")
    @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4869639160798434, result: "success")
    @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 4738848761455352, result: "success")
    @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 4214497729954420, result: "failed")
    @transaction_18 = @invoice_18.transactions.create!(credit_card_number: 4436110257010678, result: "failed")
    @transaction_19 = @invoice_19.transactions.create!(credit_card_number: 4332881798016631, result: "failed")
    @transaction_20 = @invoice_20.transactions.create!(credit_card_number: 4886443388914010, result: "success")
  end

  it "has a header indicating that the user is on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end

  it "has a link to the admin merchants index" do
    visit "/admin"
    expect(page).to have_link("Admin Merchants", href: "/admin/merchants")
  end

  it "has a link to the admin invoices index" do
    visit "/admin"
    expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
  end

  it "has a list of the top 5 customers who have conducted the largest number of successful
    transactions" do
      visit "/admin"

      within("#admin-dashboard") do
        expect(page).to have_content("Name: #{@customer_1.first_name} #{@customer_1.last_name}")
        expect(page).to have_content("Name: #{@customer_2.first_name} #{@customer_2.last_name}")
        expect(page).to have_content("Name: #{@customer_3.first_name} #{@customer_3.last_name}")
        expect(page).to have_content("Name: #{@customer_5.first_name} #{@customer_5.last_name}")
        expect(page).to have_content("Name: #{@customer_7.first_name} #{@customer_7.last_name}")
      end 

      within("#admin-dashboard") do
        expect("#{@customer_3.first_name} #{@customer_3.last_name}").to appear_before("#{@customer_1.first_name} #{@customer_1.last_name}")
        expect("#{@customer_1.first_name} #{@customer_1.last_name}").to appear_before("#{@customer_2.first_name} #{@customer_2.last_name}")
        expect("#{@customer_5.first_name} #{@customer_5.last_name}").to appear_before("#{@customer_7.first_name} #{@customer_7.last_name}")
        expect("#{@customer_7.first_name} #{@customer_7.last_name}").to_not appear_before("#{@customer_5.first_name} #{@customer_5.last_name}")
        expect("#{@customer_2.first_name} #{@customer_2.last_name}").to_not appear_before("#{@customer_1.first_name} #{@customer_1.last_name}")
        expect("#{@customer_5.first_name} #{@customer_5.last_name}").to_not appear_before("#{@customer_2.first_name} #{@customer_2.last_name}")
      end 
  end

  it "next to each of the top 5 customers it has the number of successful transactions they
    have conducted" do
      visit "/admin"

       within("#admin-dashboard") do
        expect(page).to have_content("Name: #{@customer_1.first_name} #{@customer_1.last_name} | Number of Successful Transactions: #{@customer_1.transaction_ct("success")}")
        expect(page).to have_content("Name: #{@customer_2.first_name} #{@customer_2.last_name} | Number of Successful Transactions: #{@customer_2.transaction_ct("success")}")
        expect(page).to have_content("Name: #{@customer_3.first_name} #{@customer_3.last_name} | Number of Successful Transactions: #{@customer_3.transaction_ct("success")}")
        expect(page).to have_content("Name: #{@customer_5.first_name} #{@customer_5.last_name} | Number of Successful Transactions: #{@customer_5.transaction_ct("success")}")
        expect(page).to have_content("Name: #{@customer_7.first_name} #{@customer_7.last_name} | Number of Successful Transactions: #{@customer_7.transaction_ct("success")}")
      end 
  end
end