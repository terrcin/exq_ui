defmodule ExqUIWeb.Router.Helpers do
  @moduledoc false

  def dashboard_path(socket, params \\ %{}), do: build(socket, "/", params)
  def busy_index_path(socket, params \\ %{}), do: build(socket, "/busy", params)
  def queue_index_path(socket, params \\ %{}), do: build(socket, "/queues", params)
  def queue_show_path(socket, queue, params \\ %{}), do: build(socket, "/queues/#{queue}", params)
  def retry_index_path(socket, params \\ %{}), do: build(socket, "/retries", params)
  def recurring_index_path(socket, params \\ %{}), do: build(socket, "/recurring", params)

  def retry_show_path(socket, score, jid, params \\ %{}),
    do: build(socket, "/retries/#{score}/#{jid}", params)

  def scheduled_index_path(socket, params \\ %{}), do: build(socket, "/scheduled", params)

  def scheduled_show_path(socket, score, jid, params \\ %{}),
    do: build(socket, "/scheduled/#{score}/#{jid}", params)

  def dead_index_path(socket, params \\ %{}), do: build(socket, "/dead", params)

  def dead_show_path(socket, score, jid, params \\ %{}),
    do: build(socket, "/dead/#{score}/#{jid}", params)

  defp build(_socket, path, params) do
    # Verified Routes were introduced with Phoenix 1.7 and this way of determining the root path using helper functions
    # no longer works:
    # socket.router.__helpers__.exq_ui_path(socket, :root)

    # As a quick hack to work around this the host app will need to set the below config to directly control this
    root = Application.get_env(:exq_ui, :root_path, "/")
    query = if Enum.empty?(params), do: "", else: "?" <> Plug.Conn.Query.encode(params)

    Path.join(root, path) <> query
  end
end
