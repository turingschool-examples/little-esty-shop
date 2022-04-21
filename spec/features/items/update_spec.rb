require "rails_helper"

describe "Merchants Items update", type: :feature do
  before :each do
    @merchant1 = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant1.id}
    @item2 = create :item, {merchant_id: @merchant1.id}
    @item3 = create :item, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}
  end

  it "displays update link", :vcr do
    visit merchant_item_path(@merchant1, @item1)

    expect(page).to have_link("Update #{@item1.name}")
    click_link("Update #{@item1.name}")

    expect(page).to have_current_path(edit_merchant_item_path(@merchant1, @item1))
  end

  it "has form to update item", :vcr do
    visit merchant_item_path(@merchant1, @item1)
    click_link("Update #{@item1.name}")

    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Description")
    expect(find("form")).to have_content("Unit price")
    expect(find("form")).to have_content("Enabled")
  end

  it "updates item info", :vcr do
    visit merchant_item_path(@merchant1, @item1)
    click_link("Update #{@item1.name}")

    fill_in "Name", with: "Different Item"
    click_button "Save"

    expect(page).to have_current_path(merchant_item_path(@merchant1, @item1))
    expect(page).to have_content("Different Item")
    expect(page).to have_content("Item updated successfully")
  end

  it "displays error message", :vcr do
    visit merchant_item_path(@merchant1, @item1)
    click_link("Update #{@item1.name}")

    fill_in "Name", with: ""
    click_button "Save"

    expect(page).to have_content("Error: Name can't be blank")
    expect(page).to have_current_path(edit_merchant_item_path(@merchant1, @item1))
  end

  it "merchant can enable and disable items", :vcr do
    visit merchant_item_path(@merchant1, @item1)
    if @item1.enabled == "enabled"
      expect(page).to have_button("Disable #{@item1.name}")
      click_button "Disable #{@item1.name}"

      expect(page).to have_content("Item updated successfully")
      expect(page).to have_button("Enable #{@item1.name}")
    end

    if @item1.enabled == "disabled"
      expect(page).to have_button("Enable #{@item1.name}")
      click_button "Enable #{@item1.name}"

      expect(page).to have_content("#{@item1.name} updated successfully")
      expect(page).to have_button("Disable #{@item1.name}")
    end
  end
end
