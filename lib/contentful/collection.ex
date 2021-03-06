defmodule Contentful.Collection do
  alias Contentful.Space

  @moduledoc """
  Describes a Contentful collection, which is usually an API response of sys.type "Array".
  """
  @callback fetch_all(
              [limit: pos_integer(), skip: non_neg_integer()],
              Space.t() | String.t(),
              String.t() | nil,
              String.t() | nil
            ) ::
              {:ok, list(struct())}
              | {:error, atom(), original_message: String.t()}
              | {:error, :rate_limit_exceeded, wait_for: integer()}
              | {:error, :unknown}
  @callback fetch_one(
              String.t(),
              Space.t() | String.t(),
              String.t() | nil,
              String.t() | nil
            ) ::
              {:ok, struct()}
              | {:error, atom(), original_message: String.t()}
              | {:error, :rate_limit_exceeded, wait_for: integer()}
              | {:error, :unknown}
end
