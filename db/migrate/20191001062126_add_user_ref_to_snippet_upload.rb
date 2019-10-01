class AddUserRefToSnippetUpload < ActiveRecord::Migration[6.0]
  def change
    add_reference :snippet_uploads, :user, null: true, foreign_key: true
  end
end
