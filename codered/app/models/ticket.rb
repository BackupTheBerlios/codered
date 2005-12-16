class Ticket < ActiveRecord::Base
        # Es muss eine ticket_bezeichnung und eine ticket_beschreibung eingeben werden
        validates_presence_of :ticket_bezeichnung, :ticket_beschreibung , :user_id , :client_id , :betreuer_id
        # die ticket_bezeichnung muss einzigartig sein
        # validates_uniqueness_of :ticket_bezeichnung # TODO: Abklären ob das nötig ist?
        has_many :workflows
        belongs_to :clients
        belongs_to :users
end
