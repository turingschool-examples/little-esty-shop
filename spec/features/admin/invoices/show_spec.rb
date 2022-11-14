require "rails_helper"
require "date"

RSpec.describe "Admin Invoice show page" do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)

    @customer = create(:customer)
    feb_third = DateTime.new(2022,2,3,4,5,6)
    march_third = DateTime.new(2022,3,3,6,2,3)

    @invoice_1 = create(:invoice, customer: @customer, created_at: feb_third)
    @invoice_2 = create(:invoice, customer: @customer, created_at: march_third)

    @invoice_1_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 4)
    @invoice_1_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 15)
    @invoice_1_item_3 = create(:invoice_item, invoice: @invoice_2, item: @item_3)
  end

  describe "As an admin, when I visit admin/invoices/:id" do
    it "shows information related to that invoice including, id, status, created_at date, and Customer first and last name" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Status:")
      expect(page).to have_content("Created on: Thursday, February 03, 2022")
      expect(page).to have_content("Customer:")
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end

    it "lists all the items on the invoice including: item name, quantity, price, and the Invoice Item status" do
      visit admin_invoice_path(@invoice_1)

      within "#items-details" do
        expect(page).to have_content("Items on this Invoice:")
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Quantity")
        expect(page).to have_content("Unit Price")
        expect(page).to have_content("Status")

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@invoice_1_item_1.quantity)
        expect(page).to have_content(@invoice_1_item_1.unit_price)
        expect(page).to have_content(@invoice_1_item_1.status)

        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@invoice_1_item_2.quantity)
        expect(page).to have_content(@invoice_1_item_2.unit_price)
        expect(page).to have_content(@invoice_1_item_2.status)
      end
    end

    it "displays the invoice status as a select field, with the current status selected" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_select("invoice_status")
      expect(page).to have_select(selected: @invoice_1.status)
      expect(page).to have_button("Update Invoice Status")
    end

    it "when I click Update Invoice Status, the admin invoice show page reloads and see the status has been updated" do
      visit admin_invoice_path(@invoice_1)

      select 'Completed', from: 'invoice_status'
      click_button("Update Invoice Status")

      expect(current_path).to eq(admin_invoice_path(@invoice_1))
      expect(page).to have_select(selected: "Completed")
    end
  end

  describe 'As an admin, when I visit an admin invoice show page' do
    it 'I see the total revenue that will be generated from this invoice' do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Total Revenue: $#{(@invoice_1_item_1.unit_price * @invoice_1_item_1.quantity) + (@invoice_1_item_2.unit_price * @invoice_1_item_2.quantity)}")
    end
  end

  describe 'revenue for all items on this invoice after discounts are applyed' do
    before(:each) do
      visit admin_invoice_path(@invoice_1)
    end

    it 'if discounts are applied, shows an invoice total revenue with applied discounts' do
      within "#items-details" do
        expect(page).to_not have_content("Revenue After Discount:")
      end
    end

    it 'discounts are applied to invoice_items individually, not the total collectivly' do
      create(:discount, merchant: @merchant, quantity_threshold: 2, percentage_discount: 25)
      visit admin_invoice_path(@invoice_1)

      within "#items-details" do
        expect(page).to have_content("Revenue After Discount: $26.50")
      end
    end

    describe 'revenue for each item listed on the invoice' do
      before(:each) do
        @discount = create(:discount, merchant: @merchant, quantity_threshold: 2, percentage_discount: 25)
        visit admin_invoice_path(@invoice_1)
      end

      it 'displays discounted price for each item on the invoice' do
        within "#items-details" do
          expect(page).to have_content("$11.25")
        end
      end

      it 'displays a link to the discount show page if a discout is applied' do
        within "#items-details" do
          expect(page).to have_link("Discount # #{@discount.id}")
        end
      end

      it 'when I click on the link I am take to the discount show page' do
        within "#items-details" do
          click_link("Discount # #{@discount.id}")
          expect(current_path).to eq(merchant_discount_path(@merchant, @discount))
        end
      end
    end

    it 'if multiple discounts are avaliable to an invoice_item, only the highest amount discount is applied' do
      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2, unit_price: 10)
      create(:invoice_item, invoice: @invoice_1, item: item_2, quantity: 2, unit_price: 10, status: 2)

      create(:discount, merchant: @merchant, quantity_threshold: 2, percentage_discount: 25)
      create(:discount, merchant: @merchant, quantity_threshold: 2, percentage_discount: 10)
      create(:discount, merchant: merchant_2, quantity_threshold: 1, percentage_discount: 90)
      visit admin_invoice_path(@invoice_1)

      within "#items-details" do
        expect(page).to have_content("Revenue After Discount: $28.50")
      end
    end
  end
end