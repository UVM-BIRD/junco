class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.boolean :preferred
      t.string :nlm_id, limit: 50
      t.string :abbrv, limit: 250
      t.string :full, limit: 500
      t.string :issn_print, limit: 50
      t.string :issn_online, limit: 50
      t.integer :start_year
      t.integer :end_year

      t.timestamps
    end
  end
end
