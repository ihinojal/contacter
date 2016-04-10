class Contact < ActiveRecord::Base
  # ##################################################################
  # CONSTANTS
  CONTACT_TYPES = %w'friend family coworker'

  # ##################################################################
  # RELATIONS
  belongs_to :user
  enum type_of_contact: CONTACT_TYPES
  has_attached_file :picture

  # ##################################################################
  # EXTENSION
  # ##################################################################
  # VALIDATIONS
  validates_presence_of :user, :name, :surname, :email, :type_of_contact
  validates :type_of_contact, inclusion: { in: CONTACT_TYPES }
  validates :email, uniqueness: { scope: :user_id }
  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_attachment_content_type :picture, 
    content_type: /^(image)\/(bmp|gif|jpeg|jpg|pjpeg|png|x-png|tiff)$/
  # ##################################################################
  # CALLBACKS
  # ##################################################################
  # DELEGATION & ALIAS
  # ##################################################################
  # SCOPES
  # NOTE: Usar la sintaxis de where(['?', valor]), ya que se escapara
  # y no tiene problemas de SQL inyection
  scope :search, -> (search) {
    where(['name LIKE ? OR surname LIKE ?', "%#{search}%", "%#{search}%"])
  }
  # ##################################################################
  # CLASS METHODS
  # ##################################################################
  # CUSTOM METHODS
end


      
