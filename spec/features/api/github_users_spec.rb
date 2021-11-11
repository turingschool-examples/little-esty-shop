require 'rails_helper'

RSpec.describe GithubUsers do
  it 'exists' do
    users = GithubUsers.new([{login: "Micha"}, {login: "Bob"}])

    expect(users).to be_an_instance_of GithubUsers
  end

  it 'gets the names of the users' do
    users = GithubUsers.new([{login: "Micha"}, {login: "Bob"}])

    expect(users.get_users).to eq(['Micha', 'Bob'])
  end
end