class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false }
end
