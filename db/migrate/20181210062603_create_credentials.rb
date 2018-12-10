class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials do |t|
      t.references :social_provider, foreign_key: true
      t.boolean :expires
      t.datetime :expired_at
      t.text :refresh_token
      t.text :token

      t.timestamps
    end
  end
end
