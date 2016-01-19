class ChangeQuantityToFloat < ActiveRecord::Migration
  def change
    change_column :drugs, :reset_amount, :float
  end
end
