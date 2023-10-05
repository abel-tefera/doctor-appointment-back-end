class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.text :bio
      t.string :specialization
      t.decimal :rate
      t.string :hospital
      t.binary :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
