class AddNameToElection < ActiveRecord::Migration[5.0]
  def change
    add_column :elections, :name, :string, null: false
  end
end
