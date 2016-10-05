class Subject < ApplicationRecord
	acts_as_list
	has_many :pages
	scope :visible, ->{where(:visible =>true)}
	scope :invisible, ->{where(:visible =>false)}
	scope :sorted, ->{order("position asc")}
	scope :newest_first, ->{order("created_at desc")}
	scope :search,lambda{|query| where(["name like ?","%#{query}%"])}#must use lambda this line
	validates_presence_of :name
	validates_length_of :name, :maximum => 255
end
