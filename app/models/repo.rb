class Repo < ActiveRecord::Base

  has_many :watches
  has_many :watchers, :through => :watches, :class_name => "User", :uniq => true
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"


  def self.language_list
    group(:language).select('language, COUNT(repos.id) AS repos').order('repos DESC')
  end

  def to_s
    name
  end

end
