FactoryBot.define do
  status = [ 0, 1 ]
  factory :merchant do
    name { Faker::Company.name }
    status { status.sample }

    factory :enabled_merchant do
      status { "enabled" }

    factory :disabled_merchant do
      status { "disabled" }
      end
    end
  end
end
