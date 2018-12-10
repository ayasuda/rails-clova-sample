class SocialProvider < ApplicationRecord
  belongs_to :user

  has_one :credential, dependent: :destroy
end
