require 'rails_helper'

RSpec.describe Repo do
  it 'does exist' do
    repo = Repo.new(name: "Crimson Sky")
    expect(repo).to be_instance_of(Repo)
    expect(repo.name).to eq("Crimson Sky")
  end
end
