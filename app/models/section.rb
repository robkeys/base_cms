class Section < ApplicationRecord

  acts_as_list :scope => :page

  belongs_to :page, { :optional => true }
  has_many :section_edits
  has_many :users, :through => :section_edits

  scope :visible, lambda { where(:is_visible => true) }
  scope :invisible, lambda { where(:is_visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("position DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

end
