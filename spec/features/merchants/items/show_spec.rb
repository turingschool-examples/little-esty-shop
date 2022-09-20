require "rails_helper"


RSpec.describe("Merchant Items Show Page") do
  it("i see all the items attributes including Name/Description/Current Selling price") do
    merchant1 = Merchant.create!(    name: "Bob")
    merchant2 = Merchant.create!(    name: "Jolene")
    item1 = merchant1.items.create!(    name: "item1",     description: "this is item1 description",     unit_price: 1)
    item2 = merchant1.items.create!(    name: "item2",     description: "this is item2 description",     unit_price: 2)
    item3 = merchant1.items.create!(    name: "item3",     description: "this is item3 description",     unit_price: 3)
    item4 = merchant2.items.create!(    name: "item3",     description: "this is item4 description",     unit_price: 3)
    visit("/merchants/#{merchant1.id}/items/#{item1.id}")
    expect(page).to(have_content(item1.name))
    expect(page).to(have_content(item1.description))
    expect(page).to(have_content(item1.unit_price))
  end

  describe("I see a link to update the item information.") do
    it("When I click the link ,Then I am taken to a page to edit this item,the form is prefilled") do
      merchant1 = Merchant.create!(      name: "Bob")
      merchant2 = Merchant.create!(      name: "Jolene")
      item1 = merchant1.items.create!(      name: "item1",       description: "this is item1 description",       unit_price: 1)
      item2 = merchant1.items.create!(      name: "item2",       description: "this is item2 description",       unit_price: 2)
      item3 = merchant1.items.create!(      name: "item3",       description: "this is item3 description",       unit_price: 3)
      item4 = merchant2.items.create!(      name: "item3",       description: "this is item4 description",       unit_price: 3)
      visit("/merchants/#{merchant1.id}/items/#{item1.id}")

      within("#item-#{item1.id}") do
        click_on("update #{item1.name}")
      end

      expect(current_path).to(eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit"))
      expect(page).to(have_field("Name",       with: "#{item1.name}"))
      expect(page).to(have_field("Description",       with: "#{item1.description}"))
      expect(page).to(have_field("Unit price",       with: "#{item1.unit_price}"))
    end

    describe("When I update the information in the form and I click submit") do
      it("Then I am redirected back to the item show page where I see the updated information,And I see a flash message stating that the information has been successfully updated") do
        merchant1 = Merchant.create!(        name: "Bob")
        merchant2 = Merchant.create!(        name: "Jolene")
        item1 = merchant1.items.create!(        name: "item1",         description: "this is item1 description",         unit_price: 1)
        visit("/merchants/#{merchant1.id}/items/#{item1.id}")

        within("#item-#{item1.id}") do
          click_on("update #{item1.name}")
        end

        fill_in("name",         with: "Awesome")
        click_on("Submit")
        expect(current_path).to(eq(("/merchants/#{merchant1.id}/items/#{item1.id}")))
        expect(page).to(have_content("Awesome has been successfully updated"))
      end
    end
  end
end
