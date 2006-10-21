# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require_dependency "login_system" 
class ApplicationController < ActionController::Base
	    include LoginSystem
	    model :user
def random_password(size = 8)
  chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
  (1..size).collect{|a| chars[rand(chars.size)] }.join
end

def random_pronouncable_password(size = 3)
  c = %w(b c d f g h j k l m n p qu r s t v w x z ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr)
  v = %w(a e i o u y) + ('0'..'9').to_a
  f, r = true, ''
  (size * 2).times do
    r << (f ? c[rand * c.size] : v[rand * v.size])
    f = !f
  end
  r
end

end
