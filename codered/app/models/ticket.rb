class Ticket < ActiveRecord::Base
	# Es muss eine ticket_bezeichnung und eine ticket_beschreibung eingeben werden
	validates_presence_of :ticket_bezeichnung, :ticket_beschreibung  
	# die ticket_bezeichnung muss einzigartig sein
	validates_uniqueness_of :ticket_bezeichnung
	has_many :workflows
	belongs_to :clients
	belongs_to :users
end
