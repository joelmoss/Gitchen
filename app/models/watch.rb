class Watch < ActiveRecord::Base

  belongs_to :watcher, :foreign_key => :user_id, :class_name => "User"
  belongs_to :watching, :foreign_key => :repo_id, :class_name => "Repo"

end
