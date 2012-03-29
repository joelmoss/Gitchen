class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.references :user, :repo
      t.timestamps
    end
  end
end
