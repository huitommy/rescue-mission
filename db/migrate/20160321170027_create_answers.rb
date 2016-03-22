class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :body, null: false
      t.belongs_to :question, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
