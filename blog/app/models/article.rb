class Article
  include Mongoid::Document
  field :title, type: String
  field :text, type: String
  field :tags, type: String
  field :_id, type: String
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 5}

end
