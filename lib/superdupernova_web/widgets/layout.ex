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
end