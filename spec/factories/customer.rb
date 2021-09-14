FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::TvShows::RickAndMorty.unique.character }
    last_name { Faker::TvShows::Simpsons.unique.character }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
