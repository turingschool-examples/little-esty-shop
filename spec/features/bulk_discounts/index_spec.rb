require 'rails_helper'
RSpec.describe 'it can describe a bulk discounts index page' do
  before :each do
    
    visit "/merchants/#{@merchant1.id}/bulk_discounts"
  end
  it 'can visit a merchant dashboard and see there is links to view all that merchants bulk discounts' do
    visit "/merchants/#{@merchant1.id}"

    click_on("My Bulk Discounts")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
  end

  it 'can show the bulk discounts and their attributes' do
    within "#associated-bulk-discounts-#{@merchant1.id}" do
      within "#associated-bulk-discount-#{@bulk_discount1.id}" do
        expect(page).to have_content("Percentage Discount #{@bulk_discount1.percentage_discount * 100}%")
        expect(page).to have_content("threshold of #{@bulk_discount1.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount5.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount5.quantity_threshold}")
      end

      within "#associated-bulk-discount-#{@bulk_discount2.id}" do
        expect(page).to have_content("Percentage Discount #{@bulk_discount2.percentage_discount * 100}%")
        expect(page).to have_content("threshold of #{@bulk_discount2.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount3.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount3.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount5.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount5.quantity_threshold}")
      end

      within "#associated-bulk-discount-#{@bulk_discount4.id}" do
        expect(page).to have_content("Percentage Discount #{@bulk_discount4.percentage_discount * 100}%")
        expect(page).to have_content("threshold of #{@bulk_discount4.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount3.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount3.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount5.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount5.quantity_threshold}")
      end

      within "#associated-bulk-discount-#{@bulk_discount6.id}" do
        expect(page).to have_content("Percentage Discount #{@bulk_discount6.percentage_discount * 100}%")
        expect(page).to have_content("threshold of #{@bulk_discount6.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount3.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount3.quantity_threshold}")
        expect(page).to_not have_content("#{@bulk_discount5.percentage_discount * 100}%")
        expect(page).to_not have_content("#{@bulk_discount5.quantity_threshold}")
      end
    end    
  end

  it 'can have a link and click on the link to the specific bulk dicounts show page' do
    within "#associated-bulk-discount-#{@bulk_discount1.id}" do
        expect(page).to have_link("Link to this Bulk Discount #{@bulk_discount1.id} Show page")

        click_on("Link to this Bulk Discount #{@bulk_discount1.id} Show page")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@bulk_discount1.id}")
    end
  end

  it 'displays the next three dates on the index page' do
    expect(page).to have_content("#{holidays.name1}")
    expect(page).to have_content("#{holidays.date1}")
    expect(page).to have_content("#{holidays.name2}")
    expect(page).to have_content("#{holidays.date2}")
    expect(page).to have_content("#{holidays.name3}")
    expect(page).to have_content("#{holidays.date3}")
  end 
end