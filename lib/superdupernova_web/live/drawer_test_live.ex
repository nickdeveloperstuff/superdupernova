defmodule SuperdupernovaWeb.DrawerTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <.drawer id="demo-drawer">
      <:toggle>Open Menu</:toggle>
      
      <:content>
        <h3 class="font-bold text-lg mb-4">Navigation Menu</h3>
        <ul class="menu">
          <li><a>Home</a></li>
          <li><a>Dashboard</a></li>
          <li><a>Products</a></li>
          <li><a>Settings</a></li>
          <li><a>About</a></li>
        </ul>
      </:content>
      
      <:main>
        <div class="lego-page">
          <.lego_container>
            <h1 class="text-2xl font-bold mb-unit-4">Drawer Widget Test</h1>
            
            <.lego_grid>
              <div class="widget-12x1">
                <p class="mb-4">This page demonstrates the drawer widget. Click the button below to open the slide-out menu.</p>
              </div>
              
              <div class="widget-12x1">
                <h2 class="text-xl font-semibold mb-2">Main Content Area</h2>
                <p>The drawer widget allows you to create slide-out panels that overlay the main content. This is useful for navigation menus, settings panels, or any content that should be hidden by default.</p>
              </div>
              
              <div class="widget-12x1 mt-4">
                <h3 class="text-lg font-semibold mb-2">Features:</h3>
                <ul class="list-disc list-inside">
                  <li>Smooth slide animation</li>
                  <li>Overlay backdrop</li>
                  <li>Click outside to close</li>
                  <li>Fully accessible</li>
                </ul>
              </div>
            </.lego_grid>
          </.lego_container>
        </div>
      </:main>
    </.drawer>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end