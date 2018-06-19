class CreateInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :inquiries do |t|
      t.text :body, null: false
      t.string :subject, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :inquiries, [:user_id, :created_at]
  end
end
