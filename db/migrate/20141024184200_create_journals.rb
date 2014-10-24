class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.boolean :preferred,   null: false
      t.string  :nlm_id,      null: false,  limit: 50
      t.string  :abbrv,       null: false,  limit: 250
      t.string  :full,        null: false,  limit: 500
      t.string  :issn_print,                limit: 50
      t.string  :issn_online,               limit: 50
      t.integer :start_year
      t.integer :end_year

      t.timestamps
    end
  end
end
