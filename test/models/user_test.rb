require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a list created if user created" do
    assert_difference('User.count') do
      user = User.create(email: Faker::Internet.email, password: '12345678')
      assert_not user.lists.empty?
    end
  end

  test "self.from_line method returns user object if persited" do
    auth = OmniAuth::AuthHash.new.tap do |h|
      h[:provider] = "line"
      h[:uid] = "U00000000"
      h[:credentials] = OmniAuth::AuthHash.new.tap do |c|
        c[:expires] = true
        c[:expires_at] = 3600
        c[:refresh_token] = "SOME_REFRESH_TOKEN"
        c[:token] = "SOME_TOKEN"
      end
    end

    user = User.from_line(auth)
    assert_not_nil user
    assert_not user.persisted?

    auth[:provider] = "line"
    auth[:uid] = "uid001"

    user = User.from_line(auth)
    assert_not_nil user
    assert user.persisted?
    assert_not_nil user.social_providers.where(provider: :line).first
  end
end
