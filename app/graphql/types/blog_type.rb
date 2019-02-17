module Types
  class BlogType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
  end
end

# # カリキュラム通りだと下記の内容だがタイプエラーになる
# Types::BlogType == GraphQL::ObjectType.define do
#   name "Blog"
#   field :id, !types.ID
#   field :title, !types.String
#   field :content, !types.String
# end
