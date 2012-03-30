class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :github_access_token
      t.text :github_data
      t.integer :watchings_count, :default => 0

      t.timestamps
    end

    add_index :users, :username, :unique => true
  end
end
