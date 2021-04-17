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

    @merchant_1 = create(:enabled_merchant)
    @merchant_2 = create(:disabled_merchant)
    @merchant_3 = create(:enabled_merchant)
    @merchant_4 = create(:enabled_merchant)
    @merchant_5 = create(:disabled_merchant)
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
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_4.name)
        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_5.name)
      end

      within"#disabled-merchants" do
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_5.name)
      end
    end

    # need to find a way to test this but not mapping to id in p tag
    xit 'updates merchant status when button pushed' do
    visit '/admin/merchants'
      expect(@merchant_1.status).to eq('enabled')

      click_on "Disable"
      expect(@merchant_1.status).to eq('enabled')
    end
  end
end
