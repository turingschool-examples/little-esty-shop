RSpec.describe 'Admin Invoice Show' do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 1200)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @invoice2 = create(:invoice, customer_id: @customer1.id)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id,invoice_id: @invoice1.id, quantity: 2, unit_price: 73000)
  end

  describe "when I visit my admin invoices show page" do
    it 'shows me the total revenue for each invoice show page' do
      visit "/admin/invoices/#{@invoice1.id}"
      expect(page).to have_content("150800")
    end
  end
end
