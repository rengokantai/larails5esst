class Page < ApplicationRecord
	belongs_to :subject,{:optional=>false}
	has_and_belongs_to_many :admin_users
	#,:join_table=>'pages_admin_users' If we dont follow rails convention we need to specify join table name
end
