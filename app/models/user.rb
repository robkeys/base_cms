class User < ApplicationRecord

  has_secure_password

  validates :password, confirmation: true

  # Rails guesses table wrong for HABTM relationship. :join_table option fixes this.
  has_and_belongs_to_many :pages, :join_table => :users_pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  scope :admins, lambda { where(:is_site_admin => true) }
  scope :non_admins, lambda { where(:is_site_admin => false) }
  scope :sorted, lambda { order("last_name ASC", "first_name ASC") }
  scope :newest_first, lambda { order("position DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

  def name
    "#{first_name} #{last_name}"
  end

end
