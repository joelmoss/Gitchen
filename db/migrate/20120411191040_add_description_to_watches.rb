class AddDescriptionToWatches < ActiveRecord::Migration
  def change
    add_column :watches, :description, :string
  end
end
