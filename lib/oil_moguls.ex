defmodule OilMoguls do
  @moduledoc """
  Oil Moguls application helpers.
  """

  @default_apexbee_url "https://apexbee.com"

  def apexbee_url do
    Application.get_env(:oil_moguls, :apexbee_url, @default_apexbee_url)
  end
end
