defmodule Expaste do
  @moduledoc """
  Expaste keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64
    |> binary_part(0, length)
  end

  def not_found_text do
    "
# .---------------------------------.
# |  .---------------------------.  |
# |[]|                           |[]|
# |  |                           |  |
# |  |      PASTE NOT FOUND!     |  |
# |  |                           |  |
# |  |            :(             |  |
# |  |                           |  |
# |  |                           |  |
# |  |                           |  |
# |  |                           |  |
# |  `---------------------------'  |
# |      __________________ _____   |
# |     |   ___            |     |  |
# |     |  |   |           |     |  |
# |     |  |   |           |     |  |
# |     |  |   |           |     |  |
# |     |  |___|           |     |  |
# \\_____|__________________|_____|__|

"
  end
end
