class CreateForums < ActiveRecord::Migration[5.0]
  def change
    create_table :forums do |t|
      t.belongs_to :section, index: true
      t.string :title
      t.string :description
      t.timestamps
    end

    add_index :forums, [:section_id, :title], unique: true
  end
end
