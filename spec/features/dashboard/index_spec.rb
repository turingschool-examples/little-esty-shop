require 'rails_helper'

RSpec.describe 'merchant dashboard show page' do
  before :each do
    @nomi = Merchant.create!(name: "Naomi LLC")
    @tyty = Merchant.create!(name: "TyTy's Grub")
    
    @timmy = Customer.create!(first_name: "Timmy", last_name: "Limmy")
    @sue = Customer.create!(first_name: "Sue", last_name: "Maybis")
    @shooter = Customer.create!(first_name: "Shooter", last_name: "Mcgavin")
    @louise = Customer.create!(first_name: "Louise", last_name: "Banks")
    @alfred = Customer.create!(first_name: "Alfred", last_name: "Borden")
    @olivia = Customer.create!(first_name: "Olivia", last_name: "Wenscombe")
  
    @invoice_1 = Invoice.create!(status: 2, customer_id: @timmy.id)
    @invoice_2 = Invoice.create!(status: 2, customer_id: @timmy.id)
  
    @invoice_3 = Invoice.create!(status: 2, customer_id: @sue.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @sue.id)
  
    @invoice_5 = Invoice.create!(status: 2, customer_id: @shooter.id)
    @invoice_6 = Invoice.create!(status: 2, customer_id: @shooter.id)
  
    @invoice_7 = Invoice.create!(status: 2, customer_id: @louise.id)
    @invoice_8 = Invoice.create!(status: 2, customer_id: @louise.id)
  
    @invoice_9 = Invoice.create!(status: 2, customer_id: @alfred.id)
    @invoice_10 = Invoice.create!(status: 2, customer_id: @alfred.id)
  
    @invoice_11 = Invoice.create!(status: 2, customer_id: @olivia.id)
    @invoice_12 = Invoice.create!(status: 2, customer_id: @olivia.id)
    
    @transaction_1 = Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: @invoice_2.id)
  
    @transaction_3 = Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: @invoice_4.id)
  
    @transaction_5 = Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_6.id)
  
    @transaction_7 = Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_8.id)
  
    @transaction_9 = Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_9.id)
    @transaction_10 = Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_10.id)
  
    @transaction_11 = Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_11.id)
    @transaction_12 = Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_12.id)
  end
  

  describe 'visit merchant dashboard' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(nomi)

      expect(page).to have_content(nomi.name)
    end

    it 'has a link to merchant items index' do
      visit merchant_dashboard_index_path(nomi)

      click_on("My Items") 
      
      expect(page).to have_current_path("/merchants/#{nomi.id}/items")
    end

    it 'has a link to my merchant invoices index' do
      visit merchant_dashboard_index_path(nomi)

      click_on("My Invoices") 
      
      expect(page).to have_current_path("/merchants/#{nomi.id}/invoices")
    end

    describe 'I see the names of the top 5 customers' do
      it 'shows each customer name and the number of successful transactions they have' do
        visit merchant_dashboard_index_path(nomi)

        expect(page).to have_content("Favorite Customers")
        within ("#favorite_customers") do
          expect(page).to have_content()
          expect(page).to have_content()
          expect(page).to have_content()
        end
      end
    end

  end
end