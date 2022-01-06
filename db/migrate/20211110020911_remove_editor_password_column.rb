class RemoveEditorPasswordColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :editors, :password, :encrypted_password
  end
end
