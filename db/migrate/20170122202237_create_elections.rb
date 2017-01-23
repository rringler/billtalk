class CreateElections < ActiveRecord::Migration[5.0]
  def change
    create_table :elections do |t|
      t.references :state, null: false, index: true
      t.datetime   :date,  null: false, index: true

      t.timestamps
    end
  end
end
