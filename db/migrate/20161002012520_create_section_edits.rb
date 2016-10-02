class CreateSectionEdits < ActiveRecord::Migration[5.0]
  def change
    create_table :section_edits do |t|

      t.timestamps
    end
  end
end
