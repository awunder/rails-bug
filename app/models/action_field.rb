class ActionField < ApplicationRecord
  belongs_to :domain

  has_many :actions, as: :actionable
  has_many :achievements, as: :achievementable

  accepts_nested_attributes_for :achievements, :actions,
                                allow_destroy: true
  validates :name, presence: true
end
