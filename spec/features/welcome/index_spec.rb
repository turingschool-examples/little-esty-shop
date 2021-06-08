require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'contains all contributors, their total commits, and the total pull requests' do
    new = GithubUser.new('JBrabson', 'little-esty-shop')

    visit '/'

    expect(page).to have_content('markcyen')
    expect(page).to have_content('rcasias')
    expect(page).to have_content('JBrabson')
    expect(page).to have_content('Caleb1991')

    expect(page).to have_content(89)
    expect(page).to have_content(29)
    expect(page).to have_content(5)
    expect(page).to have_content(2)

    expect(page).to have_content(30)
  end
end
