class User < ActiveRecord::Base
  # ##################################################################
  # EXTENSION
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # encrypts and stores a password
      # in the database to validate the authenticity of a user while
      # signing in. The authentication can be done both through POST
      # requests or HTTP Basic Authentication.
    :registerable, #handles signing up users through a registration
      # process, also allowing them to edit and destroy their account.
    :recoverable, # resets the user password and sends reset
      # instructions.
    :rememberable, # manages generating and clearing a token for
      # remembering the user from a saved cookie.
    :trackable,
      # tracks sign in count, timestamps and IP address.
    :validatable # provides validations of email and password.
      # It's optional and can be customized, so you're able to define
      # your own validations.
    #:confirmable, # sends emails with confirmation instructions and
      # verifies whether an account is already confirmed during sign
      # in.
    #:lockable # locks an account after a specified number of failed
      # sign-in attempts. Can unlock via email or after a specified
      # time period.
  # ##################################################################
  # RELATIONS
  has_many :contacts
  # ##################################################################
  # VALIDATIONS
  # ##################################################################
  # CALLBACKS
  # ##################################################################
  # DELEGATION & ALIAS
  # ##################################################################
  # SCOPES
  # ##################################################################
  # CLASS METHODS
  # ##################################################################
  # CUSTOM METHODS
end
