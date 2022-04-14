require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: "Pabu")

    @customer1 = Customer.create!(first_name: "John", last_name: "H")
    @invoice1 = @customer1.invoices.create!(status: "completed")
    @transactions_1a = @invoice1.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
    @transactions_1b = @invoice1.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
    @transactions_1c = @invoice1.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
    @transactions_1d = @invoice1.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

    @customer2 = Customer.create!(first_name: "Joseph", last_name: "D")
    @invoice2 = @customer2.invoices.create!(status: "completed")
    @transactions_2a = @invoice2.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
    @transactions_2b = @invoice2.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
    @transactions_2c = @invoice2.transactions.create!(credit_card_number: '1234567812345670', result: 'success')

    @customer3 = Customer.create!(first_name: "Ian", last_name: "R")
    @invoice3 = @customer3.invoices.create!(status: "completed")
    @transactions_3a = @invoice3.transactions.create!(credit_card_number: '1234567812345678', result: 'success')

    @customer4 = Customer.create!(first_name: "Loki", last_name: "R")
    @invoice4 = @customer4.invoices.create!(status: "completed")
    @transactions_4a = @invoice4.transactions.create!(credit_card_number: '1234567812345678', result: 'success')
    @transactions_4b = @invoice4.transactions.create!(credit_card_number: '1234567812345679', result: 'success')
    @transactions_4c = @invoice4.transactions.create!(credit_card_number: '1234567812345670', result: 'success')
    @transactions_4d = @invoice4.transactions.create!(credit_card_number: '1234567812345671', result: 'success')
    @transactions_4e = @invoice4.transactions.create!(credit_card_number: '1234567812345671', result: 'success')

    @customer5 = Customer.create!(first_name: "Amanda", last_name: "A")
    @invoice5 = @customer5.invoices.create!(status: "completed")
    @transactions_5a = @invoice5.transactions.create!(credit_card_number: '1234567812345678', result: 'failed')

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows merchant name' do
    expect(page).to have_content(@merchant1.name)
  end

  it 'has link to merchant item index' do
    within("#index-buttons") do
      click_button "Items Index"
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end
  end

  it 'has link to merchant invoices index' do
    click_button "Invoices Index"
    expect(current_path).to eq(merchant_invoices_path(@merchant1))
  end

  it 'shows top 5 customers' do
    within("#top-customers") do
      expect("Loki").to appear_before("John")
      expect("John").to appear_before("Joseph")
      expect("Joseph").to appear_before("Ian")

      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.succsessful_transaction_count)
      expect(page).to have_content(@customer2.first_name)
      expect(page).to have_content(@customer2.succsessful_transaction_count)
      expect(page).to have_content(@customer3.first_name)
      expect(page).to have_content(@customer3.succsessful_transaction_count)
      expect(page).to have_content(@customer4.first_name)
      expect(page).to have_content(@customer4.succsessful_transaction_count)
      expect(page).to_not have_content(@customer5.first_name)
    end
  end
end
