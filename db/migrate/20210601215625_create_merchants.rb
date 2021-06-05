class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name

      t.timestamps
    end
    execute("ALTER SEQUENCE merchants_id_seq START with 1000 RESTART;")
  end
end
