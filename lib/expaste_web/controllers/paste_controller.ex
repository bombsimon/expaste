defmodule ExpasteWeb.PasteController do
  use ExpasteWeb, :controller
  import Expaste

  def index(conn, params) do
    filename = Expaste.random_string(10)

    {template, message} =
      if Map.has_key?(params, "l") do
        {"show.html", "You're watching a live preview and will see updates as they happen!"}
      else
        {"index.html", ""}
      end

    conn
    |> put_flash(:info, message)
    |> render template, filename: filename, content: ""
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

  def save(conn, %{"content" => content, "session" => filename}) do
    case content do
      x when x == "" ->
        conn
        |> put_flash(:error, "You need to enter some text!")
        |> redirect(to: "/")
      _ ->
        filename =
          if filename == "" do
            Expaste.random_string(10)
          else
            filename
          end

        file_path = Path.join("./pastes", filename)

        {_, file} = File.open file_path, [:write]
        IO.binwrite file, content

        File.close file

        conn
        |> put_flash(:info, "Paste stored successfully!")
        |> redirect(to: "/paste/" <> filename)
    end
  end
end
