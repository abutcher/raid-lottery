class CreateRaiders < ActiveRecord::Migration
  def change
    create_table :raiders do |t|
      t.string :name
      t.string :email
      t.boolean :participating
      t.boolean :auto

      t.timestamps null: false
    end
  end
end
