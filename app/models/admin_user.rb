class AdminUser < ApplicationRecord
	attr_accessor :first_nam
	def last_name
		@last_name
	end

	def last_name(v)
		@last_name=v
	end
	has_and_belongs_to_many :pages
end
