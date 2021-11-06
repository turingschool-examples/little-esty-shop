require 'rails_helper'

RSpec.describe "admin merchants" do
  before do
    @merchant = create(:merchant)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant, status: 'disabled')

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
      click_on "Disable"
      expect(page).to have_button("Enable")
    end
 end

 it 'has sections for enabled and disabled items' do
   within('#enabled') do
     expect(page).to have_content(@merchant.name)
     expect(page).to have_content(@merchant1.name)
     expect(page).to have_content(@merchant2.name)
   end

   within('#disabled') do
     expect(page).to have_content(@merchant4.name)
   end
 end
end
