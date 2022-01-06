class Editor < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  has_many :articles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
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

  protected
  def confirmation_required?
    false
  end

end