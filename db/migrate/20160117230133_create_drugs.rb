class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name
      t.text :note
      t.boolean :active

      t.timestamps null: false
    end
  end
end
