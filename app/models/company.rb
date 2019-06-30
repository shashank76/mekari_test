class Company < ApplicationRecord
  has_many :employees,dependent: :destroy
  has_many :policies, dependent: :destroy

  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
