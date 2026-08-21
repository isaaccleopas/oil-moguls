defmodule OilMoguls.LoggerTranslator do
  @moduledoc """
  Drops Bandit/Thousand Island crash reports caused by the browser closing
  the TCP connection. On Windows this surfaces as `:econnaborted` and is
  routine during LiveView longpoll and page navigation — not an app bug.
  """

  @client_gone [:econnaborted, :econnreset, :enotconn]

  def translate(_min_level, :error, :report, {:logger, %{label: {:gen_server, :terminate}, report: report}}) do
    if client_disconnect?(report), do: :skip, else: :none
  end

  def translate(_min_level, _level, _kind, _message), do: :none

  def filter(%{level: :error, msg: msg, meta: meta}, _extra) do
    if client_disconnect_event?(msg, meta), do: :stop, else: :ignore
  end

  def filter(_event, _extra), do: :ignore

  def client_disconnect?(report) when is_map(report) do
    gone?(Map.get(report, :reason) || Map.get(report, "reason")) or
      gone_message?(Map.get(report, :last_message) || Map.get(report, "last_message"))
  end

  def client_disconnect?(report) when is_list(report) do
    gone?(Keyword.get(report, :reason)) or gone_message?(Keyword.get(report, :last_message))
  end

  def client_disconnect?(_), do: false

  defp client_disconnect_event?({:report, %{label: {:gen_server, :terminate}, report: report}}, _meta) do
    client_disconnect?(report)
  end

  defp client_disconnect_event?(_msg, %{crash_reason: {reason, _}}) when reason in @client_gone, do: true
  defp client_disconnect_event?(_, _), do: false

  defp gone?(reason) when reason in @client_gone, do: true
  defp gone?(_), do: false

  defp gone_message?({:tcp_error, _, reason}) when reason in @client_gone, do: true
  defp gone_message?({:ssl_error, _, reason}) when reason in @client_gone, do: true
  defp gone_message?(_), do: false
end
