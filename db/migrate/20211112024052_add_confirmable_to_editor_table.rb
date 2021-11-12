class AddConfirmableToEditorTable < ActiveRecord::Migration[6.1]
  def up
    add_column :editors, :confirmation_token, :string
    add_column :editors, :confirmed_at, :datetime
    add_column :editors, :confirmation_sent_at, :datetime
    # add_column :editors, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :editors, :confirmation_token, unique: true
    # Editor.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # editors as confirmed, do the following
    Editor.update_all confirmed_at: DateTime.now
    # All existing Editor accounts should be able to log in after this.
  end

  def down
    remove_index :editors, :confirmation_token
    remove_columns :editors, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :editors, :unconfirmed_email # Only if using reconfirmable
  end
end
