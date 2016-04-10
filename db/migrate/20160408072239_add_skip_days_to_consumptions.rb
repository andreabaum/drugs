class AddSkipDaysToConsumptions < ActiveRecord::Migration
  def change
    add_column :consumptions, :every_days, :integer, default: 1
  end
end
