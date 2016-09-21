class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :latest, -> { order('created_at DESC') }
end
