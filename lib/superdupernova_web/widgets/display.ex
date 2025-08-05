defmodule SuperdupernovaWeb.Widgets.Display do
  use Phoenix.Component
  import Phoenix.HTML

  @doc """
  Card widget for content display
  """
  attr :title, :string, required: true
  attr :size, :string, default: "6x4", values: ["4x4", "6x4", "12x4", "12x6"]
  attr :bordered, :boolean, default: true
  attr :compact, :boolean, default: false
  attr :image_url, :string, default: nil
  
  slot :actions
  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <div class={grid_size_class(@size)}>
      <div class={card_classes(@bordered, @compact)}>
        <%= if @image_url do %>
          <figure>
            <img src={@image_url} alt={@title} />
          </figure>
        <% end %>
        <div class="card-body">
          <h2 class="card-title"><%= @title %></h2>
          <div class="card-content">
            <%= render_slot(@inner_block) %>
          </div>
          <%= if @actions != [] do %>
            <div class="card-actions justify-end">
              <%= render_slot(@actions) %>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  defp card_classes(bordered, compact) do
    base = "card bg-base-100 h-full shadow-sm"
    border = if bordered, do: "card-bordered", else: ""
    compact_class = if compact, do: "card-compact", else: ""
    
    [base, border, compact_class]
    |> Enum.filter(&(&1 != ""))
    |> Enum.join(" ")
  end

  @doc """
  Alert widget for notifications
  """
  attr :type, :string, default: "info", 
    values: ["info", "success", "warning", "error"]
  attr :title, :string, default: nil
  attr :dismissible, :boolean, default: false
  
  slot :inner_block, required: true

  def alert(assigns) do
    ~H"""
    <div class="widget-12x1">
      <div class={"alert alert-#{@type}"} role="alert">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" 
          class="stroke-current shrink-0 w-6 h-6">
          <%= raw(alert_icon(@type)) %>
        </svg>
        <div>
          <%= if @title do %>
            <h3 class="font-bold"><%= @title %></h3>
          <% end %>
          <div class="text-sm"><%= render_slot(@inner_block) %></div>
        </div>
        <%= if @dismissible do %>
          <button class="btn btn-sm btn-ghost" phx-click={Phoenix.LiveView.JS.hide(to: ".alert")}>✕</button>
        <% end %>
      </div>
    </div>
    """
  end

  @doc """
  Badge widget for labels and tags
  """
  attr :variant, :string, default: "neutral",
    values: ["neutral", "primary", "secondary", "accent", "ghost", "info", "success", "warning", "error"]
  attr :outline, :boolean, default: false
  attr :size, :string, default: "md", values: ["sm", "md", "lg"]
  
  slot :inner_block, required: true

  def badge(assigns) do
    ~H"""
    <span class={badge_classes(@variant, @size, @outline)}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end

  defp alert_icon("info") do
    ~s(<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>)
  end

  defp alert_icon("success") do
    ~s(<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>)
  end

  defp alert_icon("warning") do
    ~s(<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>)
  end

  defp alert_icon("error") do
    ~s(<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>)
  end

  defp badge_classes(variant, size, outline) do
    base = "badge"
    variant_class = if outline, do: "badge-outline badge-#{variant}", else: "badge-#{variant}"
    size_class = "badge-#{size}"
    
    [base, variant_class, size_class]
    |> Enum.filter(&(&1 != ""))
    |> Enum.join(" ")
  end

  @doc """
  Table widget for tabular data
  """
  attr :data, :list, required: true
  attr :columns, :list, required: true
  attr :striped, :boolean, default: true
  attr :hover, :boolean, default: true
  attr :compact, :boolean, default: false

  def widget_table(assigns) do
    table_class = [
      "table",
      assigns.striped && "table-zebra",
      assigns.hover && "table-hover", 
      assigns.compact && "table-compact"
    ]
    |> Enum.filter(& &1)
    |> Enum.join(" ")
    
    assigns = assign(assigns, :table_class, table_class)
    
    ~H"""
    <div class="widget-12x1 overflow-x-auto">
      <table class={@table_class}>
        <thead>
          <tr>
            <%= for col <- @columns do %>
              <th><%= col.label %></th>
            <% end %>
          </tr>
        </thead>
        <tbody>
          <%= for row <- @data do %>
            <tr>
              <%= for col <- @columns do %>
                <td><%= Map.get(row, col.key) %></td>
              <% end %>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  @doc """
  Progress bar widget
  """
  attr :value, :integer, required: true
  attr :max, :integer, default: 100
  attr :variant, :string, default: "primary"
  attr :size, :string, default: "4x1"

  def progress(assigns) do
    ~H"""
    <div class={grid_size_class(@size)}>
      <progress class={"progress progress-#{@variant}"} value={@value} max={@max}>
        <%= @value %>%
      </progress>
    </div>
    """
  end

  @doc """
  Stat widget for metrics display
  """
  attr :title, :string, required: true
  attr :value, :string, required: true
  attr :desc, :string, default: nil
  attr :size, :string, default: "3x2"

  def stat(assigns) do
    ~H"""
    <div class={grid_size_class(@size)}>
      <div class="stat bg-base-100 rounded-lg shadow-sm">
        <div class="stat-title"><%= @title %></div>
        <div class="stat-value"><%= @value %></div>
        <%= if @desc do %>
          <div class="stat-desc"><%= @desc %></div>
        <% end %>
      </div>
    </div>
    """
  end

  defp grid_size_class("3x2"), do: "widget-4x1"
  defp grid_size_class("4x4"), do: "widget-4x1"
  defp grid_size_class("6x4"), do: "widget-6x1"
  defp grid_size_class("12x4"), do: "widget-12x1"
  defp grid_size_class("12x6"), do: "widget-12x1"
  defp grid_size_class(_), do: "widget-6x1"
end