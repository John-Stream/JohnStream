class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.datetime :dates
      t.vector :vector
      t.embedding :embedding
      
      t.timestamps
    end
    
    add_index :users, :email, unique: true
  end
end
