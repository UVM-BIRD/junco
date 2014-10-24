class CreateJournalContinuationMaps < ActiveRecord::Migration
  def change
    create_table :journal_continuation_maps, id: false, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :source_journal, null: false, index: true
      t.references :verb,           null: false
      t.references :target_journal, null: false, index: true
    end

    add_index :source_target, [:source_journal, :target_journal], :unique => true
  end
end
