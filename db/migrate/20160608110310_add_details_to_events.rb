class AddDetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :details, :string    
    rename_column :events, :description, :action
    add_reference :events, :drug, index: true
  end
end
