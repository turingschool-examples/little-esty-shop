require "rails_helper"

RSpec.describe RepositoryFacade do
  it "creates repo poros", :vcr do
    repo = RepositoryFacade.create_repo
    expect(repo).to be_a(Repository)
  end
end
