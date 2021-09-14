class MerchantInvoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice
end
