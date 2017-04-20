class Page < ApplicationRecord

  acts_as_list :scope => :subject

  belongs_to :subject, { :optional => true }
  # Rails guesses table wrong for HABTM relationship. :join_table option fixes this.
  has_and_belongs_to_many :users, :join_table => :users_pages
  has_many :sections

  scope :visible, lambda { where(:is_visible => true) }
  scope :invisible, lambda { where(:is_visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("position DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

end
