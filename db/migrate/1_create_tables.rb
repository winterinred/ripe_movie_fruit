class CreateTables < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :movies do |t|
      t.string :title
      t.datetime :release_date
      t.string :genre
      t.string :director
      t.text :synopsis
      t.float :average_review
      t.timestamps
    end

    create_table :reviews do |t|
      t.integer :rating
      t.timestamps
    end

  end

end