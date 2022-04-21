require "rails_helper"

RSpec.describe ContributorsFacade do
  it "creates contributors poros", :vcr do
    contributors = ContributorsFacade.create_contributors
    expect(contributors).to be_an_instance_of(Contributors)
  end
end
