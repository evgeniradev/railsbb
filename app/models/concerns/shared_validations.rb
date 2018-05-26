module SharedValidations
  extend ActiveSupport::Concern

  included do
    validates :title, presence: true
    validates :title, length: { minimum: 2, maximum: 50 }
  end
end
