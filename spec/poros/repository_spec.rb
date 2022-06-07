require 'rails_helper'

RSpec.describe Repository do
  it "exists and has attributes" do
    data = { name: 'Fake Repo' }
    repo = Repository.new(data)

    expect(repo).to be_an_instance_of(Repository)
    expect(repo.name).to eq(data[:name])
  end
end
