class CreateConsumptions < ActiveRecord::Migration
  def change
    create_table :consumptions do |t|
      t.belongs_to :drug, index: true
      t.time :when
      t.float :amount
      t.text :note

      t.timestamps null: false
    end
  end
end
