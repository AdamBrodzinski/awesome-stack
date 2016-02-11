# GraphQL schema that normal users will consume

defmodule App.GraphSchema do
  def schema do
    %GraphQL.Schema{
      query: %GraphQL.Type.ObjectType{
        name: "Queries",
        fields: get_query_fields()
      },
      mutation: %GraphQL.Type.ObjectType{
        name: "Mutations",
        fields: get_mutation_fields()
      }
    }
  end

  defp get_query_fields do
    %{
      user: App.QueryFields.User.get(),
      #posts: App.QueryFields.Posts.get,
      #comments: App.QueryFields.Comments.get,
    }
  end

  defp get_mutation_fields do
    %{
      #updateUser: App.MutationFields.UpdateUser.get,
      #addPost: App.MutationFields.AddPost.get,
      #deletePost: App.MutationFields.DeletePost.get,
      #comments: App.MutationFields.Comments.get,
    }
  end
end
