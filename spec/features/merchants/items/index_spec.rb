require 'rails_helper'

RSpec.describe "merchant's item index page" do
  before(:each) do
    @merchant = create :merchant
    @merchant2 = create :merchant

    @item1 = create :item, { merchant_id: @merchant.id }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant.id }
    @item4 = create :item, { merchant_id: @merchant.id }
    @item5 = create :item, { merchant_id: @merchant.id }
    @item6 = create :item, { merchant_id: @merchant.id }
    @item7 = create :item, { merchant_id: @merchant2.id }

    @customer1 = create :customer
    @customer2 = create :customer
    @customer3 = create :customer
    @customer4 = create :customer
    @customer5 = create :customer
    @customer6 = create :customer

    @invoice1 = create :invoice, { customer_id: @customer1.id }
    @invoice2 = create :invoice, { customer_id: @customer2.id }
    @invoice3 = create :invoice, { customer_id: @customer3.id }
    @invoice4 = create :invoice, { customer_id: @customer4.id }
    @invoice5 = create :invoice, { customer_id: @customer5.id }
    @invoice6 = create :invoice, { customer_id: @customer6.id }

    @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
    @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
    @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
    @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
    @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
    @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }


    @inv_item1 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice1.id, unit_price: 10000, quantity: 1}
    @inv_item2 = create :invoice_item, { item_id: @item2.id, invoice_id: @invoice1.id, unit_price: 9000, quantity: 1}
    @inv_item3 = create :invoice_item, { item_id: @item3.id, invoice_id: @invoice2.id, unit_price: 8000, quantity: 1}
    @inv_item4 = create :invoice_item, { item_id: @item4.id, invoice_id: @invoice2.id, unit_price: 7000, quantity: 1}
    @inv_item5 = create :invoice_item, { item_id: @item5.id, invoice_id: @invoice2.id, unit_price: 6000, quantity: 1}
    @inv_item6 = create :invoice_item, { item_id: @item6.id, invoice_id: @invoice3.id, unit_price: 10000000, quantity: 1}
    @inv_item7 = create :invoice_item, { item_id: @item6.id, invoice_id: @invoice4.id, unit_price: 10000000, quantity: 1}

    visit merchant_items_path(@merchant)
  end

  it 'i see a list of names of all items' do
    expect(current_path).to eq(merchant_items_path(@merchant))

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).not_to have_content(@item7.name)
  end

  it 'has names as links' do
    click_link(@item1.name, match: :first)

    expect(current_path).to eq(merchant_item_path(@merchant, @item1))
  end

  it 'has a button next to item to enable/disable' do
    within("#disabled") do
      within("#item-#{@item1.id}") do
        click_button 'Enable'
      end
    end
    within("#enabled") do
      within("#item-#{@item1.id}") do
        expect(page).to have_button('Disable')
      end
    end

  end

  it 'shows top 5 most popular items' do
    within("#top-five-items") do
      within("#item-#{@item1.id}") do
        expect(page).to have_link(@item1.name)
        expect(page).to have_content('revenue generated')
        expect(page).to have_content('Top selling date')

        click_link(@item1.name, match: :first)

        expect(current_path).to eq(merchant_item_path(@merchant, @item1))
      end
    end
  end
end
