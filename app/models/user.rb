class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :lists

  has_many :social_providers, dependent: :destroy

  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
    foreign_key: :resource_owner_id, dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
    foreign_key: :resource_owner_id, dependent: :delete_all # or :destroy if you need callbacks

  after_create :create_default_list

  def self.from_line(auth)
    sp = SocialProvider.where(provider: auth[:provider], uid: auth[:uid]).first
    sp.nil? ? User.new : sp.user
  end

  def self.new_with_session(params, session)
    user = self.new(params)
    if auth = session["devise.line_auth"]
      provider = user.social_providers.new(provider: auth["provider"], uid: auth["uid"])
      provider.build_credential(
        expires: auth["credentials"]["expires"],
        expired_at: auth["credentials"]["expired_at"],
        refresh_token: auth["credentials"]["refresh_token"],
        token: auth["credentials"]["token"]
      )
    end

    user
  end

  def admin?
    id == 2
  end

  private

  def create_default_list
    lists.create!(title: 'ようこそ')
  end
end
