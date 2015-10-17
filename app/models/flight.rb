class Flight < ActiveRecord::Base
  belongs_to :reservation
  validates_presence_of :reservation,:company, :code,:terminal_from, :terminal_to, :datetime_from, :datetime_to
end

