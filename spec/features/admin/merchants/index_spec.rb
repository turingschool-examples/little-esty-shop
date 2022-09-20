require 'rails_helper'

RSpec.describe 'admin merchant index page' do

  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Disabled')
    @merchant2 = Merchant.create!(name: "BFranklin", status: 'Enabled')
  end

  it 'can display names of all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content("Robespierre")
    expect(page).to have_content("BFranklin")
  end

  it 'can click on merchant name and be redirected to that merchants show page' do
    visit '/admin/merchants'
      click_on 'Robespierre'

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
  end

  it 'can disable a merchant' do
    visit '/admin/merchants'

    within(".merchant_#{@merchant2.id}") do
      click_on 'Disable'
    end

    expect(current_path).to eq("/admin/merchants")

    expect(page).to have_button("Enable")

  end

  it 'can enable a merchant' do
    visit '/admin/merchants'

    within(".merchant_#{@merchant2.id}") do
      click_on 'Disable'
    end

    within(".merchant_#{@merchant2.id}") do
      click_on 'Enable'
    end

    within(".merchant_#{@merchant2.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it 'can move them to the appropraite section of the page after disabling' do
    merchant = Merchant.create(name: 'Some Guy', status: 'Enabled')
    visit '/admin/merchants'

    within(".merchant_#{merchant.id}") do
      click_on 'Disable'
    end
    expect(current_path).to eq("/admin/merchants")

    within(".merchants_disabled") do
      expect(page).to have_content("#{merchant.name}")
    end
  end

  it 'can move them to the appropraite section of the page after enabling' do
    merchant = Merchant.create(name: 'Some Guy', status: 'Enabled')
    visit '/admin/merchants'

    within(".merchant_#{merchant.id}") do
      click_on 'Disable'
    end

    within(".merchant_#{merchant.id}") do
      click_on 'Enable'
    end

    within(".merchants_enabled") do
      expect(page).to have_content("#{merchant.name}")
    end
  end

  it 'can group merchants by status' do
    merchant = Merchant.create(name: 'Some Guy', status: 'Enabled')
    merchant1 = Merchant.create(name: 'Another Person', status: 'Disabled')

    visit '/admin/merchants'

    within(".merchants_enabled") do
      expect(page).to have_content("Some Guy")
      expect(page).to_not have_content("Another Person")
    end

    within(".merchants_disabled") do
      expect(page).to have_content("Another Person")
      expect(page).to_not have_content("Some Guy")
    end
  end

  it 'can use button to get to new merchant page' do
    visit '/admin/merchants'

    click_button 'Add Merchant'

    expect(current_path).to eq('/admin/merchants/new')
  end

  describe 'top five merchants' do
    before :each do
      @merchant1 = create(:merchant, status: 'Enabled')
      @merchant2 = create(:merchant, status: 'Enabled')
      @merchant3 = create(:merchant, status: 'Enabled')
      @merchant4 = create(:merchant, status: 'Enabled')
      @merchant5 = create(:merchant, status: 'Enabled')
      @merchant6 = create(:merchant, status: 'Enabled')
      @merchant7 = create(:merchant, status: 'Enabled')

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant2.id)
      @item3 = create(:item, merchant_id: @merchant3.id)
      @item4 = create(:item, merchant_id: @merchant4.id)
      @item5 = create(:item, merchant_id: @merchant5.id)
      @item6 = create(:item, merchant_id: @merchant6.id)
      @item7 = create(:item, merchant_id: @merchant7.id)

      @invoice1 = create(:invoice)
      @invoice2 = create(:invoice)
      @invoice3 = create(:invoice)
      @invoice4 = create(:invoice)
      @invoice5 = create(:invoice)
      @invoice6 = create(:invoice, created_at: Date.new(2022,3,15))
      @invoice7 = create(:invoice)
      @invoice8 = create(:invoice, created_at: Date.new(2022,9,17))

      @transaction1 = create(:transaction, result: 'success', invoice_id: @invoice1.id)
      @transaction2 = create(:transaction, result: 'success', invoice_id: @invoice2.id)
      @transaction3 = create(:transaction, result: 'success', invoice_id: @invoice3.id)
      @transaction4 = create(:transaction, result: 'success', invoice_id: @invoice4.id)
      @transaction5 = create(:transaction, result: 'success', invoice_id: @invoice5.id)
      @transaction6 = create(:transaction, result: 'success', invoice_id: @invoice6.id)
      @transaction7 = create(:transaction, result: 'failed', invoice_id: @invoice7.id)
      @transaction8 = create(:transaction, result: 'success', invoice_id: @invoice8.id)

      @invoice_item1 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 1, item_id: @item1.id, invoice_id: @invoice1.id)
      @invoice_item2 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 2, item_id: @item2.id, invoice_id: @invoice2.id)
      @invoice_item3 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 3, item_id: @item3.id, invoice_id: @invoice3.id)
      @invoice_item4 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 4, item_id: @item4.id, invoice_id: @invoice4.id)
      @invoice_item5 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 5, item_id: @item5.id, invoice_id: @invoice5.id)
      @invoice_item6 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 6, item_id: @item6.id, invoice_id: @invoice6.id)
      @invoice_item7 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 7, item_id: @item7.id, invoice_id: @invoice7.id)
      @invoice_item8 = create_list(:invoiceItem, 3, quantity: 2, unit_price: 2, item_id: @item6.id, invoice_id: @invoice8.id)

    end

    it 'can list the top five sellers' do

      visit admin_merchants_path

      expect(all(".top-five")[0].text).to have_content(@merchant6.name)
      expect(all(".top-five")[1].text).to have_content(@merchant5.name)
      expect(all(".top-five")[2].text).to have_content(@merchant4.name)
      expect(all(".top-five")[3].text).to have_content(@merchant3.name)
      expect(all(".top-five")[4].text).to have_content(@merchant2.name)
    end

    it 'links each of the top five sellers to their admin show page' do
      visit admin_merchants_path

      within("#top_5_id_#{@merchant6.id}") do
        click_on "#{@merchant6.name}"
      end
      expect(current_path).to eq(admin_merchant_path(@merchant6))
    end

    it 'displays the total revinue for each of the top five' do
      visit admin_merchants_path

      expect(all(".top-five")[0].text).to have_content("$0.66")
      expect(all(".top-five")[1].text).to have_content("$0.45")
      expect(all(".top-five")[2].text).to have_content("$0.36")
      expect(all(".top-five")[3].text).to have_content("$0.27")
      expect(all(".top-five")[4].text).to have_content("$0.18")
    end

    it 'can display the date with the highest sales' do
      visit admin_merchants_path

      expect(all(".top-five")[0].text).to have_content("Top selling date for #{@merchant6.name} was 03/15/22")
    end
  end

end
