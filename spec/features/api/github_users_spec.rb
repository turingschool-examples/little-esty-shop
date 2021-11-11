require 'rails_helper'

RSpec.describe GithubUsers do
  it 'exists' do
    users = GithubUsers.new([{login: "Micha", contributions: 10}, {login: "Bob", contributions: 20}])

    expect(users).to be_an_instance_of GithubUsers
  end

  it 'gets the names of the users' do
    users = GithubUsers.new([{login: "Micha", contributions: 10}, {login: "Bob", contributions: 20}])

    expect(users.user_and_contributions).to eq({"Micha" => 10, "Bob" => 20})
  end
end
