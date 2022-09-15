class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def self.top_five
  #   joins(:transactions).where('result = 0').group(:first_name).order(count: :desc).limit(5).count
  # end
end
