require 'rails_helper'
RSpec.describe 'it shows the merchant index page' do
  before :each do
    visit "/admin/merchants"
  end
  it 'can show the names of the of all the merchants' do
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
    expect(page).to have_content(@merchant5.name)
    expect(page).to have_content(@merchant6.name)
    expect(page).to have_content(@merchant7.name)
  end

  it 'classifies the merchant names in labeled sections, shows the enabled merchants section' do

  within "#enabled-admin-merchants-#{@merchant5.id}" do
      expect(page).to have_content(@merchant5.name)
    end

    within "#enabled-admin-merchants-#{@merchant6.id}" do
      expect(page).to have_content(@merchant6.name)
    end
  end

  it 'classifies the merchant names in labeled sections, shows the disabled merchants section' do

    within "#disabled-admin-merchants-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
    end

    within "#disabled-admin-merchants-#{@merchant2.id}" do
      expect(page).to have_content(@merchant2.name)
    end

    within "#disabled-admin-merchants-#{@merchant3.id}" do
      expect(page).to have_content(@merchant3.name)
    end

    within "#disabled-admin-merchants-#{@merchant4.id}" do
      expect(page).to have_content(@merchant4.name)
    end

    within "#disabled-admin-merchants-#{@merchant7.id}" do
      expect(page).to have_content(@merchant7.name)
    end
  end

  it 'can find a an enable button on the index page' do
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_selector(:button, "Enable")
  end

  it 'can click the enable button for a merchant and change its status to enabled' do

    within "#disabled-admin-merchants-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
    end

    within "#disabled-admin-merchants-#{@merchant1.id}" do
      click_button("Enable")
    end

    within "#enabled-admin-merchants-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
    end
  end

  it 'can click the disable button for a merchant and change its status to disabled' do

    within "#enabled-admin-merchants-#{@merchant5.id}" do
      expect(page).to have_content(@merchant5.name)
    end

    within "#enabled-admin-merchants-#{@merchant5.id}" do
      click_button("Disable")
    end

    within "#disabled-admin-merchants-#{@merchant5.id}" do
      expect(page).to have_content(@merchant5.name)
    end
  end

  it 'displays the top 5 merchants by revenue on the show page' do
    within "#top-5-merchants-#{@merchant2.id}" do
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content("$2,740,000.00")
    end

    within "#top-5-merchants-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content("$803,750.00")
    end

    within "#top-5-merchants-#{@merchant3.id}" do
      expect(page).to have_content(@merchant3.name)
      expect(page).to have_content("$29,900.00")
    end

    expect(@merchant2.name).to appear_before(@merchant1.name)
    expect(@merchant1.name).to appear_before(@merchant3.name)
  end

  it 'can label the date for the merchants best day for revenue' do

    within "#top-5-merchants-#{@merchant1.id}" do
      expect(page).to have_content("Top selling date for #{@merchant1.name} was #{@invoice17.created_at.strftime("%A, %B %d, %Y")}")
    end

  end
end
