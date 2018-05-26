class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :title
      t.timestamps
    end

    add_index :sections, :title, unique: true
  end
end
