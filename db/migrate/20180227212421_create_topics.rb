class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.belongs_to :forum, index: true
      t.belongs_to :user, index: true
      t.belongs_to :section, index: true
      t.string :title, index: true
      t.integer :views, default: 0
      t.timestamps
    end

    add_index :topics, [:forum_id, :title], unique: true
  end
end
