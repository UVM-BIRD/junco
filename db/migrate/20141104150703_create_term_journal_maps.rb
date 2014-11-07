class CreateTermJournalMaps < ActiveRecord::Migration
  def change
    create_table :term_journal_maps, id: false, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :term,    null: false, index: true
      t.references :journal, null: false, index: true

      t.timestamps
    end
  end
end
