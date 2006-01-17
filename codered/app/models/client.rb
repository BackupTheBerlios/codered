class Client < ActiveRecord::Base
        validates_presence_of :client_name
  		file_column :client_pic
        has_many :tickets
end
