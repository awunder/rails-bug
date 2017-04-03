class Achievement < ApplicationRecord
  belongs_to :achievementable, polymorphic: true

  validates :name, presence: true
end
