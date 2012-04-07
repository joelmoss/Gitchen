class AddDeletingToWatches < ActiveRecord::Migration
  def change
    add_column :watches, :deleting, :boolean, default: false
  end
end
