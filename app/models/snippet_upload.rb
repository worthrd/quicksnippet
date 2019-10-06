class SnippetUpload < ApplicationRecord
	validates_presence_of :title

	has_many_attached :files

    belongs_to :user
end
