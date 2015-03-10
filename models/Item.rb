class Item < ActiveRecord::Base

def to_string
  "#{station}: #{description} #{votes}"
end

end