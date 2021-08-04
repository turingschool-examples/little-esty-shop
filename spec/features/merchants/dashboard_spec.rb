require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  describe 'display' do
    it 'shows the name of the merchant and links to items and invoices index' do
      visit merchant_path(@merchant1.id)

      within('#header') do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_selector(:link_or_button, "My Invoices")
        expect(page).to have_selector(:link_or_button, "My Items")
      end
    end

    it 'show the items that are ready to ship with their invoice and date ordered by oldest first' do
      @merchant1 = Merchant.create!(name: 'Costco', status: "disabled")
      @customer1 = Customer.create!(first_name: 'Gunner', last_name: 'Runkle')
      @item1 = @merchant1.items.create!(name: 'Milk', description: 'A large quantity of whole milk', unit_price: 500)
      @invoice1 = @customer1.invoices.create!(status: 'completed', created_at: '2018-02-13 14:53:59 UTC', updated_at: '2018-02-13 14:53:59 UTC')
      @invoice2 = @customer1.invoices.create!(status: 'completed', created_at: '2015-05-25 14:53:59 UTC', updated_at: '2015-05-25 14:53:59 UTC')
      @invoice3 = @customer1.invoices.create!(status: 'completed', created_at: '2010-01-24 14:53:59 UTC', updated_at: '2010-01-24 14:53:59 UTC')
      @invoice4 = @customer1.invoices.create!(status: 'completed', created_at: '2015-05-25 14:53:59 UTC', updated_at: '2015-05-25 14:53:59 UTC')
      @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 125, unit_price: @item1.unit_price, status: 'packaged')
      @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, quantity: 250, unit_price: @item1.unit_price, status: 'pending')
      @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item1.id, quantity: 1000, unit_price: @item1.unit_price, status: 'packaged')
      @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item1.id, quantity: 500, unit_price: @item1.unit_price, status: 'shipped')
      @transaction1 = @invoice1.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      @transaction2 = @invoice2.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      @transaction3 = @invoice3.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
      @transaction4 = @invoice4.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)

      visit merchant_path(@merchant1.id)

      within('#ready_to_ship') do
        expect(page).to have_content('Items Ready to Ship')
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice2.id)
        expect(page).to have_content(@invoice3.id)
        expect("Sunday, January 24, 2010").to appear_before("Tuesday, February 13, 2018")
      end
    end
  end

  describe 'hyperlinks' do
    it 'links to merchant invoice and items index' do
      visit merchant_path(@merchant1.id)

      within('#header') do
        click_link 'My Invoices'

        expect(current_path).to eq(merchant_invoices_path(@merchant1.id))
      end

      visit merchant_path(@merchant1.id)

      within('#header') do
        click_link 'My Items'

        expect(current_path).to eq(merchant_items_path(@merchant1.id))
      end
    end
  end
end
