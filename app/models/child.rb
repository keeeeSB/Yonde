class Child < ApplicationRecord
  belongs_to :family

  enum :gender, { male: 0, female: 1 }

  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true

  def age
    today = Time.zone.today
    years = today.year - birthday.year
    months = today.month - birthday.month
    months -= 1 if today.day < birthday.day
    years -= 1 if months.negative?
    months += 12 if months.negative?

    "#{years}歳#{months}ヶ月"
  end
end
