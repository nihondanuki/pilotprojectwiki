class CreateInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :inquiries do |t|
      t.text :body
      t.string :subject
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
