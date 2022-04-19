require 'rails_helper'
require 'rspec'

describe "the admin/merchants index page" do
  before (:each) do
    @targay = Merchant.create!(name: "Targay", status: 1)
    @walbart = Merchant.create!(name: "Walbart", status: 1)
    @sauer = Merchant.create!(name: "Sauer and Sons", status: 0)
  end

  describe "when I visit the admin/merchants index" do
    it "displays a list of all merchants" do
      visit "/admin/merchants"

      expect(page).to have_content("Targay")
      expect(page).to have_content("Walbart")
      expect(page).to have_content("Sauer and Sons")

    end

    it "has each name as a link to that show page" do
      visit "/admin/merchants"

      within("#merchant-#{@targay.id}") do
        click_on "Targay"
      end

      expect(current_path).to eq("/admin/merchants/#{@targay.id}")
      expect(page).to have_content("Targay")
    end

    it "displays a button to disable/enable merchant" do
      visit "/admin/merchants"

      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")
    end

    it "displays enabled merchants" do
      visit "/admin/merchants"

      within("#enabled_merchants") do
        expect(page).to have_content("Targay")
        expect(page).to have_content("Walbart")
        expect(page).to_not have_content("Sauer and Sons")
      end
    end

    it "displays disabled merchants" do
      visit "/admin/merchants"

      within("#disabled_merchants") do
        expect(page).to have_content("Sauer and Sons")
        expect(page).to_not have_content("Targay")
        expect(page).to_not have_content("Walbart")
      end
    end
  end

  describe "when I click the disable/enable button" do
    it "I am redirected back to the admin merchants index page" do
      visit "/admin/merchants"
      within("#merchant-#{@targay.id}") do
        click_on "Disable"
      end
      expect(current_path).to eq("/admin/merchants")
    end

    it "displays the merchants status has changed" do
      visit "/admin/merchants"

      within("#enabled_merchants") do
        expect(page).to have_content("Targay")
      end

      within("#disabled_merchants") do
        expect(page).to_not have_content("Targay")
      end

      within("#merchant-#{@targay.id}") do
        click_on "Disable"
      end

      within("#enabled_merchants") do
        expect(page).to_not have_content("Targay")
      end

      within("#disabled_merchants") do
        expect(page).to have_content("Targay")
      end
    end
  end

  describe "I see a link to create a new merchant" do
    it "takes me to a new page to fill out a form" do
      visit "/admin/merchants"

      click_on "Create New Merchant"

      expect(current_path).to eq("/admin/merchants/new")
    end

    it "allows me to create a new merchant" do
      visit "/admin/merchants"

      expect(page).to_not have_content("New merch")

      click_on "Create New Merchant"

      fill_in(:name, with: "New merch")

      click_on "Submit"

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("New merch")
      within("#disabled_merchants") do
        expect(page).to have_content("New merch")
      end
    end
  end

  describe "I see top 5 merchants" do
    before :each do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @merchant3 = Merchant.create!(name: "Thor")
      @merchant4 = Merchant.create!(name: "Ian")
      @merchant5 = Merchant.create!(name: "Joe")
      @merchant6 = Merchant.create!(name: "John")

      @item1 = @merchant1.items.create!(name: "Comic", description: "Spider-Man", unit_price: 200, status: 1)
      @item2 = @merchant2.items.create!(name: "Action figure", description: "Deku", unit_price: 800, status: 1)
      @item3 = @merchant2.items.create!(name: "One Piece", description: "Rare", unit_price: 500, status: 1)
      @item4 = @merchant3.items.create!(name: "Hunter card", description: "Useful", unit_price: 300, status: 1)
      @item5 = @merchant4.items.create!(name: "Kunai", description: "Minatos", unit_price: 100, status: 1)
      @item6 = @merchant5.items.create!(name: "ODM gear", description: "Advance technology", unit_price: 300, status: 1)
      @item7 = @merchant5.items.create!(name: "Zenitsu", description: "Awsome sword", unit_price: 500, status: 1)
      @item8 = @merchant6.items.create!(name: "Elucidator", description: "Kiritos sword", unit_price: 10, status: 1)

      @customer1 = Customer.create!(first_name: "Customer", last_name: "One")

      @invoice1 = @customer1.invoices.create!(status: 2)
      @invoice2 = @customer1.invoices.create!(status: 2)
      @invoice3 = @customer1.invoices.create!(status: 2)
      @invoice4 = @customer1.invoices.create!(status: 2)
      @invoice5 = @customer1.invoices.create!(status: 2)
      @invoice6 = @customer1.invoices.create!(status: 2)

      @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 5, unit_price: 200, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item2.id, quantity: 5, unit_price: 800, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item3.id, quantity: 5, unit_price: 500, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item4.id, quantity: 5, unit_price: 300, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item5.id, quantity: 5, unit_price: 500, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item6.id, quantity: 10, unit_price: 500, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item7.id, quantity: 10, unit_price: 500, status: 1)
      @ii1 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item8.id, quantity: 1, unit_price: 100, status: 1)

      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 'success', invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(credit_card_number: 230948, result: 'success', invoice_id: @invoice2.id)
      @transaction3 = Transaction.create!(credit_card_number: 234092, result: 'success', invoice_id: @invoice3.id)
      @transaction4 = Transaction.create!(credit_card_number: 230429, result: 'success', invoice_id: @invoice4.id)
      @transaction5 = Transaction.create!(credit_card_number: 102938, result: 'failed', invoice_id: @invoice5.id)
      @transaction6 = Transaction.create!(credit_card_number: 879799, result: 'success', invoice_id: @invoice6.id)

      visit "/admin"
    end

    it 'lists merchants in correct order' do
      within("#top-5-merchants") do
        expect(@merchant2.name).to appear_before(@merchant4.name)
        expect(@merchant4.name).to appear_before(@merchant3.name)
        expect(@merchant3.name).to appear_before(@merchant1.name)
        expect(@merchant1.name).to appear_before(@merchant6.name)
        expect(page).to_not have_content(@merchant5.name)
      end
    end
    it 'has link to each merchant show page' do
      within("#merchant-#{@merchant1.id}") do
        click_link "#{@merchant1.name}"
        expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
      end
    end
    it 'shows total revenue next to each merchant' do
      within("#top-5-merchants") do
        expect(page).to have_content("$#{@merchant1.total_rev/100} made")
        expect(page).to have_content("$#{@merchant2.total_rev/100} made")
        expect(page).to have_content("$#{@merchant3.total_rev/100} made")
        expect(page).to have_content("$#{@merchant4.total_rev/100} made")
        expect(page).to have_content("$#{@merchant6.total_rev/100} made")
      end
    end
  end
end
