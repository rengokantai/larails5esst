class Page < ApplicationRecord
	acts_as_list :scope=>:subject
	belongs_to :subject,{:optional=>false}
	has_and_belongs_to_many :admin_users
	has_many :sections
	scope :visible, ->{where(:visible =>true)}
	scope :invisible, ->{where(:visible =>false)}
	scope :sorted, ->{order("position asc")}
	scope :newest_first, ->{order("created_at desc")}
	#,:join_table=>'pages_admin_users' If we dont follow rails convention we need to specify join table name
	validates_presence_of :name
  	validates_length_of :name, :maximum => 255
  	validates_presence_of :permalink
  	validates_length_of :permalink, :within => 3..255
  	# use presence_of with length_of to disallow spaces
  	validates_uniqueness_of :permalink
  	# for unique values by subject use ":scope => :subject_id"
end
