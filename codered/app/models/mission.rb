class Mission < ActiveRecord::Base
	belongs_to :users
	belongs_to :tickets
end
