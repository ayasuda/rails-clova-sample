require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user =  users(:one)
    @list = @user.lists.first
    @task = tasks(:one)
    sign_in @user
  end

  test "should get index" do
    get list_tasks_url(@task.list)
    assert_response :success
  end

  test "should get new" do
    get new_list_task_url(@task.list)
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post list_tasks_url(@task.list), params: { task: { completed_at: @task.completed_at, list_id: @task.list_id, title: @task.title } }
    end

    assert_redirected_to list_task_url(@task.list, Task.last)
  end

  test "should show task" do
    get list_task_url(@task.list, @task)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_task_url(@task.list, @task)
    assert_response :success
  end

  test "should update task" do
    patch list_task_url(@task.list, @task), params: { task: { completed_at: @task.completed_at, list_id: @task.list_id, title: @task.title } }
    assert_redirected_to list_task_url(@task.list, @task)
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete list_task_url(@task.list, @task)
    end

    assert_redirected_to list_tasks_url
  end
end
