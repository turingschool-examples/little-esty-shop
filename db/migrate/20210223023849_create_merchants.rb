class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name

      t.timestamps
    end
    execute "ALTER SEQUENCE merchants_id_seq MINVALUE 101 OWNED BY merchants.id START WITH 101 RESTART 101;"
  end
end
po
