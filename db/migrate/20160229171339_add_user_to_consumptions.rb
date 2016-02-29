class AddUserToConsumptions < ActiveRecord::Migration
  def change
    add_reference :consumptions, :user, index: true, foreign_key: true
  end
end
