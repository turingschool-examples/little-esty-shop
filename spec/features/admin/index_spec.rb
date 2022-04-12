require 'rails_helper'
# require 'rakes'
# Rails.application.load_tasks
# require 'database_cleaner'
require 'rspec'

describe "Admin dashboard", type: :feature do
  # before (:each) do
  #   DatabaseCleaner.strategy = :truncation
  #   DatabaseCleaner.clean
  #   Rake::Task['csv_load:all'].invoke
  # end
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

    it "displays the name of the top 5 customers" do
      @deviant = Merchant.create!(name: "Deviant Queer")

      @john = Customer.create!(first_name: "John", last_name: "H")
      @invoice1 = @john.invoices.create!(status: "completed")
      @transactions_1a = @invoice1.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
      @transactions_1b = @invoice1.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
      @transactions_1c = @invoice1.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
      @transactions_1d = @invoice1.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

      @august = (first_name: "August", last_name: "R")
      @invoice2 = @august.invoices.create!(status: "completed")
      @transactions_2a = @invoice2.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
      @transactions_2b = @invoice2.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
      @transactions_2c = @invoice2.transactions.create!(credit_card_number: '1234567812345670', result: 'success')

      @ian = (first_name: "Ian", last_name: "R")
      @invoice3 = @ian.invoices.create!(status: "completed")
      @transactions_3a = @invoice3.transactions.create!(credit_card_number: '1234567812345678', result: 'success')

      @joseph = Customer.create!(first_name: "Joseph", last_name: "S")
      @invoice4 = @joseph.invoices.create!(status: "completed")
      @transactions_4a = @invoice1.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
      @transactions_4b = @invoice1.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
      @transactions_4c = @invoice1.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
      @transactions_4d = @invoice1.transactions.create!(credit_card_number: '1234567812345671', result: 'success')
      @transactions_4e = @invoice1.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

      visit "/admin"

      expect(page).to have_content("Joseph")
      expect(page).to have_content("Ian")
      expect(page).to have_content("August")
      expect(page).to have_content("John")
    end
  end
end
