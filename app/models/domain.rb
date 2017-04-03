class Domain < ApplicationRecord


  has_many :action_fields, dependent: :destroy
  has_many :actions, as: :actionable
  has_many :achievements, as: :achievementable

  accepts_nested_attributes_for :action_fields, :achievements, :actions,
                                allow_destroy: true

  validates :name, presence: true

end
