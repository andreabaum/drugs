class AddFieldsToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :format_type, :integer, default: 0
    add_column :drugs, :prescription, :boolean, default: true
  end
end
