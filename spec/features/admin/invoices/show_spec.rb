require 'rails_helper'

describe "Admin Invoice Show Page" do
  describe "As an admin" do
    describe "When I visit an admin invoice show page" do
      describe 'I see information related to that invoice including' do
        before :each do
          w = Date.new(2019, 7, 18)
          @cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
          @inv1 = @cust1.invoices.create!(status: 1, created_at: w)
        end

        it 'Invoice ID' do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content(@inv1.id)
        end

        it "Invoice Status" do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content(@inv1.status)
        end

        it "Invoice created_at date in the format 'Monday, July 18, 2019'" do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content("Thursday, July 18, 2019")

        end

        it "Customer first and last name" do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content(@cust1.first_name)
          expect(page).to have_content(@cust1.last_name)
        end
      end

      describe "I see all of the items on the invoice including" do
        before :each do
          w = Date.new(2019, 7, 18)
          @merchant = Merchant.create!(name: "Carlos Jenkins") 
          @cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
          @inv1 = @cust1.invoices.create!(status: 1, created_at: w)
          @bowl = @merchant.items.create!(name: "bowl", description: "it's a bowl", unit_price: 350) 
          @knife = @merchant.items.create!(name: "knife", description: "it's a knife", unit_price: 250) 

          @invit1 = InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, status: 2, quantity: 10 , unit_price: 2222)
          @invit2 = InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, status: 2, quantity: 1, unit_price: 6654)
          @invit3 = InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, status: 2, quantity: 4, unit_price: 8765)
          @invit4 = InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id, status: 2, quantity: 2, unit_price: 4567)
          @invit5 = InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id, status: 2, quantity: 6, unit_price: 2050)

          visit "/admin/invoices/#{@inv1.id}"
        end

        it 'I see items including item name, quantity of item ordered, sell price, and status' do
          within '#invoice_items' do
            expect(page).to have_content("bowl", :count => 3)
            expect(page).to have_content("knife", :count => 2)
          end
        end

        it 'has quantity of item ordered' do
          within "##{@invit1.id}" do
            expect(page).to have_content(10)
          end
          within "##{@invit2.id}" do
            expect(page).to have_content(1)
          end
          within "##{@invit3.id}" do
            expect(page).to have_content(4)
          end
          within "##{@invit4.id}" do
            expect(page).to have_content(2)
          end
          within "##{@invit5.id}" do
            expect(page).to have_content(6)
          end
        end
        
        it 'has item sell price' do
          within "##{@invit1.id}" do
            expect(page).to have_content("$22.22")
          end
          within "##{@invit2.id}" do
            expect(page).to have_content("$66.54")
          end
          within "##{@invit3.id}" do
            expect(page).to have_content("$87.65")
          end
          within "##{@invit4.id}" do
            expect(page).to have_content("$45.67")
          end
          within "##{@invit5.id}" do
            expect(page).to have_content("$20.50")
          end
        end

        it 'has item status' do
          within "##{@invit1.id}" do
            expect(page).to have_content("shipped")
          end
          within "##{@invit2.id}" do
            expect(page).to have_content("shipped")
          end
          within "##{@invit3.id}" do
            expect(page).to have_content("shipped")
          end
          within "##{@invit4.id}" do
            expect(page).to have_content("shipped")
          end
          within "##{@invit5.id}" do
            expect(page).to have_content("shipped")
          end
        end
      end
    end
  end
end