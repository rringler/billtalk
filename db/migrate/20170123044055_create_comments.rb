class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user,        null: false, index: true
      t.references :commentable, null: false, index: true, polymorphic: true
      t.text       :text,        null: false
      t.text       :meta

      t.timestamps
    end
  end
end
