defmodule Contentful.Asset do
  @moduledoc """
  Represents an asset available to a `Contentful.Space`.

  https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/assets
  """

  alias Contentful.{Asset, SysData}
  alias Contentful.Asset.Fields
  defstruct fields: %Fields{}, sys: %SysData{}

  @type t :: %Contentful.Asset{
          fields: Fields.t(),
          sys: SysData.t()
        }

  @doc """
  parses a single asset struct from the API response for an asset

  ## Example

      %Contentful.Asset{ sys: %{ id: id }} = Contentful.Asset.from_api_fields(fields, %{"id" => id})
  """
  def from_api_fields(
        %{
          "description" => desc,
          "file" => %{
            "contentType" => content_type,
            "details" => details,
            "fileName" => file_name,
            "url" => url
          },
          "title" => title
        },
        %{"id" => id, "revision" => rev}
      ) do
    %Asset{
      sys: %SysData{id: id, revision: rev},
      fields: %Fields{
        title: title,
        description: desc,
        file: %{
          content_type: content_type,
          url: URI.parse(url),
          file_name: file_name,
          details: details
        }
      }
    }
  end
end
