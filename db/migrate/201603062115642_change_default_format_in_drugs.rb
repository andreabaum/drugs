class ChangeDefaultFormatInDrugs < ActiveRecord::Migration
  def up
    change_column :drugs, :format_type, :integer, default: nil
  end

  def down
    change_column :drugs, :format_type, :integer, default: 0
  end
end
