class CreateJwtDenylist < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false, comment: "JWT ID"
      t.datetime :exp, null: false, comment: "exp claim"
      t.timestamps
    end
    add_index :jwt_denylist, :jti
  end
end
