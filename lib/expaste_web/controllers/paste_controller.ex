defmodule ExpasteWeb.PasteController do
  use ExpasteWeb, :controller
  import Expaste

  @paste_directory "./pastes"

  def index(conn, params) do
    filename = Expaste.random_string(10)

    {template, message} =
      if Map.has_key?(params, "l") do
        {"show.html", "You're watching a live preview and will see updates as they happen!"}
      else
        {"index.html", ""}
      end

    disabled = if File.exists?(@paste_directory) do
      ""
    else
      "disabled"
    end

    conn
    |> put_flash(:info, message)
    |> render template, filename: filename, disabled: disabled, content: ""
  end

  def latest(conn, _params) do
    {_, files} = File.ls(@paste_directory)

    render conn, "latest.html", pastes: files
  end

  def show(conn, %{"id" => id}) do
    file_path = Path.join(@paste_directory, id)

    {res, cnt} = File.read file_path

    content =
      if res == :error do
        Expaste.not_found_text()
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

        file_path = Path.join(@paste_directory, filename)

        {_, file} = File.open file_path, [:write]
        IO.binwrite file, content

        File.close file

        conn
        |> put_flash(:info, "Paste stored successfully!")
        |> redirect(to: "/paste/" <> filename)
    end
  end
end
