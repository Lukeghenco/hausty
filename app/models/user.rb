class User < ActiveRecord::Base
  has_many :reviews
  has_many :apartments, through: :reviews
  has_secure_password

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end
  
end