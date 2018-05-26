class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :title, default: 'Insert your title here'
      t.string :description, default: 'Insert a short desccription here'
      t.string :time_zone, default: 'UTC'
      t.string :logo
      t.text  :terms_and_conditions, default: ''
      t.timestamps
    end
  end
end
