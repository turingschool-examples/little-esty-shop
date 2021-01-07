require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  let(:merchant1) do
    create(:merchant)
  end

  describe "Displays" do
    it "the merchant name" do
      visit dashboard_merchant_path(merchant1)

      expect(page).to have_content(merchant1.name)
    end

    it "link to merchant's item index" do
      visit dashboard_merchant_path(merchant1)

      click_link "My Items"

      expect(current_path).to eq(merchant_items_path(merchant1))
    end

    it "link to merchant's invoices index" do
      visit dashboard_merchant_path(merchant1)

      click_link "My Invoices"

      expect(current_path).to eq(merchant_invoices_path(merchant1))
    end

    describe "the statistics, including:" do
      it "the top 5 customers" do
        FactoryBot.create_list(:customer, 10)
        Customer.all.each_with_index do |customer, index|
          (index + 1).times do
            invoice = create(:invoice, merchant: merchant1, customer: customer)
            create(:transaction, invoice: invoice, result: 0)
          end
        end

        Customer.order(id: :desc).each_with_index do |customer, index|
          (index + 2).times do
            invoice = create(:invoice, customer: customer)
            create(:transaction, invoice: invoice, result: 1)
          end
        end

        visit dashboard_merchant_path(merchant1)

        within "#favorite_customers" do
          best_customers = Customer.last(5)
          not_best_customers = Customer.first(5)
          best_customers.each_with_index do |customer, index|
            expect(page).to have_content(customer.name)
            expect(page).to have_content("#{index + 6} purchases")
          end
          not_best_customers.each do |customer|
            expect(page).to_not have_content(customer.name)
          end
        end
      end

      it 'items ready to ship' do
        items = create_list(:item, 6, merchant: merchant1)
        items.first(4).each do |item|
          invoice = create(:invoice, merchant: merchant1, id: item.id)
          create(:invoice_item, item: item, invoice: invoice, status: 1)
        end

        visit dashboard_merchant_path(merchant1)

        expect(page).to have_content("Items Ready to Ship")
        within "#items_to_ship" do
          ready = items.first(4)
          not_ready = items.last(2)
          ready.each_with_index do |item, index|
            within "#item-#{index}" do
              expect(page).to have_content(item.name)
              invoice = Invoice.find(item.id)
              expect(page).to have_link("Invoice ##{invoice.id}", href: merchant_invoice_path(merchant1.id, invoice.id))
              expect(page).to have_content(invoice.created_at.strftime("%A, %B %-d, %Y"))
            end
          end
          not_ready.each do |item|
            expect(page).not_to have_content(item.name)
          end
        end
      end
    end
  end
end
