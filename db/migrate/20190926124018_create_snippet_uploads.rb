class CreateSnippetUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :snippet_uploads do |t|
      t.string :title

      t.timestamps
    end
  end
end
