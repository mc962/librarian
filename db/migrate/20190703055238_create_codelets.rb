class CreateCodelets < ActiveRecord::Migration[5.2]
  def change
    create_table :codelets do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description, null: false
      t.text :examples
      t.boolean :publicly_accessible, default: false
      
      t.timestamps
    end

    add_index :codelets, :name, unique: true
    add_index :codelets, :slug, unique: true
  end
end
