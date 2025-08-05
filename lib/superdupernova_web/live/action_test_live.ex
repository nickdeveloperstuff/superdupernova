defmodule SuperdupernovaWeb.ActionTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Action Widgets Test</h1>
        
        <h2 class="text-xl font-semibold mb-unit-2">Button Variants</h2>
        <.lego_grid>
          <.widget_button variant="primary" grid_size="2x1">Primary</.widget_button>
          <.widget_button variant="secondary" grid_size="2x1">Secondary</.widget_button>
          <.widget_button variant="accent" grid_size="2x1">Accent</.widget_button>
          <.widget_button variant="neutral" grid_size="2x1">Neutral</.widget_button>
          <.widget_button variant="ghost" grid_size="2x1">Ghost</.widget_button>
          <.widget_button variant="link" grid_size="2x1">Link</.widget_button>
          <.widget_button variant="info" grid_size="2x1">Info</.widget_button>
          <.widget_button variant="success" grid_size="2x1">Success</.widget_button>
          <.widget_button variant="warning" grid_size="2x1">Warning</.widget_button>
          <.widget_button variant="error" grid_size="2x1">Error</.widget_button>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Button Sizes</h2>
        <.lego_grid>
          <.widget_button size="xs" grid_size="2x1">Extra Small</.widget_button>
          <.widget_button size="sm" grid_size="2x1">Small</.widget_button>
          <.widget_button size="md" grid_size="2x1">Medium</.widget_button>
          <.widget_button size="lg" grid_size="4x1">Large</.widget_button>
          <.widget_button size="xl" grid_size="4x1">Extra Large</.widget_button>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Button States</h2>
        <.lego_grid>
          <.widget_button variant="primary" outline grid_size="2x1">Outline</.widget_button>
          <.widget_button variant="primary" loading grid_size="2x1">Loading</.widget_button>
          <.widget_button variant="primary" disabled grid_size="2x1">Disabled</.widget_button>
          <.widget_button variant="primary" wide grid_size="4x1">Wide Button</.widget_button>
          <.widget_button variant="primary" block grid_size="12x1">Block Button</.widget_button>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Icon Buttons</h2>
        <.lego_grid>
          <.icon_button variant="primary">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
            </svg>
          </.icon_button>
          <.icon_button variant="secondary" shape="circle">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </.icon_button>
          <.icon_button variant="accent" size="lg">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
            </svg>
          </.icon_button>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Button Groups</h2>
        <.lego_grid>
          <div class="widget-6x1">
            <.button_group>
              <button class="btn btn-sm">Left</button>
              <button class="btn btn-sm btn-active">Middle</button>
              <button class="btn btn-sm">Right</button>
            </.button_group>
          </div>
          <div class="widget-6x1">
            <.button_group>
              <button class="btn btn-primary">Previous</button>
              <button class="btn btn-primary">1</button>
              <button class="btn btn-primary btn-active">2</button>
              <button class="btn btn-primary">3</button>
              <button class="btn btn-primary">Next</button>
            </.button_group>
          </div>
        </.lego_grid>

        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Interactive Button</h2>
        <.lego_grid>
          <.widget_button variant="primary" phx-click="clicked" grid_size="4x1">
            Click Me!
          </.widget_button>
          <%= if @clicked do %>
            <div class="widget-8x1 text-success">
              Button was clicked!
            </div>
          <% end %>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Modal Widget</h2>
        <.lego_grid>
          <.widget_button variant="primary" phx-click={SuperdupernovaWeb.Widgets.Action.show_modal("demo-modal")} grid_size="4x1">
            Open Modal
          </.widget_button>
          <.widget_button variant="secondary" phx-click={SuperdupernovaWeb.Widgets.Action.show_modal("action-modal")} grid_size="4x1">
            Modal with Actions
          </.widget_button>
        </.lego_grid>
        
        <.modal id="demo-modal" title="Demo Modal">
          This is a simple modal dialog. Click the backdrop or close button to dismiss.
        </.modal>
        
        <.modal id="action-modal" title="Confirm Action">
          Are you sure you want to perform this action?
          <:actions>
            <button class="btn btn-primary">Confirm</button>
            <button class="btn btn-ghost" phx-click={SuperdupernovaWeb.Widgets.Action.hide_modal("action-modal")}>Cancel</button>
          </:actions>
        </.modal>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Dropdown Widget</h2>
        <.lego_grid>
          <.dropdown label="Options" variant="primary" size="4x1">
            <.dropdown_item phx-click="dropdown-clicked" phx-value-option="edit">Edit</.dropdown_item>
            <.dropdown_item phx-click="dropdown-clicked" phx-value-option="duplicate">Duplicate</.dropdown_item>
            <.dropdown_item phx-click="dropdown-clicked" phx-value-option="delete">Delete</.dropdown_item>
          </.dropdown>
          
          <.dropdown label="Actions" variant="secondary" size="4x1">
            <.dropdown_item>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
              </svg>
              Home
            </.dropdown_item>
            <.dropdown_item>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
              Documents
            </.dropdown_item>
            <.dropdown_item>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              Settings
            </.dropdown_item>
          </.dropdown>
          
          <%= if @dropdown_clicked do %>
            <div class="widget-4x1 text-success">
              Dropdown clicked: <%= @dropdown_clicked %>
            </div>
          <% end %>
        </.lego_grid>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, clicked: false, dropdown_clicked: nil)}
  end

  @impl true
  def handle_event("clicked", _params, socket) do
    {:noreply, assign(socket, clicked: true)}
  end

  @impl true
  def handle_event("dropdown-clicked", %{"option" => option}, socket) do
    {:noreply, assign(socket, dropdown_clicked: option)}
  end
end