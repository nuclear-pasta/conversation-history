class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :author
      t.references  :subject, :polymorphic => true
      t.text :content
      t.timestamps
    end
  end
end
