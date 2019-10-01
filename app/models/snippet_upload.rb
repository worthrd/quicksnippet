class SnippetUpload < ApplicationRecord
	validates_presence_of :title

	has_many_attached :files
end
