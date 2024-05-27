class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.search_for(content, method)
    if method == 'perfect'
      Comment.where(comment: content)
    elsif method == 'forward'
      Comment.where('comment LIKE ?', content + '%')
    elsif method == 'backward'
      Comment.where('comment LIKE ?', '%' + content)
    else
      Comment.where('comment LIKE ?', '%' + content + '%')
    end
  end
end
