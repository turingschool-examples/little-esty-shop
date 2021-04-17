require 'rails_helper'

RSpec.describe 'when I visit the admin merchant index page' do
  before(:each) do
    @customer_1 = FactoryBot.create(:customer)
    @customer_2 = FactoryBot.create(:customer)
    @customer_3 = FactoryBot.create(:customer)
    @customer_4 = FactoryBot.create(:customer)
    @customer_5 = FactoryBot.create(:customer)
    @customer_6 = FactoryBot.create(:customer)

    @invoice_1 = FactoryBot.create(:invoice)
    @invoice_2 = FactoryBot.create(:invoice)
    @invoice_3 = FactoryBot.create(:invoice)
    @invoice_4 = FactoryBot.create(:invoice)
    @invoice_5 = FactoryBot.create(:invoice)
    @invoice_6 = FactoryBot.create(:invoice)
    @customer_1.invoices << [@invoice_1]
    @customer_2.invoices << [@invoice_2]
    @customer_3.invoices << [@invoice_3]
    @customer_4.invoices << [@invoice_4]
    @customer_5.invoices << [@invoice_5]
    @customer_6.invoices << [@invoice_6]

    @transaction_1 = FactoryBot.create(:transaction, result: 1)
    @transaction_2 = FactoryBot.create(:transaction, result: 1)
    @transaction_3 = FactoryBot.create(:transaction, result: 1)
    @transaction_4 = FactoryBot.create(:transaction, result: 1)
    @transaction_5 = FactoryBot.create(:transaction, result: 1)
    @invoice_1.transactions << [@transaction_1, @transaction_2, @transaction_3, @transaction_4, @transaction_5]

    @transaction_6 = FactoryBot.create(:transaction, result: 1)
    @transaction_7 = FactoryBot.create(:transaction, result: 1)
    @transaction_8 = FactoryBot.create(:transaction, result: 1)
    @transaction_9 = FactoryBot.create(:transaction, result: 1)
    @invoice_2.transactions << [@transaction_6, @transaction_7, @transaction_8, @transaction_9]

    @transaction_10 = FactoryBot.create(:transaction, result: 1)
    @transaction_11 = FactoryBot.create(:transaction, result: 1)
    @transaction_12 = FactoryBot.create(:transaction, result: 1)
    @invoice_3.transactions << [@transaction_10, @transaction_11, @transaction_12]

    @transaction_13 = FactoryBot.create(:transaction, result: 1)
    @transaction_14 = FactoryBot.create(:transaction, result: 1)
    @invoice_4.transactions << [@transaction_13, @transaction_14]

    @transaction_15 = FactoryBot.create(:transaction, result: 1)
    @invoice_5.transactions << [@transaction_15]

    @merchant_1 = create(:merchant, status: 'Enabled')
    @merchant_2 = create(:merchant, status: 'Disabled')
    @merchant_3 = create(:merchant, status: 'Enabled')
    @merchant_4 = create(:merchant, status: 'Enabled')
    @merchant_5 = create(:merchant, status: 'Disabled')
  end

  it 'shows the name of each merchant in the system' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
  end

  it "click on a merchants name I am taken to that merchants show page" do
    visit '/admin/merchants'

    click_link "#{@merchant_1.name}"
    expect(current_path).to eq ("/admin/merchants/#{@merchant_1.id}")
  end

  describe "Admin Merchant Enable/Disable" do
    it 'has a button next to each merchant to disable/enable it it' do
      visit '/admin/merchants'

      within"#enabled-merchants" do
        expect(page).to have_content("Enabled Merchants")
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_5.name)

        click_on "Disable"
        expect(current_path).to eq('/admin/merchants')
        expect(@merchant_1.status).to eq('disabled')

      within"#disabled-merchants"
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_5.name)
        expect(page).to have_content("Enable")
        expect(current_path).to eq ('/admin/merchants')
      end
    end
  end
end
