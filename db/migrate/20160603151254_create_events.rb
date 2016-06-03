class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :when
      t.text :resource
      t.integer :resource_id
      t.text :description
    end
  end
end
