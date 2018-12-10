class CreateSocialProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :social_providers do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :social_providers, [:provider, :uid], unique: true
  end
end
