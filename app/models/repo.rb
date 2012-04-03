class Repo < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name GITCHEN_INDEX_NAME

  mapping do
    indexes :name, as: 'name.gsub(/_/, " ")'
    indexes :original_name, as: 'name', index: 'not_analyzed'
    indexes :description
    indexes :language
    indexes :private, index: 'not_analyzed'
    indexes :watchers_count, index: 'not_analyzed'
    indexes :forks, index: 'not_analyzed'
    indexes :owner, as: 'owner.username'
  end

  has_many :watches
  has_many :watchers, :through => :watches, :class_name => "User", :uniq => true
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"


  def self.language_list
    group(:language).select('language, COUNT(repos.id) AS repos').order('repos DESC')
  end

  def to_s
    name
  end

  def to_param
    "#{owner}/#{name}"
  end

end
