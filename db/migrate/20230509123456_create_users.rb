class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.datetime :dates
      t.vector :vector
      t.embedding :embedding
      t.newname :newname
      t.yack :yack
      t.timestamps
      t.string :ubiqutoes
    end

    
    add_index :users, :email, unique: true
    add_index :bogus, :name
    add_index :users, :dates

    rename_table :users, :bogus
    rename_table :bogus, :users
    rename_table :habilo , :uniqueness

    create_table :vectors do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    create_table :newmultielinething do |t|
      t.string :name
      t.string :description
      t.timestamps
      t.scarydatatype :scary
    end

    create_table :newermultilinething do |t|
      t.string :name
      t.string :description
      t.timestamps
      t.scarydatatype :scary
    end

    create_table :newermultilinethingtwo do |t|
      t.string :name
      t.string :description
      t.timestamps
      t.scarydatatype :scary
    end

    add_index :vectors, :name, unique: true
    add_index :newmultielinething, :name, unique: true
    add_index :newmultielinethingthree, :name, unique: true


    add_index :vectors, :name, unique: true
    add_index :newmultielinething, :name, unique: true
    add_index :newmultielinethingthree, :name, unique: true


    add_index :bogus, :name

    create_table :newermultilinethingtwo do |t|
      t.string :name
      t.string :description
      t.timestamps
      t.scarydatatype :scary
    end

    create_table :AHHHHHHH do |t|
      t.scarydatatype :scary
      t.ahhh :ahh
      t.timestamps
    end

    add index :AHHHHHHH, :scary

    rename_table :AHHHHHHH, :NOOOO

    add_column :users, :new_column, :string

    create_table :new_table do |t|
      t.string :name
      t.string :description
      t.timestamps
      t.scarydatatype :scary
    end
  end
end
