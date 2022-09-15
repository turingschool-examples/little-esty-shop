require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  describe 'When I visit an admin invoice show page' do
    before :each do 
      @customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      @invoice = @customer.invoices.create!(status: 'in progress')
    end

    it 'I see the invoice ID' do
      visit admin_invoice_path(@invoice.id)
      expect(page).to have_content(@invoice.id)
    end

    it 'I see the created_at date in the format "Thursday, July 18, 2019"' do
      allow_any_instance_of(Invoice).to receive(:created_at).and_return(Date.new(2019,7,18))
      invoice = @customer.invoices.create!(status: 'in progress')
      visit admin_invoice_path(invoice.id)
      expect(page).to have_content('Thursday, July 18, 2019')
    end

    it 'I see customer first and last name' do
      visit admin_invoice_path(@invoice.id)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end

    describe 'Invoice Item Information' do
      before :each do
        merchant = Merchant.create!(name: "Stephen's Shady Store")

        @item_toothpaste = merchant.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
        @item_rock = merchant.items.create!(name: "Item Rock", description: "Decently cool rock", unit_price: 10000 )
        @item_lamp = merchant.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 3 )
        @invoice_toothpaste = @invoice.invoice_items.create!(item_id: @item_toothpaste.id, 
                                                             quantity: 1,
                                                             unit_price: 6000,
                                                             status: :pending)
        @invoice_lamp = @invoice.invoice_items.create!(item_id: @item_lamp.id,
                                                       quantity: 2,
                                                       unit_price: 6,
                                                       status: :packaged)
        @invoice_rock = @invoice.invoice_items.create!(item_id: @item_rock.id,
                                                       quantity: 3,
                                                       unit_price: 12000,
                                                       status: :shipped)
      end

      it 'Has all the item names on the invoice' do
        visit admin_invoice_path(@invoice.id)
        expect(page).to have_content(@item_lamp.name)
        expect(page).to have_content(@item_rock.name)
        expect(page).to have_content(@item_toothpaste.name)
      end

      it 'has the quantity of the item ordered' do
        visit admin_invoice_path(@invoice.id)
        within "#invoice_item-#{@invoice_toothpaste.id}-quantity" do
          expect(page).to have_content(1)
        end
        within "#invoice_item-#{@invoice_rock.id}-quantity" do
          expect(page).to have_content(3)
        end
        within "#invoice_item-#{@invoice_lamp.id}-quantity" do
          expect(page).to have_content(2)
        end
      end

      it 'as the price the item sold for' do
        visit admin_invoice_path(@invoice.id)
        within "#invoice_item-#{@invoice_toothpaste.id}-price" do
          expect(page).to have_content('$60.00')
        end
        within "#invoice_item-#{@invoice_rock.id}-price" do
          expect(page).to have_content('$120.00')
        end
        within "#invoice_item-#{@invoice_lamp.id}-price" do
          expect(page).to have_content('$0.06')
        end
        
      end

      it 'has the invoice item status' do
        visit admin_invoice_path(@invoice.id)
        within "#invoice_item-#{@invoice_toothpaste.id}-status" do
          expect(page).to have_content(@invoice_toothpaste.status.capitalize)
        end
        within "#invoice_item-#{@invoice_rock.id}-status" do
          expect(page).to have_content(@invoice_rock.status.capitalize)
        end
        within "#invoice_item-#{@invoice_lamp.id}-status" do
          expect(page).to have_content(@invoice_lamp.status.capitalize)
        end
      end
    end

    it 'US 36 Total revenue generated from an invoice' do
      allow_any_instance_of(Invoice).to receive(:total_revenue).and_return(1299.to_f)
      invoice = @customer.invoices.create!(status: 'in progress')
      visit admin_invoice_path(invoice.id)
      expect(page).to have_content('Total Revenue: $12.99')
    end

    it 'US 37 Update Invoice Status' do
      invoice = @customer.invoices.create!(status: 'in progress')
      visit admin_invoice_path(invoice.id)
      expect(invoice.status).to eq('in progress')
      select('Completed', from: 'Status')
      click_button 'Update Invoice Status'
      expect(current_path).to eq(admin_invoice_path(invoice.id))
      expect(invoice.reload.status).to eq('completed')
    end
  end
end