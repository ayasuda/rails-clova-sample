json.extract! task, :id, :list_id, :title, :completed_at, :created_at, :updated_at
json.url task_url(task, format: :json)
