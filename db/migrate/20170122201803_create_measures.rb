class CreateMeasures < ActiveRecord::Migration[5.0]
  def change
    create_table :measures do |t|
      t.references :election,    null: false
      t.string     :title,       null: false, unique: true
      t.string     :description, null: false
      t.text       :text,        null: false
      t.boolean    :result

      t.timestamps
    end
  end
end
