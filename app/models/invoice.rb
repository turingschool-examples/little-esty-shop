class Invoice < ApplicationRecord
  enum status: ["in progress".to_sym, :completed, :cancelled]
end
