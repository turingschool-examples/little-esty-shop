# FactoryBot.define do 
#   sequence :status do |

#   end
# end
FactoryBot.define do 
  factory :invoice do 
    status { 0 }
    customer
  end
end