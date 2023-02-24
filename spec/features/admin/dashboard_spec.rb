require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Transaction.destroy_all
    InvoiceItem.destroy_all
    @merchant = Merchant.create!(name: "Carlos Jenkins") 
    @cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
    @cust2 = Customer.create!(first_name: "Bob", last_name: "Fiel")
    @cust3 = Customer.create!(first_name: "John", last_name: "Fiel")
    @cust4 = Customer.create!(first_name: "Tim", last_name: "Fiel")
    @cust5 = Customer.create!(first_name: "Linda", last_name: "Fiel")
    @cust6 = Customer.create!(first_name: "Lucy", last_name: "Fiel")
    @inv1 = @cust1.invoices.create!(status: 1)
    @inv2 = @cust2.invoices.create!(status: 1)
    @inv3 = @cust3.invoices.create!(status: 1)
    @inv4 = @cust4.invoices.create!(status: 1)
    @inv5 = @cust6.invoices.create!(status: 1)
    @inv6 = @cust5.invoices.create!(status: 0)
    @inv7 = @cust6.invoices.create!(status: 0)
    @inv8 = @cust6.invoices.create!(status: 0)
    @inv9 = @cust4.invoices.create!(status: 0)

    
    
    @bowl = @merchant.items.create!(name: "bowl", description: "it's a bowl", unit_price: 350) 
    @knife = @merchant.items.create!(name: "knife", description: "it's a knife", unit_price: 250) 
    @trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans1_5 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans3 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans4 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans5 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans6 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans7 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans8 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans9 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans10 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans11 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans12 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans13 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans14 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans15 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    @trans16 = @inv6.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, status: 2)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv2.id, status: 2)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv3.id, status: 2)
    InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv4.id, status: 2)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv5.id, status: 2)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv6.id, status: 0)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv7.id, status: 0)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv8.id, status: 1)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv9.id, status: 1)
    InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv9.id, status: 2)


    
    visit "/admin"
  end

  describe 'As a user when I visit the admin dashboard' do
    it 'I see a header indicating the admin dashboard' do 
      
      expect(page).to have_content "Admin DashBoard"
    end
    
    it 'I see links to the admin merchants index page' do
      
      click_link "Admin Merchants Index"
      expect(current_path).to eq "/admin/merchants"
    end
    
    it 'I see links to the admin invoices index page' do
      click_link "Admin Invoices Index"
      expect(current_path).to eq "/admin/invoices"
    end
    
    it 'I see the top 5 customers and their total successful transactions' do 
      expect(page).to have_content "Top Five Customers:"
      expect(page).to have_content "Lucy Fiel -- Transactions: 5"
      expect(page).to have_content "Tim Fiel -- Transactions: 4"
      expect(page).to have_content "John Fiel -- Transactions: 3"
      expect(page).to have_content "Bob Fiel -- Transactions: 2"
      expect(page).to have_content "Laura Fiel -- Transactions: 2"
    end

    it 'I see a section for "Incomplete Invoices"' do 
      within "#incomplete_invoices" do
        expect(page).to have_content "Incomplete Invoices"
      end
    end

    it 'In that section I see a list of the ids of all invoices that have items that have not yet been shipped' do
      within '#incomplete_invoices' do
        expect(page).to have_content(@inv6.id)
        expect(page).to have_content(@inv7.id)
        expect(page).to have_content(@inv8.id)
        expect(page).to have_content(@inv9.id)
      end
    end

    it "And each invoice id links to that invoice's admin show page" do
      within '#incomplete_invoices' do
        expect(page).to have_link("#{@inv6.id}")
        expect(page).to have_link("#{@inv7.id}")
        expect(page).to have_link("#{@inv8.id}")
        expect(page).to have_link("#{@inv9.id}")

        click_on "#{@inv6.id}"

        expect(page.current_path).to eq(admin_invoice_path(@inv6.id))
      end
    end
  end
end