class CreateBannedIps < ActiveRecord::Migration[5.0]
  def change
    create_table :banned_ips do |t|
      t.string :ip_range
      t.string :reason
      t.timestamps
    end

    add_index :banned_ips, :ip_range, unique: true
  end
end
