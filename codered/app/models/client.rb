class Client < ActiveRecord::Base
	validates_presence_of :client_name
	has_many :tickets
end
