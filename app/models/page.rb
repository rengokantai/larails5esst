class Page < ApplicationRecord
	belongs_to :subject,{:optional=>false}
	has_and_belongs_to_many :admin_users

	scope :visible, ->{where(:visible =>true)}
	scope :invisible, ->{where(:visible =>false)}
	scope :sorted, ->{order("position asc")}
	scope :newest_first, ->{order("created_at desc")}
	#,:join_table=>'pages_admin_users' If we dont follow rails convention we need to specify join table name
end
