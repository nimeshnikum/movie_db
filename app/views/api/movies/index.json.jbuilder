json.array! @movies, :id, :title, :text
# json.array! @movies do |comment|
#   next if comment.marked_as_spam_by?(current_user)
#
#   json.body comment.body
#   json.author do
#     json.first_name comment.author.first_name
#     json.last_name comment.author.last_name
#   end
# end
