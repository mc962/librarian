class CreateExamples < ActiveRecord::Migration[5.2]
  def change
    create_table :examples do |t|
      t.text :command, null: false
      t.text :output
      t.text :comment
      
      t.references :codelet, foreign_key: true, index: true
      
      t.timestamps
    end

    add_index :examples, :command

    remove_column :codelets, :examples, :text
  end
end
