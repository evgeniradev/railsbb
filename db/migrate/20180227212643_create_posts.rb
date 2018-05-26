class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.belongs_to :forum, index: true
      t.belongs_to :topic, index: true
      t.belongs_to :user, index: true
      t.belongs_to :section, index: true
      t.integer :kind, default: 0
      t.text :content
      t.timestamps
    end
  end
end

