class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :name
      t.string :surname
      t.string :email
      t.attachment :picture
      t.integer :type_of_contact

      t.timestamps null: false
    end
    add_index :contacts, :name
    add_index :contacts, :surname
    # Por requerimiento el email del usuario debe ser unico. Esto es que
    # un usuario no puede tener mas de un contacto con ese email.
    add_index :contacts, [:email, :user_id],
      name: 'only_one_email_per_contact',
      unique: true
  end
end
