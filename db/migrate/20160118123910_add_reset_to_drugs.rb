class AddResetToDrugs < ActiveRecord::Migration
  def change
      add_column :drugs, :reset_amount, :integer
      add_column :drugs, :reset_at, :date
  end
end
