class AddDateToConsumptions < ActiveRecord::Migration
  def change
      add_column :consumptions, :starts_at, :date, :default => Date.today
      add_column :consumptions, :ends_at, :date, :default => Date.today
  end
end
