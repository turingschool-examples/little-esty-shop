require 'rails_helper'
require 'date'

RSpec.describe 'On the Merchant Invoices Show Page' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_1_item_1 = create(:item, merchant: @merchant_1)
    @merchant_1_item_2 = create(:item, merchant: @merchant_1)
    @merchant_1_item_3 = create(:item, merchant: @merchant_1)

    @merchant_2 = create(:merchant)
    @merchant_2_item_1 = create(:item, merchant: @merchant_2)

    @customer_1 = create(:customer)
    @customer_1_invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_item_1 = create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, status: 0, unit_price: 10)
    @invoice_item_2 = create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_1_item_2, quantity: 5, status: 1, unit_price: 30)
    @invoice_item_3 = create(:invoice_item, invoice: @customer_1_invoice_1, item: @merchant_2_item_1)

    @customer_2 = create(:customer)
    @customer_2_invoice_1 = create(:invoice, customer: @customer_2)
    @invoice_item_4 = create(:invoice_item, invoice: @customer_2_invoice_1, item: @merchant_1_item_1)

    visit merchant_invoice_path(@merchant_1, @customer_1_invoice_1)
  end

  describe 'When I visit /merchants/:merchant_id/invoices/:invoice_id' do
    describe 'Then I see' do
      it 'invormation related to that invoice' do
        expect(page).to have_content("Invoice # #{@customer_1_invoice_1.id}")

        within "#invoice-stats-#{@customer_1_invoice_1.id}" do
          expect(page).to have_content(@customer_1_invoice_1.status)
          expect(page).to have_content(@customer_1_invoice_1.created_at.strftime("%A, %d %B %Y"))
        end

        within "#customer-info-#{@customer_1_invoice_1.id}" do
          expect(page).to have_content(@customer_1.first_name)
          expect(page).to have_content(@customer_1.last_name)
        end
      end

      it 'only invormation related to that invoice' do
        expect(page).to_not have_content("Created at: #{@customer_2_invoice_1.id}")
      end

      it 'all the items on this invoice and their name, quanitity, price, and invoice status' do
        within "#item-info-#{@customer_1_invoice_1.id}" do
          expect(page).to have_content(@merchant_1_item_1.name)
          expect(page).to have_content(@invoice_item_1.quantity)
          expect(page).to have_content(@invoice_item_1.unit_price)

          expect(page).to have_content(@merchant_1_item_2.name)
          expect(page).to have_content(@invoice_item_2.quantity)
          expect(page).to have_content(@invoice_item_2.unit_price)

          expect(page).to_not have_content(@merchant_1_item_3.name)
        end
      end

      it 'only items for this invoice and merchant' do
        within "#item-info-#{@customer_1_invoice_1.id}" do
          expect(page).to_not have_content(@merchant_2_item_1.name)
        end
      end

      it 'total revenue for all items on invoice' do
        within "#invoice-stats-#{@customer_1_invoice_1.id}" do
          expect(page).to have_content((@invoice_item_1.unit_price * @invoice_item_1.quantity) + (@invoice_item_2.unit_price * @invoice_item_2.quantity))
        end
      end

      describe 'revenue for all items on this invoice after discounts are applyed' do
        it 'if discounts are applied, shows an invoice total revenue with applied discounts' do
          within "#item-info-#{@customer_1_invoice_1.id}" do
            expect(page).to_not have_content("Revenue After Discount:")
          end
        end

        it 'discounts are applied to invoice_items individually, not the total collectivly' do
          create(:discount, merchant: @merchant_1, quantity_threshold: 5, percentage_discount: 50)
          visit merchant_invoice_path(@merchant_1, @customer_1_invoice_1)

          within "#item-info-#{@customer_1_invoice_1.id}" do
            expect(page).to have_content("Revenue After Discount: $85.00")
          end
        end

        describe 'revenue for each item listed on the invoice' do
          before(:each) do
            @discount = create(:discount, merchant: @merchant_1, quantity_threshold: 5, percentage_discount: 25)
            visit merchant_invoice_path(@merchant_1, @customer_1_invoice_1)
          end

          it 'displays discounted price for each item on the invoice' do
            within "#item-info-#{@customer_1_invoice_1.id}" do
              expect(page).to have_content("$122.50")
              expect(page).to have_content("$22.50")
            end
          end

          it 'displays a link to the discount show page if a discout is applied' do
            within "#item-info-#{@customer_1_invoice_1.id}" do
              expect(page).to have_link("Discount # #{@discount.id}")
            end
          end

          it 'when I click on the link I am take to the discount show page' do
            within "#item-info-#{@customer_1_invoice_1.id}" do
              click_link("Discount # #{@discount.id}")
              expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount))
            end
          end
        end

        it 'if multiple discounts are avaliable to an invoice_item, only the highest amount discount is applied' do
          create(:discount, merchant: @merchant_1, quantity_threshold: 4, percentage_discount: 50)
          create(:discount, merchant: @merchant_1, quantity_threshold: 5, percentage_discount: 10)
          create(:discount, merchant: @merchant_2, quantity_threshold: 1, percentage_discount: 99)
          visit merchant_invoice_path(@merchant_1, @customer_1_invoice_1)

          within "#item-info-#{@customer_1_invoice_1.id}" do
            expect(page).to have_content("Revenue After Discount: $85.00")
          end
        end
      end

      describe 'a form to change the items status' do
        it 'that has a select field that displays the items current status' do
          within "#form-#{@merchant_1_item_1.id}" do
            expect(page).to have_select(selected: "packaged")
          end
          within "#form-#{@merchant_1_item_2.id}" do
            expect(page).to have_select(selected: "pending")
          end
        end

        it 'that allows me to select a new status and update the item by pressing "Update Item Status"' do
          within "#form-#{@merchant_1_item_1.id}" do
            select 'pending', from: 'invoice_item_status'
            click_button "Update Item Status"

            expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@customer_1_invoice_1.id}")
            expect(page).to have_select(selected: "pending")
          end
        end
      end
    end
  end
end