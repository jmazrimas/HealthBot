class CreatePubHealths < ActiveRecord::Migration
  def change
    create_table :pub_healths do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.point :latlon, :geographic => true
      t.timestamps null: false
    end
  end
end
