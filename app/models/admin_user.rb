class AdminUser < ApplicationRecord
	attr_accessor :first_nam
	def last_name
		@last_name
	end

	def last_name(v)
		@last_name=v
	end
end
