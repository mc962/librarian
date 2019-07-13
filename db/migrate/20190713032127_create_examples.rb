class CreateExamples < ActiveRecord::Migration[5.2]
  def change
    create_table :examples do |t|
      t.command, :text, null: false
      t.comment, :text
      t.output, :text

      t.references :codelets, foreign_key: true
      
      t.timestamps
    end

    add_index :examples, :command
  end
end
