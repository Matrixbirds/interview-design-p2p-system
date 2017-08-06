class SetupDb < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' # pg >= 9.4
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :password_digest
      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :password_digest

    create_table :wallets, id: :uuid do |t|
      t.uuid :user_id
      t.decimal :balance, precision: 5, scale: 2
      t.timestamps
    end
    add_index :wallets, :balance
    add_index :wallets, :user_id, unique: true

    create_table :deposits, id: :uuid do |t|
      t.uuid :producer_id
      t.uuid :consumer_id
      t.decimal :balance, precision: 5, scale: 2
      t.timestamps
    end
    add_index :deposits, [:producer_id, :consumer_id]

    create_table :withdrawals, id: :uuid do |t|
      t.uuid :producer_id
      t.uuid :consumer_id
      t.decimal :balance, precision: 5, scale: 2
      t.timestamps
    end
    add_index :withdrawals, [:producer_id, :consumer_id]
  end
end
