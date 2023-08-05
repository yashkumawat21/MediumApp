# db/seeds.rb

# Add seed data for topics
Topic.create(name: "Technology")
Topic.create(name: "Science")
Topic.create(name: "Art")
# Add more topics as needed

# Add seed data for users
User.create(name: "John Doe", email: "john@example.com", password: "password")
User.create(name: "Jane Smith", email: "jane@example.com", password: "password")
# Add more users as needed

# Add seed data for posts
Post.create(title: "Introduction to Rails", text: "Rails is a web development framework...", topic_id: 1, author_id: 1)
Post.create(title: "Machine Learning Basics", text: "Machine learning is a subset of artificial intelligence...", topic_id: 2, author_id: 2)
# Add more posts as needed

# Add seed data for comments
Comment.create(user_id: 1, post_id: 1, content: "Great article!")
Comment.create(user_id: 2, post_id: 2, content: "I learned a lot from this post.")
# Add more comments as needed

# Add seed data for likes
Like.create(user_id: 1, post_id: 2)
Like.create(user_id: 2, post_id: 1)
# Add more likes as needed

# Add seed data for lists
List.create(name: "My Favorites", user_id: 1)
List.create(name: "To Read", user_id: 2)
# Add more lists as needed

# Add seed data for list posts
ListPost.create(list_id: 1, post_id: 1)
ListPost.create(list_id: 1, post_id: 2)
ListPost.create(list_id: 2, post_id: 1)
# Add more list posts as needed

# Add seed data for orders
Order.create(user_id: 1, amount: 500)
Order.create(user_id: 2, amount: 300)
# Add more orders as needed

# Add seed data for relationships
Relationship.create(follower_user_id: 1, followee_user_id: 2)
Relationship.create(follower_user_id: 2, followee_user_id: 1)
# Add more relationships as needed

# Add seed data for saved posts
SavedPost.create(user_id: 1, post_id: 2)
SavedPost.create(user_id: 2, post_id: 1)
# Add more saved posts as needed

# Add seed data for user post views
UserPostView.create(user_id: 1, post_id: 2, views_count: 3)
UserPostView.create(user_id: 2, post_id: 1, views_count: 5)
# Add more user post views as needed

# Add seed data for user topic views
UserTopicView.create(user_id: 1, topic_id: 2, view_count: 2)
UserTopicView.create(user_id: 2, topic_id: 1, view_count: 1)
# Add more user topic views as needed

# Add seed data for user author views
UserAuthorView.create(user_id: 1, author_id: 2, view_count: 1)
UserAuthorView.create(user_id: 2, author_id: 1, view_count: 2)
# Add more user author views as needed
