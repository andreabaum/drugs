class RemoveDoseFromDrugs < ActiveRecord::Migration
  def change
    remove_column :drugs, :dose, :float
  end
end
