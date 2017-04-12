class Subject < ApplicationRecord

  has_many :pages

  scope :visible, lambda { where(:is_visible => true) }
  scope :invisible, lambda { where(:is_visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("position DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

end
