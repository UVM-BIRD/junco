class CreateSearchTerms < ActiveRecord::Migration
  def change
    create_table :search_terms do |t|
      t.string :term, null: false, limit: 250

      t.timestamps
    end

    add_index :search_terms, :term, :unique => true
  end
end