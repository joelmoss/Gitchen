class Repo < ActiveRecord::Base

  has_many :watches
  has_many :watchers, :through => :watches, :class_name => "User"

end
