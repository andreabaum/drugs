class ChangeDateFormatInEvents < ActiveRecord::Migration
  def up
   change_column :events, :when, :datetime
  end

  def down
   change_column :events, :when, :date
  end
end
