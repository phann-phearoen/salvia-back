class Editor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.authenticate(email, password)
    editor = Editor.find_for_authentication(email: email)
    editor&.valid_password?(password) ? editor : nil
  end
end