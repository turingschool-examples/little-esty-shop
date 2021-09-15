require 'rails_helper'

RSpec.describe 'Admin dashboard' do

  before :each do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @cust7 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust2)
    @invoice4 = create(:invoice, customer: @cust3)
    @invoice5 = create(:invoice, customer: @cust3)
    @invoice6 = create(:invoice, customer: @cust3)
    @invoice7 = create(:invoice, customer: @cust4)
    @invoice8 = create(:invoice, customer: @cust4)
    @invoice9 = create(:invoice, customer: @cust4)
    @invoice10 = create(:invoice, customer: @cust4)
    @invoice11 = create(:invoice, customer: @cust4)
    @invoice12 = create(:invoice, customer: @cust5)
    @invoice13 = create(:invoice, customer: @cust5)
    @invoice14 = create(:invoice, customer: @cust5)
    @invoice15 = create(:invoice, customer: @cust5)
    @invoice16 = create(:invoice, customer: @cust5)
    @invoice17 = create(:invoice, customer: @cust6)
    @invoice18 = create(:invoice, customer: @cust7)
    @invoice19 = create(:invoice, customer: @cust7)
    InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
    InvoiceItem.create(item: @item1, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice3)
    InvoiceItem.create(item: @item1, invoice: @invoice4)
    InvoiceItem.create(item: @item1, invoice: @invoice5)
    InvoiceItem.create(item: @item1, invoice: @invoice6)
    InvoiceItem.create(item: @item2, invoice: @invoice7)
    InvoiceItem.create(item: @item2, invoice: @invoice8)
    InvoiceItem.create(item: @item2, invoice: @invoice9)
    InvoiceItem.create(item: @item2, invoice: @invoice10)
    InvoiceItem.create(item: @item2, invoice: @invoice11)
    InvoiceItem.create(item: @item2, invoice: @invoice12)
    InvoiceItem.create(item: @item2, invoice: @invoice13)
    InvoiceItem.create(item: @item2, invoice: @invoice14)
    InvoiceItem.create(item: @item2, invoice: @invoice15)
    InvoiceItem.create(item: @item2, invoice: @invoice16)
    InvoiceItem.create(item: @item2, invoice: @invoice17)
    InvoiceItem.create(item: @item2, invoice: @invoice18)
    InvoiceItem.create(item: @item2, invoice: @invoice19)
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice4, result: 'success')
    create(:transaction, invoice: @invoice5, result: 'success')
    create(:transaction, invoice: @invoice5, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice6, result: 'success')
    create(:transaction, invoice: @invoice7, result: 'success')
    create(:transaction, invoice: @invoice7, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    create(:transaction, invoice: @invoice8, result: 'success')
    create(:transaction, invoice: @invoice9, result: 'success')
    create(:transaction, invoice: @invoice9, result: 'success')
    create(:transaction, invoice: @invoice10, result: 'success')
    create(:transaction, invoice: @invoice10, result: 'success')
    create(:transaction, invoice: @invoice11, result: 'success')
    create(:transaction, invoice: @invoice11, result: 'success')
    create(:transaction, invoice: @invoice12, result: 'success')
    create(:transaction, invoice: @invoice12, result: 'success')
    create(:transaction, invoice: @invoice13, result: 'success')
    create(:transaction, invoice: @invoice13, result: 'success')
    create(:transaction, invoice: @invoice14, result: 'success')
    create(:transaction, invoice: @invoice14, result: 'success')
    create(:transaction, invoice: @invoice15, result: 'success')
    create(:transaction, invoice: @invoice15, result: 'success')
    create(:transaction, invoice: @invoice16, result: 'success')
    create(:transaction, invoice: @invoice16, result: 'success')
    create(:transaction, invoice: @invoice17, result: 'success')
    create(:transaction, invoice: @invoice17, result: 'success')
    create(:transaction, invoice: @invoice18, result: 'success')
    create(:transaction, invoice: @invoice18, result: 'success')
    create(:transaction, invoice: @invoice19, result: 'success')
    create(:transaction, invoice: @invoice19, result: 'success')
  end

  it 'shows that you are on the admin dashboard' do
    visit '/admin'

    within('h1') do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it 'has a link to the admin merchants index' do
    visit '/admin'

    expect(page).to have_link("Admin Merchants Index")
  end

  it 'has a link to the admin merchants index' do
    visit '/admin'

    expect(page).to have_link("Admin Invoices Index")
  end

  it 'takes you to the admin merchants index when you click the link' do
    visit '/admin'

    click_link "Admin Merchants Index"

    expect(current_path).to eq("/admin/merchants")
  end

  it 'takes you to the admin merchants index when you click the link' do
    visit '/admin'

    click_link "Admin Invoices Index"

    expect(current_path).to eq("/admin/invoices")
  end

  it 'has the names of the top five customers' do
    visit '/admin'
    save_and_open_page
    expect(page).to have_content(@cust4.first_name)
    expect(page).to have_content(@cust5.first_name)
    expect(page).to have_content(@cust3.first_name)
    expect(page).to have_content(@cust7.first_name)
    expect(page).to have_content(@cust2.first_name)
    expect(page).to have_content(@cust4.last_name)
    expect(page).to have_content(@cust5.last_name)
    expect(page).to have_content(@cust3.last_name)
    expect(page).to have_content(@cust7.last_name)
    expect(page).to have_content(@cust2.last_name)
  end
end
