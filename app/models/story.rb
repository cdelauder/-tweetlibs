class Story < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :genre
end
