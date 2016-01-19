class AddFormatToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :format, :string
  end
end
