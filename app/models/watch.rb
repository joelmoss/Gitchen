class Watch < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name GITCHEN_INDEX_NAME

  mapping do
    indexes :name, as: 'watching.name.gsub(/_/, " ")'
    indexes :original_name, as: 'watching.name', index: 'not_analyzed'
    indexes :description, as: 'watching.description'
    indexes :language, as: 'watching.language'
    indexes :private, as: 'watching.private', index: 'not_analyzed'
    indexes :watchers_count, as: 'watching.watchers_count', index: 'not_analyzed', type: 'integer'
    indexes :forks, as: 'watching.forks', index: 'not_analyzed', type: 'integer'
    indexes :open_issues, as: 'watching.open_issues', index: 'not_analyzed', type: 'integer'
    indexes :owner, as: 'watching.owner.username'
    indexes :watcher_id, as: 'user_id', type: 'integer'
    indexes :deleting
  end

  belongs_to :watcher, :foreign_key => :user_id, :class_name => "User", :counter_cache => :watchings_count
  belongs_to :watching, :foreign_key => :repo_id, :class_name => "Repo"

  default_scope where(deleting: false)


  # Unwatch a repo (duh!).
  def unwatch
    toggle! :deleting
    UnwatchWorker.perform_async id
  end

end
