require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  it 'has a header indicating i am on the admin dashboard' do

    visit '/admin'
    
    within("#admin_header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  it 'has a link to the admin merchants index' do
    visit '/admin'
    within ("#links") do
      expect(page).to have_link("Merchants")
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end
  end
  
  it 'has a link to the admin invoices index' do
    visit '/admin'
    within ("#links") do
      expect(page).to have_link("Invoices")  
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end

  describe 'it has an incomplete invoices section' do
    it 'lists all incomplete invoices' do
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)
      invoice4 = customer.invoices.create!(status: 0)

      visit '/admin'
      
      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(invoice1.id)
        expect(page).to have_content(invoice4.id)
      end
    end

    it 'orders the invoices from oldest to newest
        and displays the date the invoice was created "Monday, July 18,2019"' do
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)
      invoice4 = customer.invoices.create!(status: 0)
      invoice5 = customer.invoices.create!(status: 0)

      visit '/admin'
      
      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        
        within("#incomplete_invoice-#{invoice1.id}") do
          expect(page).to have_content(invoice1.id)
          expect(page).to have_content("#{invoice1.created_at.strftime("%A, %B %d, %Y")}") #"Monday, July 18, 2019"
        end
    
        within("#incomplete_invoice-#{invoice5.id}") do
          expect(page).to have_content(invoice5.id)
          expect(page).to have_content("#{invoice5.created_at.strftime("%A, %B %d, %Y")}")
        end
      end
    end

    it 'each incomplete invoice is a link to that invoices show page' do
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      invoice1 = customer.invoices.create!(status: 0)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 2)
      invoice4 = customer.invoices.create!(status: 0)
      invoice5 = customer.invoices.create!(status: 0)

      visit '/admin'
      
      within("#incomplete_invoice-#{invoice1.id}") do
        expect(page).to have_link("#{invoice1.id}")
        click_link("#{invoice1.id}")
        expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
      end
      
      # within("#incomplete_invoice-#{invoice5.id}") do
      #   expect(page).to have_link("#{invoice5.id}")
      #   click_link("#{invoice5.id}")
      #   expect(current_path).to eq("/admin/invoices/#{invoice5.id}")
      # end
    end
  end

  it 'displays the names of the top 5 customers who
    have conducted the most successful transactions' do
    
    customer1 = Customer.create!(first_name: "Ayy", last_name: "All")
    invoice1 = customer1.invoices.create!(status: 0)
    transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
    
    customer2 = Customer.create!(first_name: "Bee", last_name: "Bold")
    invoice2 = customer2.invoices.create!(status: 1)
    transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction3 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction4 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction5 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer3 = Customer.create!(first_name: "Cee", last_name: "Cold")
    invoice3 = customer3.invoices.create!(status: 2)
    transaction6 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction7 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction8 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer4 = Customer.create!(first_name: "Dee", last_name: "Droll")
    invoice4 = customer4.invoices.create!(status: 0)
    transaction9 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction10 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer5 = Customer.create!(first_name: "Eyy", last_name: "Erk")
    invoice5 = customer5.invoices.create!(status: 1)
    transaction11 = invoice5.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer6 = Customer.create!(first_name: "Gee", last_name: "Golly")
    invoice6 = customer6.invoices.create!(status: 2)
    transaction12 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
    transaction13 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)

    visit '/admin'
    
    expect(customer2.first_name).to appear_before(customer3.first_name)
    expect(customer3.first_name).to appear_before(customer4.first_name)
    expect(customer4.first_name).to appear_before(customer5.first_name)
    expect(page).to_not have_content(customer1.first_name)
  end
  it 'displays the number of successful transactions next to each customer' do
    customer1 = Customer.create!(first_name: "Ayy", last_name: "All")
    invoice1 = customer1.invoices.create!(status: 0)
    transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
    
    customer2 = Customer.create!(first_name: "Bee", last_name: "Bold")
    invoice2 = customer2.invoices.create!(status: 1)
    transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction3 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction4 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction5 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer3 = Customer.create!(first_name: "Cee", last_name: "Cold")
    invoice3 = customer3.invoices.create!(status: 2)
    transaction6 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction7 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction8 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer4 = Customer.create!(first_name: "Dee", last_name: "Droll")
    invoice4 = customer4.invoices.create!(status: 0)
    transaction9 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    transaction10 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer5 = Customer.create!(first_name: "Eyy", last_name: "Erk")
    invoice5 = customer5.invoices.create!(status: 1)
    transaction11 = invoice5.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
    
    customer6 = Customer.create!(first_name: "Gee", last_name: "Golly")
    invoice6 = customer6.invoices.create!(status: 2)
    transaction12 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
    transaction13 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)

    visit '/admin'
    
    within("#customer-#{customer2.id}") do
      expect(page).to have_content(4)
    end

    within("#customer-#{customer3.id}") do
      expect(page).to have_content(3)
    end
  end
end