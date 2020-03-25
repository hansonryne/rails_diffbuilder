json.extract! review, :id, :repository_id, :start_date, :status, :owner, :old_commit, :new_commit, :created_at, :updated_at
json.url review_url(review, format: :json)
