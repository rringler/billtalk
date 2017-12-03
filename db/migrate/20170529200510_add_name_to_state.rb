class AddNameToState < ActiveRecord::Migration[5.0]
  def change
    add_column :states, :name, :string, null: false
  end
end
