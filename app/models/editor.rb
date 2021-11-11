class Editor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.authenticate(email, password)
    editor = Editor.find_for_authentication(email: email)
    editor&.valid_password?(password) ? editor : nil
  end

  def self.get_editor_by_id editor_id
    self.where(id: editor_id).last
  end

  def as_json(options = {})
    super(options.merge({ except: [:created_at, :is_deleted, :uuid, :updated_at] }))
  end

end