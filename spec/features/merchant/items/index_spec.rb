require 'rails_helper'

RSpec.describe "Merchant Item Index Page" do
  before(:each) do
    @merchant = Merchant.create!(name: "Harrison")
    @item_1 = @merchant.items.create!(name: "apple",
                                     description: "one a day keeps the doctor away!",
                                     unit_price: 22.09)
    @item_2 = @merchant.items.create!(name: "orange",
                                      description: "same name as the color wow!",
                                      unit_price: 2.09,
                                      status: 1)

    @joe = Merchant.create!(name: "Joe Rogan")
    @item1 = @joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 2)
    @item2 = @joe.items.create!(name: "Baseball", description: "Not Bouncy", unit_price: 2)
    @item3 = @joe.items.create!(name: "Hockey Puck", description: "Not Bouncy", unit_price: 2)
    @item4 = @joe.items.create!(name: "Peach", description: "Pitted", unit_price: 2)
    @item5 = @joe.items.create!(name: "Orange", description: "Orange", unit_price: 2)
    @item6 = @joe.items.create!(name: "Apple", description: "Red", unit_price: 2)
    @customer1 = Customer.create!(first_name: "Dana", last_name: "White")
    @customer2 = Customer.create!(first_name: "John", last_name: "Singer")
    @customer3 = Customer.create!(first_name: "Jack", last_name: "Berry")
    @customer4 = Customer.create!(first_name: "Jill", last_name: "Kellogg")
    @customer5 = Customer.create!(first_name: "Jason", last_name: "Sayles")
    @inv1 = @customer1.invoices.create!(status: "completed")
    @inv2 = @customer2.invoices.create!(status: "completed")
    @inv3 = @customer3.invoices.create!(status: "completed")
    @inv4 = @customer4.invoices.create!(status: "completed")
    @inv5 = @customer5.invoices.create!(status: "completed")
    @inv6 = @customer5.invoices.create!(status: "completed")
    @inv7 = @customer5.invoices.create!(status: "completed")
    @inv1.transactions.create!(result: "success")
    @inv2.transactions.create!(result: "success")
    @inv3.transactions.create!(result: "success")
    @inv4.transactions.create!(result: "success")
    @inv5.transactions.create!(result: "success")
    @inv6.transactions.create!(result: "success")
    @inv7.transactions.create!(result: "failed")
    InvoiceItem.create!(invoice: @inv1, item: @item1, unit_price: 2, quantity: 1, status: "packaged")
    InvoiceItem.create!(invoice: @inv2, item: @item2, unit_price: 2, quantity: 2, status: "packaged")
    InvoiceItem.create!(invoice: @inv3, item: @item3, unit_price: 2, quantity: 3, status: "shipped")
    InvoiceItem.create!(invoice: @inv4, item: @item4, unit_price: 2, quantity: 4, status: "shipped")
    InvoiceItem.create!(invoice: @inv5, item: @item5, unit_price: 2, quantity: 5, status: "shipped")
    InvoiceItem.create!(invoice: @inv6, item: @item6, unit_price: 2, quantity: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv7, item: @item6, unit_price: 2, quantity: 7, status: "shipped")
    InvoiceItem.create!(invoice: @inv7, item: @item6, unit_price: 2, quantity: 8, status: "shipped")

  end

  describe "when I visit the merchant index page" do
    it "Displays the merchant's name" do
      visit "/merchants/#{@merchant.id}/items"
      expect(page).to have_content("Harrison")
    end

    it "Displays a list of all the names of this merchant's items" do
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content("Items")
      expect(page).to have_content("apple")
      expect(page).to have_content("orange")
    end

    it "displays all listed items as links to thier item show page" do
      visit "/merchants/#{@merchant.id}/items"

      within("#disabled-items") do
        expect(page).to have_link(@item_2.name)
        first(:link, "#{@item_2.name}").click
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_2.id}")
      end
    end

    it "Displays a button next to each name to disable or enable that item" do
      visit "/merchants/#{@merchant.id}/items"

      within "#enabled-items" do
        expect(page).to have_link(@item_1.name)
        expect(page).to have_button("disable")
        first(:button, "disable").click

        expect(page).not_to have_link(@item_1.name)
      end
    end

    it "Displays a new item link that takes you to a form to create a new item" do
      visit "/merchants/#{@merchant.id}/items"

      within "#new-item" do
        expect(page).to have_link("New Item")
        click_on("New Item")

        expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
      end
    end

    it "Displays a section that has the top 5 items by revenue and best day" do
      visit "/merchants/#{@joe.id}/items"

      within('#top-items') do
        expect(page).to have_content("Top Items")
        expect(@item5.name).to appear_before(@item4.name)
        expect(page).to have_content("Top day for Orange was 03/04/21")

        expect(@item4.name).to appear_before(@item3.name)
        expect(page).to have_content("Top day for Peach was 03/04/21")

        expect(@item3.name).to appear_before(@item2.name)
        expect(page).to have_content("Top day for Hockey Puck was 03/04/21")

        expect(@item2.name).to appear_before(@item6.name)
        expect(page).to have_content("Top day for Baseball was 03/04/21")
        expect(page).to have_content("Top day for Apple was 03/04/21")
      end
    end
  end
end
