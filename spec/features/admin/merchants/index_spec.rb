require 'rails_helper'

RSpec.describe "As an admin" do
  describe 'when I visit the admin merchants index' do
    before :each do
      @merchant1 = create(:merchant, status: true)
      @merchant2 = create(:merchant, status: true)
      @merchant3 = create(:merchant, status: false)
      @merchant4 = create(:merchant, status: false)
      @merchant5 = create(:merchant, status: true)
      @merchant6 = create(:merchant, status: true)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant2.id)
      @item3 = create(:item, merchant_id: @merchant3.id)
      @item4 = create(:item, merchant_id: @merchant4.id)
      @item5 = create(:item, merchant_id: @merchant5.id)
      @item6 = create(:item, merchant_id: @merchant6.id)

      @invoice1 = create(:invoice)
      @invoice2 = create(:invoice)
      @invoice3 = create(:invoice)
      @invoice4 = create(:invoice)
      @invoice5 = create(:invoice)
      @invoice6 = create(:invoice)

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 5, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 15, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 9, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 10, unit_price: 100)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item5.id, status: 0, quantity: 2, unit_price: 100)
      @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item6.id, status: 2, quantity: 11, unit_price: 100)

      @transactions = create_list(:transaction, 6, invoice_id: @invoice_item1.invoice.id, result: 0)
      @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: 0)
      @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: 0)
      @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: 0)
      @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: 0)
      @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: 1)

      visit admin_merchants_path
    end

    it 'can show the name of each merchant in the system' do

      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
      expect(page).to have_content(@merchant4.name)
      expect(page).to have_content(@merchant5.name)
      expect(page).to have_content(@merchant6.name)
    end

    it "has links to take me to a merchant's show page" do
      within("#admin_merchants-#{@merchant1.id}") do
        click_on("Link to #{@merchant1.name}")
      end

      expect(current_path).to eq(admin_merchant_path("#{@merchant1.id}"))
    end

    it "Then next to each merchant name I see a button to disable or enable that merchant." do
      within("#admin_merchants-#{@merchant4.id}") do
        expect(page).to have_button("Enable")
       end

       within("#admin_merchants-#{@merchant1.id}") do
        expect(page).to have_button("Disable")
      end
    end

    it "When I click this button I am redirected back to the admin merchants index" do
      within("#admin_merchants-#{@merchant1.id}") do
       click_button("Disable")
      end
      expect(current_path).to eq(admin_merchants_path)

      within("#disabled_merchants") do
        expect(page).to have_content(@merchant1.name)
      end

      within("#enabled_merchants") do
        expect(page).to_not have_content(@merchant1.name)
      end
    end

    it "Shows top merchants ordered from desc" do
      within(".top_five_merchants") do
        expect(@merchant2.name).to appear_before(@merchant4.name)
        expect(@merchant4.name).to appear_before(@merchant3.name)
        expect(@merchant3.name).to appear_before(@merchant1.name)
        expect(@merchant1.name).to appear_before(@merchant5.name)
      end
    end

    it "shows label and the date with the most revenue for top 5 merchant." do
      within("#top_five_merchants-#{@merchant1.id}") do
        expect(page).to have_content("Top selling date for #{@merchant1.name} was #{@merchant1.best_day}")
      end

      within("#top_five_merchants-#{@merchant2.id}") do
        expect(page).to have_content("Top selling date for #{@merchant2.name} was #{@merchant2.best_day}")
      end
    end

    it "It has a  link to create a new merchant." do
      expect(page).to have_link("Create New Merchant")
    end

    it "When I click on the link, I am taken to a form that allows me to add merchant information." do
      click_on 'Create New Merchant'

      expect(current_path).to eq(new_admin_merchant_path)
    end
  end
end
