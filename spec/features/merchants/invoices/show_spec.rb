RSpec.describe 'Merchant Invoice Index' do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id, status: 0)
    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 1200)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @invoice2 = create(:invoice, customer_id: @customer1.id, status: 0)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id,invoice_id: @invoice1.id, quantity: 2, unit_price: 73000)
  end

  describe "when I visit my merchant's invoices show page" do
    it 'shows me the attributes: id, status, created_at, and customer full name' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end

    it 'shows me the total revenue for each invoice show page' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("150800")
    end

    it 'can show me a list of all items on that invoice, including name, quantity, price, status' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.invoice_items.first.quantity)
      expect(page).to have_content(@item1.invoice_items.first.status)
      # expect(page).to have_content(@item1.unit_price)
    end
  end

  describe "you can update the merchant invoice status" do
    it 'Invoive has a select field with the current invoice selected' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@invoice1.status)
    end

    it 'I can select a new status for the Invoice and it updates on the Merchant Invoice Show Page' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
      save_and_open_page

      within "#invoice-item-#{@item1.id}" do
        expect(page).to have_button("Update Item Status")

        select("packaged", from: "status")
        click_on "Update Item Status"
      end

      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))

      within "#invoice-item-#{@item1.id}" do
        expect(page).to have_content("Status: packaged")
      end
    end
  end
end
