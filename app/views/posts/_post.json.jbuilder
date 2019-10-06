json.extract! post, :id, :title, :content, :user_id, :snippet_upload_id, :created_at, :updated_at
json.url post_url(post, format: :json)
