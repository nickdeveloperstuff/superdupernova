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
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Accordion Widget Test</h2>
        <.lego_grid>
          <.accordion items={[
            {"item1", "What is Phoenix LiveView?", "Phoenix LiveView enables rich, real-time user experiences with server-rendered HTML."},
            {"item2", "How does DaisyUI work?", "DaisyUI is a component library for Tailwind CSS that provides semantic component classes."},
            {"item3", "What is the Lego-Brick UI System?", "A grid-based UI system designed for rapid development with pre-built widget components."}
          ]} multiple={false} />
          
          <h3 class="text-lg font-semibold mb-unit-2 mt-unit-4 widget-12x1">Multiple Selection Accordion</h3>
          
          <.accordion items={[
            {"feature1", "Grid System", "12-column responsive grid with predefined widget sizes."},
            {"feature2", "Widget Library", "Comprehensive set of form, display, and action widgets."},
            {"feature3", "DaisyUI Integration", "Full integration with DaisyUI component styles."}
          ]} multiple={true} />
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