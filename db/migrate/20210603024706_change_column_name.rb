class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :credit_card_experation_date, :credit_card_expiration_date  
  end
end
