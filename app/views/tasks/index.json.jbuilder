json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :context, :due, :done
  json.url task_url(task, format: :json)
end
