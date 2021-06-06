require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page' do
  before :each do
    # enabled
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)
    # disabled
    @merchant4 = Merchant.create!(name: "Johnny", status: 0)
    @merchant5 = Merchant.create!(name: "Carrot Top", status: 0)
    @merchant6 = Merchant.create!(name: "lil boosie", status: 0)

    @item1 = @merchant1.items.create!(name: "socks", description: "soft", unit_price: 3.00, status: 0)
    @item2 = @merchant2.items.create!(name: "watch", description: "bling-blang", unit_price: 400.00, status: 0)
    @item3 = @merchant3.items.create!(name: "skillet", description: "HOT!", unit_price: 45.00, status: 0)
    @item4 = @merchant4.items.create!(name: "3 Pack of Shirts", description: "comfy", unit_price: 18.00, status: 0)
    @item5 = @merchant5.items.create!(name: "shoes", description: "woah, fast boi!", unit_price: 67.00, status: 0)
    @item6 = @merchant6.items.create!(name: "dress", description: "brown-chicken-black-cow", unit_price: 250.00, status: 0)

    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 2)
    @invoice3 = @customer1.invoices.create!(status: 2)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607)

    @transaction5 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction6 = @invoice3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @invoice_item1 = @item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 2, invoice: @invoice1)
    @invoice_item2 = @item2.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 2, invoice: @invoice1)
    @invoice_item3 = @item3.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 2, invoice: @invoice2)
    @invoice_item4 = @item4.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 2, invoice: @invoice2)
    @invoice_item5 = @item5.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: @invoice3)
    @invoice_item6 = @item6.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: @invoice3)

    visit admin_merchants_path
  end

  it "I click on the name of a merchant, which is a link that takes me to that merchant's admin show page" do
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)

    click_link "#{@merchant1.name}"

    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_content(@merchant1.name)
    expect(page).to_not have_content(@merchant2.name)
    expect(page).to_not have_content(@merchant3.name)
  end

  it "I see the name of each merchant in their respective category of either 'Enabled' or 'Disabled'."  do
    expect(current_path).to eq(admin_merchants_path)
    # enabled
    within "#enabled-merchant-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
    end

    within "#enabled-merchant-#{@merchant2.id}" do
      expect(page).to have_content(@merchant2.name)
    end

    within "#enabled-merchant-#{@merchant3.id}" do
      expect(page).to have_content(@merchant3.name)
    end

    # disabled
    within "#disabled-merchant-#{@merchant4.id}" do
      expect(page).to have_content(@merchant4.name)
    end

    within "#disabled-merchant-#{@merchant5.id}" do
      expect(page).to have_content(@merchant5.name)
    end

    within "#disabled-merchant-#{@merchant6.id}" do
      expect(page).to have_content(@merchant6.name)
    end
  end

  it "I can click a button to enable or disable a merchants status" do
    # enabled
    within "#enabled-merchant-#{@merchant1.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Disable')

      click_button 'Disable'
    end

    within ".disbaled-merchants" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Enable')
    end


    # disabled
    within "#disabled-merchant-#{@merchant4.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Enable')

      click_button 'Enable'
    end

    within "#enabled-merchant-#{@merchant4.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Disable')
    end
  end

  it "I see a link to create a new merchant." do
    expect(page).to have_link('Create New Merchant', href: new_admin_merchant_path)
  end

  it "I see the names of the top 5 merchants and each name is a link to that merchants show page" do
    within "#top-rev-merchants-#{@merchant6.id}" do
      expect(page).to have_link("#{@merchant6.name}", href: admin_merchant_path(@merchant6))
    end

    within "#top-rev-merchants-#{@merchant2.id}" do
      expect(page).to have_link("#{@merchant2.name}", href: admin_merchant_path(@merchant2))
    end

    within "#top-rev-merchants-#{@merchant3.id}" do
      expect(page).to have_link("#{@merchant3.name}", href: admin_merchant_path(@merchant3))
    end

    within "#top-rev-merchants-#{@merchant5.id}" do
      expect(page).to have_link("#{@merchant5.name}", href: admin_merchant_path(@merchant5))
    end

    within "#top-rev-merchants-#{@merchant4.id}" do
      expect(page).to have_link("#{@merchant4.name}", href: admin_merchant_path(@merchant4))
    end
  end

  it "I see the total revenue generated next to each merchant name" do
    within "#top-rev-merchants-#{@merchant6.id}" do
      expect(page).to have_content('$2,000.00 in sales')
    end

    within "#top-rev-merchants-#{@merchant2.id}" do
      expect(page).to have_content('$1,600.00 in sales')
    end

    within "#top-rev-merchants-#{@merchant3.id}" do
      expect(page).to have_content('$270.00 in sales')
    end

    within "#top-rev-merchants-#{@merchant5.id}" do
      expect(page).to have_content('$268.00 in sales')
    end

    within "#top-rev-merchants-#{@merchant4.id}" do
      expect(page).to have_content('$180.00 in sales')
    end
  end

  it "I see the date with the most revenue for each merchant and it looks like 'Top selling date for <merchant name> was <date with most sales>'." do

    within "#top-rev-merchants-#{@merchant6.id}" do
      expect(page).to have_content("Top selling date for #{@merchant6.name} was #{@merchant6.merchant_best_day}")
    end

    within "#top-rev-merchants-#{@merchant2.id}" do
      expect(page).to have_content("Top selling date for #{@merchant2.name} was #{@merchant2.merchant_best_day}")
    end

    within "#top-rev-merchants-#{@merchant3.id}" do
      expect(page).to have_content("Top selling date for #{@merchant3.name} was #{@merchant3.merchant_best_day}")
    end

    within "#top-rev-merchants-#{@merchant5.id}" do
      expect(page).to have_content("Top selling date for #{@merchant5.name} was #{@merchant5.merchant_best_day}")
    end

    within "#top-rev-merchants-#{@merchant4.id}" do
      expect(page).to have_content("Top selling date for #{@merchant4.name} was #{@merchant4.merchant_best_day}")
    end
  end
end
