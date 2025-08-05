defmodule SuperdupernovaWeb.Widgets.Form do
  use Phoenix.Component
  import SuperdupernovaWeb.CoreComponents

  @doc """
  Text input widget with grid sizing
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :placeholder, :string, default: ""
  attr :size, :string, default: "4x1", values: ["2x1", "4x1", "6x1", "12x1"]
  attr :rest, :global, include: ~w(type required pattern title autocomplete)

  def text_input(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label" for={@field.id}><%= @label %></label>
        <% end %>
        <input
          id={@field.id}
          name={@field.name}
          value={@field.value}
          class="input input-bordered w-full"
          placeholder={@placeholder}
          phx-feedback-for={@field.name}
          {@rest}
        />
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  @doc """
  Email input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :placeholder, :string, default: "email@example.com"
  attr :size, :string, default: "4x1"

  def email_input(assigns) do
    assigns = assign(assigns, :type, "email")
    ~H"""
    <.text_input field={@field} label={@label} placeholder={@placeholder} 
      size={@size} type={@type} autocomplete="email" />
    """
  end

  @doc """
  Password input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :placeholder, :string, default: ""
  attr :size, :string, default: "4x1"

  def password_input(assigns) do
    assigns = assign(assigns, :type, "password")
    ~H"""
    <.text_input field={@field} label={@label} placeholder={@placeholder} 
      size={@size} type={@type} autocomplete="current-password" />
    """
  end

  @doc """
  Number input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :placeholder, :string, default: ""
  attr :size, :string, default: "2x1"
  attr :min, :integer, default: nil
  attr :max, :integer, default: nil
  attr :step, :any, default: nil

  def number_input(assigns) do
    extra_attrs = 
      []
      |> then(fn attrs -> if assigns.min, do: [{:min, assigns.min} | attrs], else: attrs end)
      |> then(fn attrs -> if assigns.max, do: [{:max, assigns.max} | attrs], else: attrs end)
      |> then(fn attrs -> if assigns.step, do: [{:step, assigns.step} | attrs], else: attrs end)
    
    assigns = assign(assigns, :extra_attrs, extra_attrs)
    
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label" for={@field.id}><%= @label %></label>
        <% end %>
        <input
          id={@field.id}
          name={@field.name}
          value={@field.value}
          type="number"
          class="input input-bordered w-full"
          placeholder={@placeholder}
          phx-feedback-for={@field.name}
          {@extra_attrs}
        />
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  @doc """
  Textarea widget for multi-line text
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :placeholder, :string, default: ""
  attr :size, :string, default: "12x2", values: ["6x2", "12x2", "12x4"]
  attr :rows, :integer, default: nil

  def textarea(assigns) do
    rows = case assigns.size do
      "6x2" -> 3
      "12x2" -> 3
      "12x4" -> 6
      _ -> assigns.rows || 3
    end
    
    assigns = assign(assigns, :rows, rows)
    
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label" for={@field.id}><%= @label %></label>
        <% end %>
        <textarea
          id={@field.id}
          name={@field.name}
          class="textarea textarea-bordered w-full"
          placeholder={@placeholder}
          rows={@rows}
          phx-feedback-for={@field.name}
        ><%= @field.value %></textarea>
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  @doc """
  Select dropdown widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :options, :list, required: true
  attr :prompt, :string, default: "Choose an option"
  attr :size, :string, default: "4x1"

  def select_input(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label" for={@field.id}><%= @label %></label>
        <% end %>
        <select
          id={@field.id}
          name={@field.name}
          class="select select-bordered w-full"
          phx-feedback-for={@field.name}
        >
          <option value=""><%= @prompt %></option>
          <%= for {label, value} <- @options do %>
            <option value={value} selected={to_string(value) == to_string(@field.value)}>
              <%= label %>
            </option>
          <% end %>
        </select>
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  @doc """
  Checkbox widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, required: true
  attr :size, :string, default: "4x1"

  def checkbox(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <label class="label cursor-pointer">
        <span class="label-text"><%= @label %></span>
        <input
          type="checkbox"
          id={@field.id}
          name={@field.name}
          value="true"
          checked={@field.value == true || @field.value == "true"}
          class="checkbox"
          phx-feedback-for={@field.name}
        />
      </label>
      <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
        <p class="mt-2 text-sm text-error"><%= msg %></p>
      <% end %>
    </div>
    """
  end

  @doc """
  Toggle switch widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, required: true
  attr :size, :string, default: "4x1"

  def toggle(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <label class="label cursor-pointer">
        <span class="label-text"><%= @label %></span>
        <input
          type="checkbox"
          id={@field.id}
          name={@field.name}
          value="true"
          checked={@field.value == true || @field.value == "true"}
          class="toggle"
          phx-feedback-for={@field.name}
        />
      </label>
      <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
        <p class="mt-2 text-sm text-error"><%= msg %></p>
      <% end %>
    </div>
    """
  end

  @doc """
  Radio group widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :options, :list, required: true
  attr :size, :string, default: "4x2"

  def radio_group(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <legend class="label"><%= @label %></legend>
        <% end %>
        <div class="space-y-2">
          <%= for {label, value} <- @options do %>
            <label class="label cursor-pointer justify-start gap-2">
              <input
                type="radio"
                name={@field.name}
                value={value}
                checked={to_string(value) == to_string(@field.value)}
                class="radio"
                phx-feedback-for={@field.name}
              />
              <span class="label-text"><%= label %></span>
            </label>
          <% end %>
        </div>
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  @doc """
  File input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :accept, :string, default: nil
  attr :size, :string, default: "6x1"

  def file_input(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label"><%= @label %></label>
        <% end %>
        <input
          type="file"
          id={@field.id}
          name={@field.name}
          class="file-input file-input-bordered w-full"
          accept={@accept}
          phx-feedback-for={@field.name}
        />
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  @doc """
  Date input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :size, :string, default: "4x1"

  def date_input(assigns) do
    ~H"""
    <.text_input field={@field} label={@label} size={@size} type="date" />
    """
  end

  @doc """
  Time input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :size, :string, default: "4x1"

  def time_input(assigns) do
    ~H"""
    <.text_input field={@field} label={@label} size={@size} type="time" />
    """
  end

  @doc """
  DateTime input widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :size, :string, default: "6x1"

  def datetime_input(assigns) do
    ~H"""
    <.text_input field={@field} label={@label} size={@size} type="datetime-local" />
    """
  end

  @doc """
  Range slider widget
  """
  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :size, :string, default: "4x1"
  attr :min, :integer, default: 0
  attr :max, :integer, default: 100
  attr :step, :integer, default: 1

  def range_slider(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label" for={@field.id}>
            <%= @label %>
            <span class="text-sm opacity-70">(<%= @field.value || @min %>)</span>
          </label>
        <% end %>
        <input
          type="range"
          id={@field.id}
          name={@field.name}
          value={@field.value || @min}
          min={@min}
          max={@max}
          step={@step}
          class="range"
          phx-feedback-for={@field.name}
        />
        <div class="w-full flex justify-between text-xs px-2">
          <span><%= @min %></span>
          <span><%= @max %></span>
        </div>
        <%= for msg <- Enum.map(@field.errors, &translate_error(&1)) do %>
          <p class="mt-2 text-sm text-error"><%= msg %></p>
        <% end %>
      </fieldset>
    </div>
    """
  end

  defp size_class("2x1"), do: "widget-2x1"
  defp size_class("4x1"), do: "widget-4x1"
  defp size_class("4x2"), do: "widget-4x1"
  defp size_class("6x1"), do: "widget-6x1"
  defp size_class("6x2"), do: "widget-6x1"
  defp size_class("12x1"), do: "widget-12x1"
  defp size_class("12x2"), do: "widget-12x1"
  defp size_class("12x4"), do: "widget-12x1"
  defp size_class(_), do: "widget-4x1"
end