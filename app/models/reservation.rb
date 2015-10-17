class Reservation < ActiveRecord::Base
  belongs_to :trip
  has_many :flights, -> {order(datetime_from: :desc)}
  validates :trip, presence: true
  validates :company, presence: true
  validates :code, presence: true
end
