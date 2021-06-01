# Use this in all your tests to make testing easier

FactoryBot.define do
  factory :model_name do
    attr_1_here { Faker::Name.name }
    attr_2_here { Faker::Address.street }
  end

  factory :another_model_name do
    # Same as above
  end
end

# Usage in tests, these will create a record in the database of the model with random data using Faker https://github.com/faker-ruby/faker
test_model = FactoryBot.create(:model_name)
child_model = FactoryBot.create(:another_model_name, parent_model_name: test_model)

# Additional resources on FactoryBot https://github.com/thoughtbot/factory_bot_rails
