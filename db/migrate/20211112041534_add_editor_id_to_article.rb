class AddEditorIdToArticle < ActiveRecord::Migration[6.1]
  def change
    # rename_column :articles, :editor_user_id, :editor_id
    # add_index  :articles, :editor_id
  end
end
