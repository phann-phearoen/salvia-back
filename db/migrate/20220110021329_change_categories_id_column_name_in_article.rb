class ChangeCategoriesIdColumnNameInArticle < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :categories_id, :category_ids
  end
end
