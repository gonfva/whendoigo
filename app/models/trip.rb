class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :flights, through: :reservations
  validates :name, presence: true
  validates :user, presence: true
  validates_date :date_from, :allow_blank=>true
  validates_date :date_to, :allow_blank=>true

  def to_tripit
    "<Trip><display_name>#{name}</display_name>" \
        "<start_date>#{date_from}</start_date>" \
        "<end_date>#{date_to}</end_date>" \
        "</Trip>"
  end
  scope :pending, ->{ where("date_from >= ? OR (date_from < ? AND date_to >= ?)",Date.today,Date.today,Date.today)}
  scope :old, ->{ where("date_to < ?", Date.today)}
  scope :ordered, -> { order(:date_from=> :desc)}
  scope :current, ->{ where("date_from <= ? AND date_to >= ?",Date.today, Date.today) }
end
