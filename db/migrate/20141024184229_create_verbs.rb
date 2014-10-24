class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name,     null: false, limit: 50
      t.string :rdaw_id,  null: false, limit: 10
      t.string :desc,     null: false, limit: 250

      t.timestamps
    end
  end
end
