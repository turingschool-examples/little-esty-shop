require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)

    @customers = []
    10.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end

    @invoice_1 = @customers.first.invoices.first
    @invoice_2 = @customers.second.invoices.first
    @invoice_3 = @customers.third.invoices.first
    @invoice_4 = @customers.fourth.invoices.first
    @invoice_5 = @customers.fifth.invoices.first
    @invoice_6 = @customers[5].invoices.first
    @invoice_7 = @customers[6].invoices.first

    9.times {create(:transaction, invoice_id: @invoice_1.id, result: 0)}
    8.times {create(:transaction, invoice_id: @invoice_2.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_3.id, result: 0)}
    6.times {create(:transaction, invoice_id: @invoice_4.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_5.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_6.id, result: 1)}
    10.times {create(:transaction, invoice_id: @invoice_7.id, result: 1)}

    @invoice_item_1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_3.id, status: 1)
    @invoice_item_4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_4.id, status: 2)
    @invoice_item_5 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_5.id, status: 0)
  end

  describe "When I visit my merchant dashboard (/merchant/merchant_id/dashboard)" do
    it "can see the name of my merchant"do

     visit "/merchant/#{@merchant1.id}/dashboard"

      expect(page).to have_content(@merchant1.name)
    end

    it "Then I see the names of the top 5 customers with the largest number of successful transactions" do

      visit "/merchant/#{@merchant1.id}/dashboard"

      within "#top-five-customers" do
        expect(page).to have_content("Favorite Customers")
        expect(page).to have_content(@invoice_1.customer.name)
        expect(page).to have_content(@invoice_2.customer.name)
        expect(page).to have_content(@invoice_3.customer.name)
        expect(page).to have_content(@invoice_4.customer.name)
        expect(page).to have_content(@invoice_5.customer.name)
        expect(page).to_not have_content(@invoice_6.customer.name)
        expect(@customers.first.name).to appear_before(@customers.fifth.name)
        expect(@customers.first.name).to appear_before(@customers.second.name)
        expect(@customers.fourth.name).to appear_before(@customers.fifth.name)
      end
    end
    it "I see a section for 'Items Ready to Ship'" do
      visit "/merchant/#{@merchant1.id}/dashboard"
      within "#items-ready-to-ship" do
        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_3.id)
        expect(page).to have_content(@invoice_5.id)
        expect(page).to_not have_content(@invoice_4.id)
      end
    end

    it "can display the invoices with the date created at" do
      visit "/merchant/#{@merchant1.id}/dashboard"

      within "#items-ready-to-ship" do
        expected = @invoice_1.created_at.strftime('%A, %B %d, %Y')

        expect(page).to have_content(expected)
      end
    end

    # it "orders the invoices by created at date from oldest to newest" do
    #   visit "/merchant/#{@merchant1.id}/dashboard"
    #
    #   within "#items-ready-to-ship" do
    #     that = "#{@item1.name} - Invoice##{@invoice_1.id} - #{@invoice_1.date_format}"
    #     this = "#{@item2.name} - Invoice##{@invoice_3.id} - #{@invoice_3.date_format}"
    #
    #     this.should appear_before(that)
    #   end
    # end
  end
end
