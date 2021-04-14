RSpec.describe 'Merchant Invoice Index' do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice_items1 = create(
      :invoice_item, item_id: @item1.id,
      invoice_id: @invoice1.id
    )
    @item2 = create(:item, merchant_id: @merchant1.id)
    @customer2 = create(:customer)
    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice_items2 = create(
      :invoice_item, item_id: @item2.id,
      invoice_id: @invoice2.id
    )
  end

  describe "when I visit my merchant's invoices show page" do
    it 'it shows me the attributes: id, status, created_at, and customer full name' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      binding.pry

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at)
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end
  end
end
