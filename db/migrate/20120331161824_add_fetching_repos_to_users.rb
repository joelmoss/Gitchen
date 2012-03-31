class AddFetchingReposToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fetching_repos, :boolean, default: false
  end
end
