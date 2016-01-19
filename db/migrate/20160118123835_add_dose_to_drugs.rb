class AddDoseToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :dose, :float
  end
end
