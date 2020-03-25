json.extract! diff, :id, :review_id, :status, :notes, :path, :reason, :created_at, :updated_at
json.url diff_url(diff, format: :json)
