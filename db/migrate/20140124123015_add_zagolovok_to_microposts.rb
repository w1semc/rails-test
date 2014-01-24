class AddZagolovokToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :zagolovok, :string
  end
end
