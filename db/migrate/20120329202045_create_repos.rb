class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name, :language
      t.text :description
      t.boolean :fork, :private
      t.integer :watchers_count, :size, :forks, :open_issues, :default => 0
      t.references :owner
      t.datetime :pushed_at
      t.timestamps
    end
  end
end
