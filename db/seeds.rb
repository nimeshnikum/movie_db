# Movie.delete_all
#
# Movie.create!(
#   [
#     { title: 'The Dark Knight', category_ids: [1, 6, 8] },
#     { title: 'Inception', category_ids: [1, 2, 16] },
#     { title: 'Gladiator', category_ids: [1, 2, 8] },
#     { title: 'Goodfells', category_ids: [4, 6, 8] },
#     { title: 'Life Is Beautiful', category_ids: [5, 8 ,15] },
#     { title: 'Toy Story', category_ids: [2, 3, 5] },
#     { title: 'The Green Mile', category_ids: [6, 8, 10] },
#     { title: 'Coco', category_ids: [2, 3, 9] },
#     { title: 'Memento', category_ids: [14, 19] },
#     { title: 'L.A. Confidential', category_ids: [6, 8, 14] }
#   ]
# )

load 'db/seeds/base.rb'

Seeds::Base.run!
