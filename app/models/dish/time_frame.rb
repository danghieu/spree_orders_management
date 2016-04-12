module Dish
	class TimeFrame < Spree::Base
		validates_presence_of :name
		has_many :shipments 
	end
end