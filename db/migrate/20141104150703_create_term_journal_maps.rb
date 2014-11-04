class CreateTermJournalMaps < ActiveRecord::Migration
  def change
    create_table :term_journal_maps do |t|
      t.references :term,    null: false, index: true
      t.references :journal, null: false, index: true

      t.timestamps
    end
  end
end
