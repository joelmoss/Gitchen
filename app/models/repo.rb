class Repo < ActiveRecord::Base

  has_many :watches
  has_many :watchers, :through => :watches, :class_name => "User"
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"


  def to_s
    name
  end

end
