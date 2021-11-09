require 'rails_helper'

RSpec.describe 'admin dashboard show page' do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)

    invoice1 = create(:invoice, customer: @customer1)
    invoice2 = create(:invoice, customer: @customer2)
    invoice3 = create(:invoice, customer: @customer3)
    invoice4 = create(:invoice, customer: @customer4)
    invoice5 = create(:invoice, customer: @customer5)
    invoice6 = create(:invoice, customer: @customer6)

    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice1)

    create(:transaction, result: 'success', invoice: invoice2)
    create(:transaction, result: 'success', invoice: invoice2)
    create(:transaction, result: 'success', invoice: invoice2)
    create(:transaction, result: 'success', invoice: invoice2)

    create(:transaction, result: 'success', invoice: invoice3)
    create(:transaction, result: 'success', invoice: invoice3)
    create(:transaction, result: 'success', invoice: invoice3)

    create(:transaction, result: 'success', invoice: invoice4)
    create(:transaction, result: 'success', invoice: invoice4)

    create(:transaction, result: 'success', invoice: invoice5)

    visit "/admin/"
  end

  it 'has a link to admin merchants' do
    click_link("Merchants")

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'has a link to admin invoices' do
    click_link("Invoices")

    expect(current_path).to eq(admin_invoices_path)
  end

  it 'exists' do
  end

  it 'lists the top five customers' do
    within('#top-five-customers') do
      save_and_open_page

      expect(@customer1.first_name).to appear_before(@customer2.first_name)
      expect(@customer2.first_name).to appear_before(@customer3.first_name)
      expect(@customer3.first_name).to appear_before(@customer4.first_name)
      expect(@customer4.first_name).to appear_before(@customer5.first_name)

      expect(page).to_not have_content(@customer6.first_name)
    end
  end

end