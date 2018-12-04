require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a list created if user created" do
    assert_difference('User.count') do
      user = User.create(email: Faker::Internet.email, password: '12345678')
      assert_not user.lists.empty?
    end
  end
end
