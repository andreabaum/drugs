class ChangeDateFormatInDrugs < ActiveRecord::Migration
  def up
   change_column :drugs, :reset_at, :datetime
  end

  def down
   change_column :drugs, :reset_at, :date
  end
end
