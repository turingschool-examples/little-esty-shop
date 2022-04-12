require 'rails_helper'
require 'rspec'

describe "Admin dashboard", type: :feature do

  describe "when I visit the admin dashboard page" do
    it "displays a header telling me where I am" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "displays a link to admin/merchants" do
      visit "/admin"

      click_on "Admin: Merchants"

      expect(current_path).to eq("/admin/merchants")
    end

    it "displays a link to admin/invoices" do
      visit "/admin"

      click_on "Admin: Invoices"

      expect(current_path).to eq("/admin/invoices")
    end

    it "displays the name of the top 5 customers and how many transactions" do
      @deviant = Merchant.create!(name: "Deviant Queer")

      @john = Customer.create!(first_name: "John", last_name: "H")
      @invoice1 = @john.invoices.create!(status: "completed")
      @transactions_1a = @invoice1.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
      @transactions_1b = @invoice1.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
      @transactions_1c = @invoice1.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
      @transactions_1d = @invoice1.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

      @august = Customer.create!(first_name: "August", last_name: "R")
      @invoice2 = @august.invoices.create!(status: "completed")
      @transactions_2a = @invoice2.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
      @transactions_2b = @invoice2.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
      @transactions_2c = @invoice2.transactions.create!(credit_card_number: '1234567812345670', result: 'success')

      @ian = Customer.create!(first_name: "Ian", last_name: "R")
      @invoice3 = @ian.invoices.create!(status: "completed")
      @transactions_3a = @invoice3.transactions.create!(credit_card_number: '1234567812345678', result: 'success')

      @joseph = Customer.create!(first_name: "Joseph", last_name: "S")
      @invoice4 = @joseph.invoices.create!(status: "completed")
      @transactions_4a = @invoice4.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
      @transactions_4b = @invoice4.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
      @transactions_4c = @invoice4.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
      @transactions_4d = @invoice4.transactions.create!(credit_card_number: '1234567812345671', result: 'success')
      @transactions_4e = @invoice4.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

      @amanda = Customer.create!(first_name: "Amanda", last_name: "A")
      @invoice5 = @amanda.invoices.create!(status: "completed")
      @transactions_5a = @invoice5.transactions.create!(credit_card_number: '1234567812345678', result: 'failed')

      visit "/admin"

      within('#customers') do
        expect("Joseph").to appear_before("John")
        expect("John").to appear_before("August")
        expect("August").to appear_before("Ian")
        expect(page).to_not have_content("Amanda")
      end

      within("#customer-#{@joseph.id}") do
        expect(page).to have_content("5")
      end

      within("#customer-#{@august.id}") do
        expect(page).to have_content("3")
      end

      it "displays a list of Incomplete Invoices" do
        @john = Customer.create!(first_name: "John", last_name: "H")
        @invoice1 = @john.invoices.create!(status: "completed")
        @invoice2 = @john.invoices.create!(status: "cancelled")
        @invoice3 = @john.invoices.create!(status: "in_progress")
        @invoice4 = @john.invoices.create!(status: "in_progress")
        @invoice5 = @john.invoices.create!(status: "in_progress")

        visit "/admin"

        within('invoices') do
          expect(page).to have_content(@invoice3.id)
          expect(page).to have_content(@invoice4.id)
          expect(page).to have_content(@invoice5.id)
          expect(page).to_not have_content(@invoice1.id)
          expect(page).to_not have_content(@invoice2.id)
        end

        within("#invoice-#{@invoice3.id}") do
          click_on "Invoice #{@invoice3.id}"
        end

        expect(current_path).to eq("/admin/invoices/#{@invoice3.id}")

      end
    end
  end
end
