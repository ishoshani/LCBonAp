class MenuItem < ActiveRecord::Base

def to_string
  "#{meal}: #{station}: #{description} #{votes}"
end

end