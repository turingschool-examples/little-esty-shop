class Customer < ApplicationRecord

  def self.pk_reset
    connection.reset_pk_sequence!('customers')
  end
end
