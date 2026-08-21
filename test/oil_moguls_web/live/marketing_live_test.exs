defmodule OilMogulsWeb.MarketingLiveTest do
  use OilMogulsWeb.ConnCase, async: true

  test "home page positions Oil Moguls as a learning community", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")
    assert html =~ "The learning community for oil and gas professionals."
    assert html =~ "not an oil company"
    assert html =~ "ApexBee"
    assert html =~ "https://apexbee.com"
    assert html =~ "₦1B+"
    assert html =~ "Students"
    assert html =~ "Regulators"
  end

  test "inner pages render", %{conn: conn} do
    pages = [
      {~p"/academy", "Oil Moguls Academy"},
      {~p"/apexbee", "A product of Oil Moguls"},
      {~p"/community", "A professional network with standards."},
      {~p"/opportunities", "Opportunity Board"},
      {~p"/conference", "The Oil Moguls Conference"},
      {~p"/about", "Not an oil and gas company"},
      {~p"/audiences", "Who we serve"},
      {~p"/partners", "Who we serve"},
      {~p"/join", "Request access to the community."}
    ]

    for {path, snippet} <- pages do
      {:ok, _view, html} = live(conn, path)
      assert html =~ snippet
    end
  end

  test "join form validates and accepts a complete request", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/join")

    html =
      view
      |> form("#join-form", member: %{name: "", email: "bad", role: "", intent: ""})
      |> render_submit()

    assert html =~ "Enter your name."
    assert html =~ "Enter a valid email."

    html =
      view
      |> form("#join-form",
        member: %{
          name: "Adaeze Okonkwo",
          email: "adaeze@example.com",
          role: "Engineers",
          intent: "Join the Academy",
          note: "Drilling track"
        }
      )
      |> render_submit()

    assert html =~ "Thank you, Adaeze Okonkwo."
  end
end
