defmodule ExpasteWeb.PasteController do
  use ExpasteWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def latest(conn, _params) do
    {_, files} = File.ls("./pastes")

    render conn, "latest.html", pastes: files 
  end

  def show(conn, %{"id" => id}) do
    file_path = Path.join("./pastes", id)

    {res, cnt} = File.read file_path

    content = 
      if res == :error do
        "
// .---------------------------------.
// |  .---------------------------.  |
// |[]|                           |[]|
// |  |                           |  |
// |  |      PASTE NOT FOUND!     |  |
// |  |                           |  |
// |  |            :(             |  |
// |  |                           |  |
// |  |                           |  |
// |  |                           |  |
// |  |                           |  |
// |  `---------------------------'  |
// |      __________________ _____   |
// |     |   ___            |     |  |
// |     |  |   |           |     |  |
// |     |  |   |           |     |  |
// |     |  |   |           |     |  |
// |     |  |___|           |     |  |
// \\_____|__________________|_____|__|

"
      else
        cnt
      end

    render conn, "show.html", content: content
  end

  def save(conn, %{"content" => content}) do
    case content do
      x when x == "" ->
        conn
        |> put_flash(:error, "You need to enter some text!")
        |> redirect(to: "/")
      _ ->
        filename = random_string(10)
        file_path = Path.join("./pastes", filename)

        {_, file} = File.open file_path, [:write]
        IO.binwrite file, content

        File.close file

        conn
        |> put_flash(:info, "Paste stored successfully!")
        |> redirect(to: "/paste/" <> filename)
    end
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
