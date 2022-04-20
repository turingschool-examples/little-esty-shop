require 'rails_helper'

RSpec.describe Repository do
  it "exists and has attributes" do
      data = { name: "test repo" }
      repo = Repository.new(data)

      expect(repo).to be_a(Repository)
      expect(repo.name).to eq(data[:name])
  end
end
