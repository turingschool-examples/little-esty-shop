require 'rails_helper'

RSpec.describe "admin merchants index" do
  before do
    @merchant = create(:merchant)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant, status: 'enabled')

    @customer3 = create :customer
    @customer4 = create :customer

    @item7 = create :item, { merchant_id: @merchant1.id }
    @item8 = create :item, { merchant_id: @merchant1.id }
    @item9 = create :item, { merchant_id: @merchant2.id }
    @item10 = create :item, { merchant_id: @merchant3.id }
    @item11 = create :item, { merchant_id: @merchant4.id }

    @invoice8 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 5) }
    @invoice9 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 6) }
    @invoice10 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }
    @invoice11 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }
    @invoice12 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }

    @transaction11 = create :transaction, { invoice_id: @invoice8.id, result: 'success' }
    @transaction12 = create :transaction, { invoice_id: @invoice9.id, result: 'success' }
    @transaction13 = create :transaction, { invoice_id: @invoice10.id, result: 'success' }
    @transaction14 = create :transaction, { invoice_id: @invoice11.id, result: 'success' }
    @transaction15 = create :transaction, { invoice_id: @invoice12.id, result: 'success' }

    @inv_item11 = create :invoice_item, { item_id: @item7.id, invoice_id: @invoice8.id, unit_price: 10000, quantity: 4}
    @inv_item12 = create :invoice_item, { item_id: @item8.id, invoice_id: @invoice9.id, unit_price: 3000, quantity: 6}
    @inv_item13 = create :invoice_item, { item_id: @item9.id, invoice_id: @invoice10.id, unit_price: 300, quantity: 30}
    @inv_item14 = create :invoice_item, { item_id: @item10.id, invoice_id: @invoice11.id, unit_price: 45, quantity: 3000}
    @inv_item15 = create :invoice_item, { item_id: @item11.id, invoice_id: @invoice12.id, unit_price: 1200, quantity: 7}

    visit admin_merchants_path
  end

  it 'can visit admin merchants index and see the name of each merchant' do
    expect(current_path).to eq(admin_merchants_path)

    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
  end

  it 'can click on the name of a merchant' do
    expect(page).to have_link(@merchant.name)
    click_link "#{@merchant.name}"
    expect(current_path).to eq(admin_merchant_path(@merchant.id))
  end

  it 'has button to enable/disable merchant' do
    within("#merchant-#{@merchant.id}") do
      click_on "Enable"
      expect(page).to have_button("Disable")
    end
  end

  it 'has sections for enabled and disabled items' do
   within('#enabled') do
    expect(page).to have_content(@merchant4.name)
   end

   within('#disabled') do
     expect(page).to have_content(@merchant.name)
     expect(page).to have_content(@merchant1.name)
     expect(page).to have_content(@merchant2.name)
   end
  end

  it 'has link to create new merchant' do
    expect(page).to have_link("Add Merchant")
  end

  it 'shows top 5 merchants by revenue' do
    within("#top-five-merchants") do
      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_link(@merchant1.name)
        expect(page).to have_content('revenue generated')

        click_link(@merchant1.name, match: :first)

        expect(current_path).to eq(admin_merchant_path(@merchant1))
      end
    end
  end
end
