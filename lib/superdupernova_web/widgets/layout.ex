defmodule SuperdupernovaWeb.Widgets.Layout do
  use Phoenix.Component
  
  @doc """
  Container widget for consistent page layout
  """
  attr :class, :string, default: ""
  slot :inner_block, required: true

  def lego_container(assigns) do
    ~H"""
    <div class={"lego-container #{@class}"}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc """
  Grid widget for layout
  """
  attr :class, :string, default: ""
  slot :inner_block, required: true

  def lego_grid(assigns) do
    ~H"""
    <div class={"lego-grid #{@class}"}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc """
  Tabs widget for tabbed interfaces
  """
  attr :active_tab, :atom, required: true
  attr :tabs, :list, required: true
  
  slot :inner_block, required: true

  def tabs(assigns) do
    ~H"""
    <div class="widget-12x1">
      <div role="tablist" class="tabs tabs-boxed">
        <%= for {id, label} <- @tabs do %>
          <a 
            role="tab" 
            class={"tab #{if @active_tab == id, do: "tab-active"}"}
            phx-click="switch_tab"
            phx-value-tab={id}
          >
            <%= label %>
          </a>
        <% end %>
      </div>
      <div class="mt-4">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  @doc """
  Tab panel - shows content for specific tab
  """
  attr :tab, :atom, required: true
  attr :active_tab, :atom, required: true
  
  slot :inner_block, required: true

  def tab_panel(assigns) do
    ~H"""
    <div class={if @tab == @active_tab, do: "block", else: "hidden"}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc """
  Divider widget for visual separation
  """
  attr :label, :string, default: nil
  attr :vertical, :boolean, default: false

  def divider(assigns) do
    ~H"""
    <div class={if @vertical, do: "divider divider-horizontal", else: "widget-12x1 divider"}>
      <%= @label %>
    </div>
    """
  end

  @doc """
  Spacer widget for adding space
  """
  attr :size, :string, default: "1", values: ["1", "2", "4", "8", "12", "16"]

  def spacer(assigns) do
    ~H"""
    <div class={"h-unit-#{@size} widget-12x1"}></div>
    """
  end

  @doc """
  Form section widget for grouping form elements
  """
  attr :title, :string, required: true
  attr :description, :string, default: nil
  
  slot :inner_block, required: true

  def form_section(assigns) do
    ~H"""
    <div class="widget-12x1 mb-unit-8">
      <h3 class="text-lg font-semibold mb-unit-2"><%= @title %></h3>
      <%= if @description do %>
        <p class="text-sm opacity-70 mb-unit-4"><%= @description %></p>
      <% end %>
      <div class="grid grid-cols-12 gap-lego">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
  
  @doc """
  Accordion widget for collapsible content
  """
  attr :items, :list, required: true
  attr :multiple, :boolean, default: false
  
  def accordion(assigns) do
    ~H"""
    <div class="widget-12x1">
      <%= for {id, title, content} <- @items do %>
        <div class="collapse collapse-arrow bg-base-200 mb-2">
          <input 
            type={if @multiple, do: "checkbox", else: "radio"} 
            name="accordion-group"
            id={"accordion-#{id}"}
          /> 
          <label for={"accordion-#{id}"} class="collapse-title text-lg font-medium">
            <%= title %>
          </label>
          <div class="collapse-content"> 
            <p><%= content %></p>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
  
  @doc """
  Drawer widget for slide-out panels
  """
  attr :id, :string, required: true
  attr :side, :string, default: "left", values: ["left", "right"]
  
  slot :toggle, required: true
  slot :content, required: true
  slot :main, required: true
  
  def drawer(assigns) do
    ~H"""
    <div class="drawer">
      <input id={@id} type="checkbox" class="drawer-toggle" />
      <div class="drawer-content">
        <!-- Page content -->
        <%= render_slot(@main) %>
        <!-- Toggle button -->
        <label for={@id} class="drawer-button btn btn-primary">
          <%= render_slot(@toggle) %>
        </label>
      </div> 
      <div class="drawer-side">
        <label for={@id} class="drawer-overlay"></label>
        <div class={"menu p-4 w-80 min-h-full bg-base-200 text-base-content"}>
          <!-- Sidebar content -->
          <%= render_slot(@content) %>
        </div>
      </div>
    </div>
    """
  end
end