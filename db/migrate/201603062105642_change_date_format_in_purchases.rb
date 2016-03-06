class ChangeDateFormatInPurchases < ActiveRecord::Migration
  def up
   change_column :purchases, :when, :datetime
  end

  def down
   change_column :purchases, :when, :date
  end
end
