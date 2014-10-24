class CreateJournalContinuationMaps < ActiveRecord::Migration
  def change
    create_table :journal_continuation_maps, id: false, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :source_journal, null: false, index: true
      t.references :verb,           null: false
      t.references :target_journal, null: false, index: true
    end

    add_index :journal_continuation_maps, [:source_journal_id, :target_journal_id],
              unique: true,
              name: 'source_target_index'
  end
end
