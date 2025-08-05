defmodule SuperdupernovaWeb.Widgets.Action do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc """
  Button widget with variants and sizes
  """
  attr :type, :string, default: "button"
  attr :variant, :string, default: "primary", 
    values: ["primary", "secondary", "accent", "neutral", "ghost", "link", "info", "success", "warning", "error"]
  attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]
  attr :grid_size, :string, default: "2x1"
  attr :loading, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :outline, :boolean, default: false
  attr :wide, :boolean, default: false
  attr :block, :boolean, default: false
  attr :rest, :global, include: ~w(phx-click phx-disable-with form)
  
  slot :inner_block, required: true

  def widget_button(assigns) do
    ~H"""
    <div class={grid_size_class(@grid_size)}>
      <button
        type={@type}
        class={button_classes(@variant, @size, @outline, @wide, @block)}
        disabled={@disabled || @loading}
        {@rest}
      >
        <%= if @loading do %>
          <span class="loading loading-spinner"></span>
        <% end %>
        <%= render_slot(@inner_block) %>
      </button>
    </div>
    """
  end

  defp button_classes(variant, size, outline, wide, block) do
    base = "btn"
    variant_class = if outline, do: "btn-outline btn-#{variant}", else: "btn-#{variant}"
    size_class = "btn-#{size}"
    wide_class = if wide, do: "btn-wide", else: ""
    block_class = if block, do: "btn-block", else: ""
    
    [base, variant_class, size_class, wide_class, block_class]
    |> Enum.filter(&(&1 != ""))
    |> Enum.join(" ")
  end

  @doc """
  Icon button widget
  """
  attr :variant, :string, default: "ghost"
  attr :size, :string, default: "md"
  attr :shape, :string, default: "square", values: ["square", "circle"]
  attr :rest, :global
  
  slot :inner_block, required: true

  def icon_button(assigns) do
    ~H"""
    <div class="widget-1x1">
      <button
        type="button"
        class={icon_button_classes(@variant, @size, @shape)}
        {@rest}
      >
        <%= render_slot(@inner_block) %>
      </button>
    </div>
    """
  end

  @doc """
  Button group widget
  """
  slot :inner_block, required: true

  def button_group(assigns) do
    ~H"""
    <div class="btn-group">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp icon_button_classes(variant, size, shape) do
    base = "btn"
    variant_class = "btn-#{variant}"
    size_class = "btn-#{size}"
    shape_class = "btn-#{shape}"
    
    [base, variant_class, size_class, shape_class]
    |> Enum.join(" ")
  end

  @doc """
  Modal widget for dialogs
  """
  attr :id, :string, required: true
  attr :title, :string, required: true
  attr :open, :boolean, default: false
  
  slot :inner_block, required: true
  slot :actions

  def modal(assigns) do
    ~H"""
    <dialog id={@id} class="modal" open={@open}>
      <div class="modal-box">
        <h3 class="font-bold text-lg"><%= @title %></h3>
        <div class="py-4">
          <%= render_slot(@inner_block) %>
        </div>
        <%= if @actions != [] do %>
          <div class="modal-action">
            <%= render_slot(@actions) %>
          </div>
        <% else %>
          <div class="modal-action">
            <button class="btn" phx-click={hide_modal(@id)}>Close</button>
          </div>
        <% end %>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button phx-click={hide_modal(@id)}>close</button>
      </form>
    </dialog>
    """
  end

  def show_modal(js \\ %JS{}, id) do
    js
    |> JS.show(to: "##{id}")
    |> JS.add_class("modal-open", to: "##{id}")
  end

  def hide_modal(js \\ %JS{}, id) do
    js
    |> JS.hide(to: "##{id}")
    |> JS.remove_class("modal-open", to: "##{id}")
  end

  @doc """
  Dropdown widget
  """
  attr :label, :string, required: true
  attr :variant, :string, default: "neutral"
  attr :size, :string, default: "4x1"
  
  slot :inner_block, required: true

  def dropdown(assigns) do
    ~H"""
    <div class={grid_size_class(@size)}>
      <div class="dropdown w-full">
        <label tabindex="0" class={"btn btn-#{@variant} w-full"}>
          <%= @label %>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
          </svg>
        </label>
        <ul tabindex="0" class="dropdown-content menu p-2 shadow bg-base-100 rounded-box w-52">
          <%= render_slot(@inner_block) %>
        </ul>
      </div>
    </div>
    """
  end

  @doc """
  Dropdown item
  """
  attr :rest, :global
  
  slot :inner_block, required: true

  def dropdown_item(assigns) do
    ~H"""
    <li><a {@rest}><%= render_slot(@inner_block) %></a></li>
    """
  end

  defp grid_size_class("1x1"), do: "widget-1x1"
  defp grid_size_class("2x1"), do: "widget-2x1"
  defp grid_size_class("4x1"), do: "widget-4x1"
  defp grid_size_class("6x1"), do: "widget-6x1"
  defp grid_size_class("12x1"), do: "widget-12x1"
  defp grid_size_class(_), do: "widget-2x1"
end