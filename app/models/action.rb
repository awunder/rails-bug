class Action < ApplicationRecord
  belongs_to :actionable, polymorphic: true
  validates :name, presence: true

end
