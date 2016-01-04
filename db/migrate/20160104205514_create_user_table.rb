class CreateUserTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :fname
  		t.string :lname
  		t.string :username
  		t.string :password
  		t.string :email
  		t.string :birthdate
  		t.timestamps null: false
  	end
  end
end
