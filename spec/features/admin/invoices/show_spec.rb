require 'rails_helper'

RSpec.describe "Admin Invoice Show Page" do
  describe "As an admin" do
    describe "I visit an admin invoice show page" do
      before :each do
        @items_1 = create_list(:item, 10)
        @items_2 = create_list(:item, 10)
        @items_3 = create_list(:item, 10)
        @items_4 = create_list(:item, 10)
      
        @invoice_1 = create(:invoice)
        @invoice_2 = create(:invoice)
        @invoice_3 = create(:invoice)
        @invoice_4 = create(:invoice)

        @items_1.each { |item| create(:invoice_items, invoice_id: @invoice_1.id, item_id: item.id) }
        # @items_2.each { |item|  @invoice_2.items << item }
        # @items_3.each { |item|  @invoice_3.items << item }
        # @items_4.each { |item|  @invoice_4.items << item }
      end

      it 'I see information related to that invoice including: id, status, created_at date (format "Monday, July 18, 2019") and Customer First+Last name' do
        visit admin_invoice_path(@invoice_1)

        within("#invoice-details-#{@invoice_1.id}") do
          expect(page).to have_content("Invoice ##{@invoice_1.id}")
          expect(page).to have_content("Status: #{@invoice_1.status}")
          expect(page).to have_content("Created On: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
          expect(page).to have_content("#{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
        end
        
        expect(page).to_not have_content("Invoice ##{@invoice_3.id}")
        expect(page).to_not have_content("#{@invoice_3.customer.first_name} #{@invoice_3.customer.last_name}")
      end

      it "I see all of the items on the invoice including: Item name, quantity ordered, price Item sold for, Item status" do
        visit admin_invoice_path(@invoice_1)

        within("#invoice-items") do
          @invoice_1.items.each do |item|
            expect(page).to have_content(item.name)
            expect(page).to have_content(item.invoice_items.find_by(@invoice_1.id).quantity)
            expect(page).to have_content(item.invoice_items.find_by(@invoice_1.id).unit_price)
            expect(page).to have_content(item.invoice_items.find_by(@invoice_1.id).status)
          end
        end
      end

    end
  end
end