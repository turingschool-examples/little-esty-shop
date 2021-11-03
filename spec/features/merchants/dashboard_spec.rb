require 'rails_helper'

RSpec.describe "merchant dashboard" do
  before do
    @merchant = create(:merchant)

    @customer1 = create :customer
    @customer2 = create :customer
    @customer3 = create :customer
    @customer4 = create :customer
    @customer5 = create :customer
    @customer6 = create :customer

    @item = create :item, { merchant_id: @merchant.id }

    @invoice1 = create :invoice, { customer_id: @customer1.id, status: 'in progress' }
    @invoice2 = create :invoice, { customer_id: @customer2.id, status: 'in progress' }
    @invoice3 = create :invoice, { customer_id: @customer3.id, status: 'in progress' }
    @invoice4 = create :invoice, { customer_id: @customer4.id, status: 'in progress' }
    @invoice5 = create :invoice, { customer_id: @customer5.id, status: 'completed' }
    @invoice6 = create :invoice, { customer_id: @customer6.id, status: 'cancelled' }

    @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
    @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
    @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
    @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
    @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
    @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

    @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id}
    @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id}
    @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id}
    @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id}
    @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id}
    @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id}

    visit dashboard_merchant_path(@merchant)
  end

  it 'can show name of merchant' do
    expect(page).to have_content(@merchant.name)
  end

  it 'can link to merchant items index' do
    click_link("My Items")
    expect(current_path).to eq(merchant_items_path(@merchant))
  end

  it 'can visit merchant invoices' do
    click_link("My Invoices")
    expect(current_path).to eq(merchant_invoices_path(@merchant))
  end

  it 'i see the names of the top 5 cust (>success trans) with success trans count' do
    within("#top5") do
      within("#cust-#{@customer1.id}") do
        expect(page).to have_content(@customer1.full_name)
        expect(page).to have_content(1)
      end
    end
  end

  it 'i see a section for items ready to ship, with a link to each invoice id, and the date it was created' do
    within("#ready-to-ship") do
      within("#invoice-#{@invoice1.id}") do
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@invoice1.created_at.strftime('%A, %B%e, %Y'))

        click_link(@invoice1.id)

        expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
      end
    end
  end

  it 'the items ready to ship list is sorted from oldest to newest' do
    expect("(Invoice #{@invoice4.id})").to appear_before("(Invoice #{@invoice3.id})")
    expect("(Invoice #{@invoice2.id})").to appear_before("(Invoice #{@invoice1.id})")
    
  end
end
