class AddIntroductionAndReceiveShuinToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :introduction, :text
    add_column :posts, :receive_shuin, :boolean
  end
end
