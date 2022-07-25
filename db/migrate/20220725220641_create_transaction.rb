class CreateTransaction < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :result
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
