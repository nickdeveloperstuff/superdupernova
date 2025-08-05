defmodule SuperdupernovaWeb.TabsTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Tabs Widget Test</h1>
        
        <.lego_grid>
          <.tabs active_tab={@active_tab} tabs={[
            {:general, "General"},
            {:profile, "Profile"},
            {:settings, "Settings"}
          ]}>
            <.tab_panel tab={:general} active_tab={@active_tab}>
              <h2 class="text-lg font-semibold mb-2">General Information</h2>
              <p>This is the general tab content.</p>
            </.tab_panel>
            
            <.tab_panel tab={:profile} active_tab={@active_tab}>
              <h2 class="text-lg font-semibold mb-2">Profile Settings</h2>
              <p>This is the profile tab content.</p>
            </.tab_panel>
            
            <.tab_panel tab={:settings} active_tab={@active_tab}>
              <h2 class="text-lg font-semibold mb-2">App Settings</h2>
              <p>This is the settings tab content.</p>
            </.tab_panel>
          </.tabs>
        </.lego_grid>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, active_tab: :general)}
  end

  @impl true
  def handle_event("switch_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: String.to_existing_atom(tab))}
  end
end