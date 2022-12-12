# Database Planning

## User
### Fields
- name STRING, :presence, format: /[a-zA-Z0-9]+/
- username STRING, :uniqueness, :presence
- email STRING, :uniqueness, :presence
- birthday DATE, comparison: {less_than: Date.now - 18.years, message: "You must be 18 to use this site"}
- gender STRING (use a select box to submit this)
- devise stuff

### Associations
To request friends
- has_many :friendships, dependent: :destroy
- has_many :friends, through: :friendships

To let it work the other way
- has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
- has_many :received_friends, through: :received_friendships, source: 'User'

You also need the helper methods mentioned [here](https://stackoverflow.com/questions/49213989/implement-a-friendship-model-with-has-and-belongs-to-many-in-rails), you can read through and figure them out again when you come to it since you're basically just googling and copying

has_many :posts
has_many :images
has_many :likes
has_many :comments
has_many :notifications
has_one_attached :avatar

## Friendship
### Fields
- user_id FOREIGN_KEY, :presence, check user isn't friending themselves (custom private method), and that they aren't already friends with the other person
- friend_id FOREIGN_KEY, :presence
- accepted BOOLEAN
- timestamps DATETIME (make sure they're created so I can see how long two Users have been friends using the edit date)

### Associations
- belongs_to :user
- belongs_to :friend, class_name: "User"


<!-- TODO: I'm using ActionText for this -->
## Post
### Fields
- body STRING
- user FOREIGN_KEY

### Associations
- has_many :comments, as: :commentable
- has_many :likes, as: :likeable
- has_many_attached :images
- belongs_to :user


<!-- TODO: I'm using ActiveStorage for these -->
## Image
### Fields
- the image itself
- any AS metadata
- user FOREIGN_KEY, :presence

### Associations
belongs_to :user
belongs_to :commentable, polymorphic: :true
has_many :comments, as: :commentable
has_many :likes, as: :likeable


## Comment
### Fields
- body STRING, :presence
- commentable_id FOREIGN_KEY, :presence
- commentable_type STRING
- user FOREIGN_KEY, :presence

### Associations
belongs_to :user
belongs_to :commentable, polymorphic: :true
has_many :comments, as: :commentable
has_many :likes, as: :likeable


## Notification
### Fields
- text STRING
- link STRING
- user FOREIGN_KEY

### Associations
- belongs_to :user


## Like
### Fields
- user FOREIGN_KEY
- likeable_id FOREIGN KEY
- likeable_type STRING

### Associations
- belongs_to :user
- belongs_to :likeable, polymorphic: :true