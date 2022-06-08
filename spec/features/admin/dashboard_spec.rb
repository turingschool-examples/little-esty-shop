require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')
    @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
    @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
    @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
    @invoice1 = @customer1.invoices.create!(status: 2, created_at: '2022-06-02 21:08:18 UTC')
    @invoice2 = @customer1.invoices.create!(status: 2, created_at: '2022-06-03 21:08:18 UTC')
    @invoice3 = @customer1.invoices.create!(status: 2, created_at: '2022-06-01 21:08:18 UTC')
    @invoice4 = @customer1.invoices.create!(status: 1)
    InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 0,
                        created_at: '2022-06-02 21:08:18 UTC')
    InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 1,
                        created_at: '2022-06-01 21:08:15 UTC')
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 5, unit_price: 1000, status: 1,
                        created_at: '2022-06-03 21:08:15 UTC')
    InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 1000, status: 2,
                        created_at: '2022-06-03 21:08:15 UTC')
  end
  it 'shows admin dashboard', :vcr do
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'shows the admin dashboard with links', :vcr do
    visit '/admin'

    click_link('Admin Merchants Index')
    expect(current_path).to eq('/admin/merchants')

    visit '/admin'

    click_link('Admin Invoices Index')
    expect(current_path).to eq('/admin/invoices')
  end

  it 'shows incomplete invoices', :vcr do
    visit '/admin'
    expect(page).to have_content('Incomplete Invoices:')

    expect(page).to have_content(@invoice1.id)

    expect(page).to have_content(@invoice2.id)

    expect(page).to have_content(@invoice3.id)

    expect(page).to_not have_content(@invoice4.id)

    click_link(@invoice1.id.to_s)

    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
  end

  it 'shows incomplete invoices sorted by least recent', :vcr do
    visit '/admin'
    expect(page).to have_content('Incomplete Invoices:')

    expect(@invoice3.id.to_s).to appear_before(@invoice1.id.to_s)

    expect(@invoice1.id.to_s).to appear_before(@invoice2.id.to_s)

    expect(page).to have_content(@invoice3.created_at.strftime('%A %B%e %Y'))

    expect(page).to have_content(@invoice2.created_at.strftime('%A %B%e %Y'))

    expect(page).to have_content(@invoice1.created_at.strftime('%A %B%e %Y'))
  end
end
