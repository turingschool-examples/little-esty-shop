require 'rails_helper'

RSpec.describe 'admin dashboard' do
  it 'has a header' do
    visit admin_path

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links to admin merchants and admin invoices' do
    visit admin_path

    expect(page).to have_link('Dashboard', href: admin_path)
    expect(page).to have_link('Merchants', href: '/admin/merchants')
    expect(page).to have_link('Invoices', href: '/admin/invoices')
  end

  it 'Displays names of top 5 customers by transaction and their transaction count' do
    visit admin_path

    within '#top_customers' do
      expect('Ilene').to appear_before('Katrina')
      expect('Katrina').to appear_before('Parker')
      expect('Parker').to appear_before('Ramona')
      expect('Ramona').to appear_before('Joey')
    end

    within '#customer_12' do
      expect(page).to have_content(9)
    end
  end

  it 'Displays incomplete invoices sorted by oldest first' do
    visit admin_path

    within '#incomplete_invoices' do
      expect(page).to have_link('Invoice #10', href: 'admin/invoices/10')
      expect('Invoice #10').to appear_before('Invoice #76')
      expect('Invoice #76').to appear_before('Invoice #18')
      expect('Invoice #18').to appear_before('Invoice #9')
    end
  end

  it 'Displays dates for incomplete invoices' do
    visit admin_path

    within '#incomplete_invoices' do
      expect(page).to have_content('Tuesday, March 6, 2012')
    end
  end

  it 'displays the name of the github repo' do
    visit admin_path

    expect(page).to have_content("sambcox/little-esty-shop")
  end

  it 'displays all contibutors usernames' do
    visit admin_path

    expect(page).to have_content('sambcox')
    expect(page).to have_content('this-is-joeking')
    expect(page).to have_content('ryancanton')
    expect(page).to have_content('Mike-Cummins')
  end

  xit 'displays the number of commits next to each github username' do
    visit admin_path

    expect(page).to have_content('sambcox - 53 commits')
    expect(page).to have_content('this-is-joeking - 29 commits')
    expect(page).to have_content('ryancanton - 33 commits')
    expect(page).to have_content('Mike-Cummins - 30 commits')
  end

  xit 'displays the number of merged PRs for all team members' do
    visit admin_path

    expect(page).to have_content('42 Merged PRs')
  end
end
