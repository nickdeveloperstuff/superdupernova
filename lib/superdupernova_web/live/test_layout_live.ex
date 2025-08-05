defmodule SuperdupernovaWeb.TestLayoutLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-4 px-4">Widget System Test</h1>
        
        <.lego_grid>
          <div class="widget-4x1 bg-blue-200 p-2 text-center flex items-center justify-center">
            Container and Grid Test
          </div>
          <div class="widget-8x1 bg-green-200 p-2 text-center flex items-center justify-center">
            Full Width Demo (8 cols)
          </div>
          <div class="widget-12x1 bg-red-200 p-2 text-center flex items-center justify-center">
            Full Width Row (12 cols)
          </div>
          <div class="widget-6x2 bg-purple-200 p-2 text-center flex items-center justify-center">
            6x2 Widget
          </div>
          <div class="widget-6x2 bg-yellow-200 p-2 text-center flex items-center justify-center">
            6x2 Widget
          </div>
          <div class="widget-12x4 bg-indigo-200 p-2 text-center flex items-center justify-center">
            Full Width 4 Rows Tall
          </div>
        </.lego_grid>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end