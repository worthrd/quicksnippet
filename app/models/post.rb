class Post < ApplicationRecord
  belongs_to :user
  belongs_to :snippet_upload
end
