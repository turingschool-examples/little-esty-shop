class Customer < ApplicationRecord
    has_many :invoices
    has_many :merchants, through: :invoices

    # def self.find_name_for_merchant(id)
    #   self.all.where(id: id).pluck(:first_name, :last_name).flatten.join(" ")
    # end
end
