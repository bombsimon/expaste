defmodule ExpasteWeb.PasteController do
  use ExpasteWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def latest(conn, _params) do
    {ok, files} = File.ls("./pastes")

    render conn, "latest.html", pastes: files 
  end

  def show(conn, %{"id" => id}) do
    file_path = Path.join("./pastes", id)

    {res, cnt} = File.read file_path

    content = 
      if res == :error do
        "Paste not found!"
      else
        cnt
      end

    render conn, "show.html", content: content, layout: {ExpasteWeb.LayoutView, "paste.html"}
  end

  def save(conn, %{"content" => content} = params) do
    filename = random_string(10)
    file_path = Path.join("./pastes", filename)

    {ok, file} = File.open file_path, [:write]
    IO.binwrite file, content

    File.close file

    redirect conn, to: "/paste/" <> filename
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
