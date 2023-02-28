require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do 
    it { should have_many :items}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices)}
    it { should define_enum_for(:status).with_values(["enabled", "disabled"]) }

    before(:each) do
      ###### Merchants & Items ######
      @merchant1 = Merchant.create!(name: "Mel's Travels")
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack", status: 1)
      @merchant3 = Merchant.create!(name: "Huy's Cheese")
      @merchant4 = Merchant.create!(name: "Beep")
      @merchant5 = Merchant.create!(name: "Ham")
      @merchant6 = Merchant.create!(name: "Mel's Beach Shack")
  
      @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
      @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
      @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)
  
      @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
      @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)
      @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant2)
      
      ###### Customers, Invoices, Invoice_Items, & Transactions ######
      @customer1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
      @invoice1 = Invoice.create!(customer: @customer1, status: 1) #completed
      @invoice2 = Invoice.create!(customer: @customer1, status: 1) #completed
      @invoice3 = Invoice.create!(customer: @customer1, status: 1) #completed
      @invoice4 = Invoice.create!(customer: @customer1, status: 1) #completed
      InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
      InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
      InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)
      InvoiceItem.create!(item: @item3, invoice: @invoice4, quantity: 1, unit_price: 1625)
      @invoice1.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice2.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice3.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice4.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
  
      #This customer has LOWEST successful transactions:
      @customer2 = Customer.create!(first_name: "Joe", last_name: "Shmow")
      @invoice5 = Invoice.create!(customer: @customer2, status: 1) #completed
      @invoice6 = Invoice.create!(customer: @customer2, status: 1) #completed
      @invoice7 = Invoice.create!(customer: @customer2, status: 1) #completed
      InvoiceItem.create!(item: @item1, invoice: @invoice5, quantity: 1, unit_price: 1800)
      InvoiceItem.create!(item: @item2, invoice: @invoice6, quantity: 1, unit_price: 4075)
      InvoiceItem.create!(item: @item3, invoice: @invoice7, quantity: 1, unit_price: 3100)
      @invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
      @invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
      @invoice7.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 0) #success
  
      @customer3 = Customer.create!(first_name: "Carmen", last_name: "SanDiego")
      @invoice8 = Invoice.create!(customer: @customer3, status: 1) #completed
      @invoice9 = Invoice.create!(customer: @customer3, status: 1) #completed
      InvoiceItem.create!(item: @item2, invoice: @invoice8, quantity: 1, unit_price: 3300)
      InvoiceItem.create!(item: @item3, invoice: @invoice9, quantity: 1, unit_price: 2525)
      @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 1) #failure
      @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success
      @invoice9.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success
  
      @customer4 = Customer.create!(first_name: "Sally", last_name: "SeaShells")
      @invoice10 = Invoice.create!(customer: @customer4, status: 1) #completed
      @invoice11 = Invoice.create!(customer: @customer4, status: 1) #completed
      InvoiceItem.create!(item: @item3, invoice: @invoice10, quantity: 1, unit_price: 10001)
      InvoiceItem.create!(item: @item1, invoice: @invoice11, quantity: 1, unit_price: 1400)
      @invoice10.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) #success
      @invoice11.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) #success
  
      @customer5 = Customer.create!(first_name: "Ludwig", last_name: "van Beethoven")
      @invoice12 = Invoice.create!(customer: @customer5, status: 1) #completed
      @invoice13 = Invoice.create!(customer: @customer5, status: 1) #completed
      InvoiceItem.create!(item: @item2, invoice: @invoice12, quantity: 1, unit_price: 1750)
      InvoiceItem.create!(item: @item3, invoice: @invoice13, quantity: 1, unit_price: 1525)
      @invoice12.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) #success
      @invoice13.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) #success
  
      @customer6 = Customer.create!(first_name: "Yukon", last_name: "Dooheet")
      @invoice14 = Invoice.create!(customer: @customer6, status: 1) #completed
      @invoice15 = Invoice.create!(customer: @customer6, status: 1) #completed
      @invoice16 = Invoice.create!(customer: @customer6, status: 1) #completed
      InvoiceItem.create!(item: @item2, invoice: @invoice14, quantity: 1, unit_price: 1500)
      InvoiceItem.create!(item: @item3, invoice: @invoice15, quantity: 1, unit_price: 1750)
      InvoiceItem.create!(item: @item1, invoice: @invoice16, quantity: 1, unit_price: 4350)
      @invoice14.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      @invoice15.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      @invoice16.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    end 

    describe "instance methods" do
      it "#mech_top_5_successful_customers" do
        expect(@merchant1.mech_top_5_successful_customers.to_a).to eq([@customer1, @customer6, @customer3, @customer4, @customer5])
      end
      
      describe '#toggle_status' do
        it 'changes merchant status to disabled if currently enabled and the inverse' do
          @merchant_1 = Merchant.create!(name: "Merchy")
          expect(@merchant_1.status).to eq("enabled")
          @merchant_1.toggle_status
          expect(@merchant_1.status).to eq("disabled")
          @merchant_1.toggle_status
          expect(@merchant_1.status).to eq("enabled")
        end
      end
    end

    describe 'class methods' do
      it '::group_by_status' do
        expect(Merchant.group_by_status("disabled")).to eq([@merchant2])
      end
    end

    describe "user stories 4 and 5" do
      before do
        @deniz = Customer.create!(first_name: "Deniz", last_name: "Ocean")
        @invoice17 = Invoice.create!(customer: @deniz, created_at: 1.days.ago, updated_at: 1.days.ago, status: 0) #in progress
        @invoice18 = Invoice.create!(customer: @deniz, created_at: 1.days.ago, updated_at: 1.days.ago, status: 0) #in progress
        @invoice19 = Invoice.create!(customer: @deniz, created_at: 4.days.ago, updated_at: 4.days.ago, status: 0) #in progress
        @ii1 = InvoiceItem.create!(item: @item4, invoice: @invoice17, quantity: 1, unit_price: 1950, status: 0) #pending
        @ii2 = InvoiceItem.create!(item: @item5, invoice: @invoice18, quantity: 1, unit_price: 2850, status: 2) #shipped (Expect NOT to see on page)
        @ii3 = InvoiceItem.create!(item: @item6, invoice: @invoice19, quantity: 1, unit_price: 1650, status: 1) #packaged
        @invoice3.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
        @invoice4.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
        @invoice5.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success

        @emre = Customer.create!(first_name: "Emre", last_name: "Bond")
        @invoice20  = Invoice.create!(customer: @emre, created_at: 3.days.ago, updated_at: 3.days.ago, status: 0) #in progress
        @ii4 = InvoiceItem.create!(item: @item4, invoice: @invoice20, quantity: 1, unit_price: 9950, status: 1) #packaged
        @ii5 = InvoiceItem.create!(item: @item5, invoice: @invoice20, quantity: 1, unit_price: 1000, status: 2) #shipped
        @invoice6.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) #success

        @serap = Customer.create!(first_name: "Serap", last_name: "Yilmaz")
        @invoice21  = Invoice.create!(customer: @serap, created_at: 2.days.ago, updated_at: 2.days.ago, status: 0) #in progress
        @ii6 = InvoiceItem.create!(item: @item4, invoice: @invoice21, quantity: 1, unit_price: 9950, status: 1) #packaged
        @ii7 = InvoiceItem.create!(item: @item5, invoice: @invoice21, quantity: 1, unit_price: 1000, status: 1) #packaged
        @invoice6.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) #success
      end

      describe "#unshipped items" do
        let(:items_not_shipped) { @merchant2.unshipped_items }

        #user story 4
        it "returns an array of unshipped items" do
          expect(items_not_shipped.first.invoice_items.first.status).to eq("packaged")
          expect(items_not_shipped.second.invoice_items.first.status).to eq("packaged")
          expect(items_not_shipped.last.invoice_items.first.status).to eq("pending")
        end
        
        #user story 5
        it "ordered from oldest to newest" do
          expect(items_not_shipped.to_a).to eq([@invoice19, @invoice20, @invoice21, @invoice21, @invoice17])
        end
      end
    end

    describe '#top_five merchants based on total revenue' do
      before(:each) do
        Transaction.delete_all
        InvoiceItem.delete_all
        Invoice.delete_all
        Item.delete_all
        Customer.delete_all
        Merchant.delete_all

        @merchant1 = Merchant.create!(name: "Mel's Travels")
        @merchant2 = Merchant.create!(name: "Hady's Beach Shack", status: 1)
        @merchant3 = Merchant.create!(name: "Huy's Cheese")
        @merchant4 = Merchant.create!(name: "Beep")
        @merchant5 = Merchant.create!(name: "Ham")
        @merchant6 = Merchant.create!(name: "Mel's Beach Shack")

        @customer1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")

        @invoice1 = Invoice.create!(customer: @customer1, status: 1, created_at: "01/01/2023".to_date) #completed
        @invoice2 = Invoice.create!(customer: @customer1, status: 1, created_at: "02/02/2023".to_date) #completed
        @invoice3 = Invoice.create!(customer: @customer1, status: 1, created_at: "10/02/2022".to_date) #completed
        @invoice4 = Invoice.create!(customer: @customer1, status: 1) #completed
        @invoice5 = Invoice.create!(customer: @customer1, status: 1) #completed
        @invoice6 = Invoice.create!(customer: @customer1, status: 1) #completed
        @invoice7 = Invoice.create!(customer: @customer1, status: 1) #completed

        @item1 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
        @item2 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant2)
        @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant3)
    
        @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant4)
        @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant5)
        @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant6)

        @ii1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1200) 
        @ii2 = InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1000) 
        @ii1 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 102) 
        @ii1 = InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 103) 
        @ii1 = InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 1, unit_price: 101) 
        @ii1 = InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 1, unit_price: 10) 
        @ii1 = InvoiceItem.create!(item: @item1, invoice: @invoice7, quantity: 1, unit_price: 10)

        @transaction1 = @invoice1.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
        @transaction2 = @invoice1.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
        @transaction3 = @invoice2.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
        @transaction4 = @invoice2.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
        @transaction5 = @invoice3.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
        @transaction6 = @invoice4.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
        @transaction7 = @invoice5.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      end

      it 'returns the top five merchants based on total revenue' do
        expected = [@merchant1, @merchant2, @merchant4, @merchant3, @merchant5]
        expect(Merchant.top_five_revenue).to eq(expected)
      end

      it 'shows the total revenue' do
        expect(@merchant1.total_revenue).to eq(2400)
      end

      it 'shows the top selling date for each merchant' do
        expect(@merchant1.top_selling_date).to eq(@invoice1)
        expect(@merchant1.top_selling_date.format_date).to eq("2023-01-01")

      end
    end
  end
end
