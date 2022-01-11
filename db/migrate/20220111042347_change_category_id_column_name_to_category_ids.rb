class ChangeCategoryIdColumnNameToCategoryIds < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :category_id, :category_ids
  end
end
