class Subject < ApplicationRecord
	scope :visible, ->{where(:visible =>true)}
	scope :invisible, ->{where(:visible =>false)}
	scope :sorted, ->{order("position asc")}
	scope :newest_first, ->{order("created_at desc")}
	scope :search,lambda{|query| where(["name like ?","%#{query}%"])}#must use lambda this line
end
