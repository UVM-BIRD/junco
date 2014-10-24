class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :desc, limit: 50

      t.timestamps
    end
  end
end
