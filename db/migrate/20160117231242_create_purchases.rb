class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :drug, index: true
      t.date :when
      t.text :note
      t.integer :amount

      t.timestamps null: false
    end
  end
end
