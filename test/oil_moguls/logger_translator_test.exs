defmodule OilMoguls.LoggerTranslatorTest do
  use ExUnit.Case, async: true

  alias OilMoguls.LoggerTranslator

  test "skips gen_server terminate reports for aborted client connections" do
    report = %{
      reason: :econnaborted,
      last_message: {:tcp_error, make_ref(), :econnaborted}
    }

    assert :skip =
             LoggerTranslator.translate(
               :error,
               :error,
               :report,
               {:logger, %{label: {:gen_server, :terminate}, report: report}}
             )

    assert :stop =
             LoggerTranslator.filter(
               %{
                 level: :error,
                 msg: {:report, %{label: {:gen_server, :terminate}, report: report}},
                 meta: %{}
               },
               []
             )
  end

  test "does not skip unrelated gen_server crashes" do
    report = %{
      reason: %RuntimeError{message: "boom"},
      last_message: :timeout
    }

    assert :none =
             LoggerTranslator.translate(
               :error,
               :error,
               :report,
               {:logger, %{label: {:gen_server, :terminate}, report: report}}
             )
  end
end
