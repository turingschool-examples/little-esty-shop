require 'rails_helper'
RSpec.describe 'merchant selection page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Merchant A")
    @merchant_2 = Merchant.create!(name: "Merchant B")
    @merchant_3 = Merchant.create!(name: "Merchant C")
    @merchant_4 = Merchant.create!(name: "Merchant D")
    @merchant_5 = Merchant.create!(name: "Merchant E")
    @merchant_6 = Merchant.create!(name: "Merchant F")
    visit "/merchants"
  end
  it 'lists the name of each merchant alphabetically' do
    expect(@merchant_1.name).to appear_before(@merchant_2.name)
    expect(@merchant_2.name).to appear_before(@merchant_3.name)
    expect(@merchant_3.name).to appear_before(@merchant_4.name)
    expect(@merchant_4.name).to appear_before(@merchant_5.name)
    expect(@merchant_5.name).to appear_before(@merchant_6.name)
  end

  it 'has a button next to each merchant that takes the user to the dashboard for that merchant' do
    within "#merchant-#{@merchant_1.id}" do
      expect(page).to have_button("Go To Dashboard")
    end
    within "#merchant-#{@merchant_2.id}" do
      expect(page).to have_button("Go To Dashboard")
    end
    within "#merchant-#{@merchant_3.id}" do
      expect(page).to have_button("Go To Dashboard")
    end
    within "#merchant-#{@merchant_4.id}" do
      expect(page).to have_button("Go To Dashboard")
    end
    within "#merchant-#{@merchant_5.id}" do
      expect(page).to have_button("Go To Dashboard")
    end
    within "#merchant-#{@merchant_6.id}" do
      expect(page).to have_button("Go To Dashboard")
    end
  end
  
  it 'takes the user to the dashboard for that merchant when the button is clicked' do
    within "#merchant-#{@merchant_1.id}" do
      click_button("Go To Dashboard")
    end
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/dashboard")
  end
end
