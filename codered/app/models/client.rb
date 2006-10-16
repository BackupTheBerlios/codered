class Client < ActiveRecord::Base
  file_column :client_pic, :magick => { :geometry => "125x95>" }
       # has_many :tickets
        validates_presence_of :client_name, :client_email
	validates_file_format_of :client_pic,
                           :in => ['image/gif','image/jpg', 'image/png', 'image/x-ms-bmp'],
			   :message => 'must be a png, jpg, bmp'

  	validates_uniqueness_of :client_name
  	validates_format_of :client_email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i


end
