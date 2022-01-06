class ChangeArticleTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :type, :article_type
  end
end
