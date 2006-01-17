class Report < ActiveRecord::Base
        belongs_to :clients
        validates_presence_of :user_id, :datei, :client_id
  		file_column :datei
end
