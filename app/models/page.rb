class Page < ApplicationRecord

  belongs_to :subject, { :optional => true }
  has_and_belongs_to_many :users
  has_many :sections

  scope :visible, lambda { where(:is_visible => true) }
  scope :invisible, lambda { where(:is_visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("position DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

end
