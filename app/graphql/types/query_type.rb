module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :blog, Types::BlogType, null: false, resolve: ->(obj, args, ctx) { Blog.first }

    # #カリキュラムだと下記だがシンタックスエラーになる
    # field :blog, !Types::BlogType do
    #   resolve ->(_obj, _args, ctx) {
    #     ctx[:blog]
    #   }
    # end

  end
end
