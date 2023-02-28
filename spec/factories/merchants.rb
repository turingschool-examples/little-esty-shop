FactoryBot.define do
  factory :merchant do
    name {Faker::TvShows::Seinfeld.business}
  end
end
