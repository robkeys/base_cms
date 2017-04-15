class User < ApplicationRecord

  # Rails guesses table wrong for HABTM relationship. :join_table option fixes this.
  has_and_belongs_to_many :pages, :join_table => :users_pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
end
