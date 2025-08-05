defmodule SuperdupernovaWeb.Widgets do
  @moduledoc """
  Import all widget components for easy use in LiveViews
  """
  
  defmacro __using__(_opts) do
    quote do
      import SuperdupernovaWeb.Widgets.Layout
      import SuperdupernovaWeb.Widgets.Form
      import SuperdupernovaWeb.Widgets.Display
      import SuperdupernovaWeb.Widgets.Action
    end
  end
end