defmodule ExqUIWeb.RetryLive.Show do
  use ExqUIWeb, :live_view
  alias ExqUI.Queue

  @impl true
  def mount(%{"score" => score, "jid" => jid}, _session, socket) do
    {:ok, assign(socket, job_details(score, jid))}
  end

  @impl true
  def handle_event("delete", %{"raw" => raw_job}, socket) do
    :ok = Queue.remove_retry_jobs([raw_job])
    {:noreply, push_redirect(socket, to: Routes.retry_index_path(socket))}
  end

  defp job_details(score, jid) do
    item = Queue.find_retry_job(score, jid)
    %{item: item}
  end
end
