# Superdupernova Lego-Brick UI System Proposal

## Executive Summary

This document proposes a comprehensive lego-brick UI component system for Superdupernova that prioritizes simplicity, maintainability, and predictability. The system is built on a 4pt (0.25rem) atomic unit foundation, integrates seamlessly with Ash Framework validation, and uses Phoenix LiveView's native form components alongside DaisyUI styling.

## Core Design Principles

### 1. Atomic Unit Foundation
- **Base Unit**: 4pt (0.25rem) 
- **Rationale**: Provides fine-grained control while maintaining visual consistency
- **Implementation**: All spacing, sizing, and layout calculations derive from this base unit

### 2. Grid System Architecture
- **Column Count**: 12-column base grid
- **Gutter**: 16pt (4 units / 1rem) standard spacing
- **Full-Width Design**: Uses entire screen width with thin padding
- **Desktop-First**: No mobile breakpoints, relies on user zoom for large monitors
- **Form Readability**: Use 6x1 widgets (~50% width) for optimal form inputs

### 3. Widget Size Standardization
Each widget has predictable dimensions based on grid units:
- **1x1**: 1 column × 1 row (minimum viable size)
- **2x1**: 2 columns × 1 row (compact inputs)
- **4x1**: 4 columns × 1 row (standard inputs)
- **6x1**: 6 columns × 1 row (half-width components)
- **12x1**: 12 columns × 1 row (full-width components)
- **12x2**: 12 columns × 2 rows (textarea, multi-line)
- **12x4**: 12 columns × 4 rows (cards, complex forms)

## Grid Implementation

### Tailwind Configuration

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      spacing: {
        // Base unit multipliers (4pt = 0.25rem)
        'unit': '0.25rem',    // 4pt
        'unit-2': '0.5rem',   // 8pt
        'unit-3': '0.75rem',  // 12pt
        'unit-4': '1rem',     // 16pt (standard gutter)
        'unit-6': '1.5rem',   // 24pt
        'unit-8': '2rem',     // 32pt
        'unit-12': '3rem',    // 48pt
        'unit-16': '4rem',    // 64pt
      },
      gridTemplateColumns: {
        // Lego grid system
        'lego': 'repeat(12, minmax(0, 1fr))',
      },
      gap: {
        'lego': '1rem', // Standard 16pt gutter
      }
    }
  }
}
```

### Base Container Styles

```css
/* app.css */
:root {
  --lego-unit: 0.25rem;
  --lego-gutter: 1rem;
  --lego-columns: 12;
}

.lego-container {
  @apply w-full px-2 py-2; /* Thin padding for full-width design */
}

.lego-grid {
  @apply grid grid-cols-12 gap-4;
  grid-auto-rows: minmax(100px, auto); /* Consistent row heights */
}

/* Prevent horizontal scroll */
.lego-page {
  @apply overflow-x-hidden overflow-y-auto;
  min-height: 100vh;
}
```

## Widget Categories

### 1. Form Input Widgets

#### TextInput Widget
```elixir
defmodule MyAppWeb.Widgets.TextInput do
  use Phoenix.Component
  import MyAppWeb.CoreComponents

  attr :field, Phoenix.HTML.FormField, required: true
  attr :label, :string, default: nil
  attr :placeholder, :string, default: ""
  attr :size, :string, default: "4x1", values: ["2x1", "4x1", "6x1", "12x1"]
  attr :rest, :global, include: ~w(type)

  def text_input(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <fieldset class="fieldset">
        <%= if @label do %>
          <label class="label"><%= @label %></label>
        <% end %>
        <input
          id={@field.id}
          name={@field.name}
          value={@field.value}
          class="input input-bordered w-full"
          placeholder={@placeholder}
          {@rest}
        />
        <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
          <%= msg %>
        </.error>
      </fieldset>
    </div>
    """
  end

  defp size_class("2x1"), do: "col-span-2"
  defp size_class("4x1"), do: "col-span-4"
  defp size_class("6x1"), do: "col-span-6"
  defp size_class("12x1"), do: "col-span-12"
end
```

#### SelectInput Widget
```elixir
defmodule MyAppWeb.Widgets.SelectInput do
  use Phoenix.Component
  import MyAppWeb.CoreComponents

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
          <label class="label"><%= @label %></label>
        <% end %>
        <select
          id={@field.id}
          name={@field.name}
          class="select select-bordered w-full"
        >
          <option value=""><%= @prompt %></option>
          <%= for {label, value} <- @options do %>
            <option value={value} selected={value == @field.value}>
              <%= label %>
            </option>
          <% end %>
        </select>
        <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
          <%= msg %>
        </.error>
      </fieldset>
    </div>
    """
  end

  defp size_class(size), do: # Same as TextInput
end
```

### 2. Action Widgets

#### Button Widget
```elixir
defmodule MyAppWeb.Widgets.Button do
  use Phoenix.Component

  attr :type, :string, default: "button"
  attr :variant, :string, default: "primary", values: ["primary", "secondary", "neutral", "ghost"]
  attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]
  attr :loading, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :grid_size, :string, default: "2x1"
  attr :rest, :global, include: ~w(phx-click phx-disable-with)
  
  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <div class={size_class(@grid_size)}>
      <button
        type={@type}
        class={button_classes(@variant, @size)}
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

  defp button_classes(variant, size) do
    base = "btn w-full"
    variant_class = "btn-#{variant}"
    size_class = "btn-#{size}"
    "#{base} #{variant_class} #{size_class}"
  end

  defp size_class(size), do: # Grid sizing logic
end
```

### 3. Display Widgets

#### Card Widget
```elixir
defmodule MyAppWeb.Widgets.Card do
  use Phoenix.Component

  attr :title, :string, required: true
  attr :size, :string, default: "6x4", values: ["4x4", "6x4", "12x4", "12x6"]
  attr :bordered, :boolean, default: true
  
  slot :actions
  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <div class={size_class(@size)}>
      <div class={card_classes(@bordered)}>
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

  defp card_classes(bordered) do
    base = "card bg-base-100 h-full"
    border = if bordered, do: "card-border", else: ""
    "#{base} #{border}"
  end

  defp size_class(size), do: # Grid sizing logic
end
```

### 4. Layout Widgets

#### FormSection Widget
```elixir
defmodule MyAppWeb.Widgets.FormSection do
  use Phoenix.Component

  attr :title, :string, required: true
  attr :columns, :integer, default: 12
  
  slot :inner_block, required: true

  def form_section(assigns) do
    ~H"""
    <div class="col-span-12 mb-unit-8">
      <h3 class="text-lg font-semibold mb-unit-4"><%= @title %></h3>
      <div class="grid grid-cols-12 gap-lego">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
```

## Ash Framework Integration

### Form Creation Pattern
```elixir
defmodule MyAppWeb.BusinessLive.New do
  use MyAppWeb, :live_view
  
  import MyAppWeb.Widgets.{TextInput, SelectInput, Button, Card, FormSection}

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <div class="lego-container">
        <div class="lego-grid">
          <.card title="Create New Business" size="12x6">
            <.form for={@form} phx-change="validate" phx-submit="save">
              <.form_section title="Basic Information">
                <.text_input field={@form[:name]} label="Business Name" size="6x1" />
                <.text_input field={@form[:email]} label="Email" type="email" size="6x1" />
              </.form_section>
              
              <.form_section title="Locations">
                <.inputs_for :let={location} field={@form[:locations]}>
                  <.text_input field={location[:name]} label="Location Name" size="4x1" />
                  <.text_input field={location[:address]} label="Address" size="6x1" />
                  <.button variant="ghost" size="sm" grid_size="2x1" 
                    phx-click="remove-location" 
                    phx-value-path={location.name}>
                    Remove
                  </.button>
                </.inputs_for>
                <.button variant="secondary" grid_size="4x1" phx-click="add-location">
                  Add Location
                </.button>
              </.form_section>
              
              <:actions>
                <.button type="submit" variant="primary" loading={@saving}>
                  Save Business
                </.button>
              </:actions>
            </.form>
          </.card>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = 
      Business
      |> AshPhoenix.Form.for_create(:create, forms: [auto?: true])
      
    {:ok, assign(socket, form: form, saving: false)}
  end

  @impl true
  def handle_event("validate", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)
    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"form" => params}, socket) do
    socket = assign(socket, saving: true)
    
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, business} ->
        {:noreply,
         socket
         |> put_flash(:info, "Business created successfully")
         |> push_navigate(to: ~p"/businesses/#{business.id}")}

      {:error, form} ->
        {:noreply, assign(socket, form: form, saving: false)}
    end
  end

  @impl true
  def handle_event("add-location", _, socket) do
    form = AshPhoenix.Form.add_form(socket.assigns.form, [:locations])
    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("remove-location", %{"path" => path}, socket) do
    form = AshPhoenix.Form.remove_form(socket.assigns.form, path)
    {:noreply, assign(socket, form: form)}
  end
end
```

## Widget Catalog

### Input Widgets (Form-based)
1. **TextInput** (2x1, 4x1, 6x1, 12x1)
2. **EmailInput** (4x1, 6x1)
3. **PasswordInput** (4x1, 6x1)
4. **NumberInput** (2x1, 4x1)
5. **DateInput** (4x1)
6. **TimeInput** (2x1, 4x1)
7. **DateTimeInput** (6x1)
8. **TextArea** (6x2, 12x2, 12x4)
9. **SelectInput** (4x1, 6x1)
10. **MultiSelect** (6x2, 12x2)
11. **RadioGroup** (4x2, 6x2)
12. **CheckboxGroup** (4x2, 6x2)
13. **Toggle** (2x1)
14. **FileInput** (6x1, 12x1)
15. **ColorPicker** (2x1)
16. **RangeSlider** (4x1, 6x1)

### Display Widgets
1. **Card** (4x4, 6x4, 12x4, 12x6)
2. **Alert** (12x1)
3. **Badge** (1x1)
4. **Stat** (3x2, 4x2)
5. **Table** (12xN)
6. **List** (6xN, 12xN)
7. **Avatar** (1x1, 2x2)
8. **Progress** (4x1, 6x1, 12x1)
9. **Skeleton** (matches parent size)
10. **Empty** (12x4)

### Action Widgets
1. **Button** (2x1, 4x1, 6x1, 12x1)
2. **IconButton** (1x1)
3. **ButtonGroup** (4x1, 6x1)
4. **Dropdown** (2x1, 4x1)
5. **Modal** (overlay, not grid-based)
6. **Drawer** (overlay, not grid-based)

### Layout Widgets
1. **FormSection** (12xN)
2. **Divider** (12x0)
3. **Spacer** (NxN)
4. **Container** (12xN)
5. **Tabs** (12x2 + content)
6. **Accordion** (12xN)
7. **Steps** (12x2)

## Usage Examples

### Simple Form
```elixir
<div class="lego-grid">
  <.text_input field={@form[:first_name]} label="First Name" size="6x1" />
  <.text_input field={@form[:last_name]} label="Last Name" size="6x1" />
  <.email_input field={@form[:email]} label="Email" size="12x1" />
  <.button type="submit" variant="primary" grid_size="4x1">
    Submit
  </.button>
</div>
```

### Dashboard Layout
```elixir
<div class="lego-grid">
  <.stat title="Total Users" value="1,234" size="3x2" />
  <.stat title="Revenue" value="$45,678" size="3x2" />
  <.stat title="Active Sessions" value="89" size="3x2" />
  <.stat title="Conversion Rate" value="3.4%" size="3x2" />
  
  <.card title="Recent Activity" size="12x6">
    <.table data={@activities} columns={["User", "Action", "Time"]} />
  </.card>
</div>
```

## Implementation Guidelines

### 1. Widget Creation Process
- Start with the base Phoenix Component structure
- Apply DaisyUI classes for styling
- Add grid size variants using Tailwind's col-span
- Integrate with Phoenix.HTML.FormField for form widgets
- Ensure Ash validation errors display properly

### 2. Naming Conventions
- Widget modules: `MyAppWeb.Widgets.{WidgetName}`
- Component functions: snake_case (e.g., `text_input/1`)
- Size attributes: "COLxROW" format (e.g., "4x1")
- CSS classes: Use DaisyUI conventions

### 3. Testing Strategy
- Unit test each widget in isolation
- Integration test with Ash forms
- Visual regression testing for grid layouts
- Accessibility testing with screen readers

### 4. Documentation Requirements
- Each widget must have:
  - Purpose description
  - Size variants available
  - Required and optional attributes
  - Usage example
  - Ash integration notes

## Migration Path

### Phase 1: Core Widgets (Week 1-2)
- Implement basic input widgets
- Create button variants
- Set up grid system CSS

### Phase 2: Form Integration (Week 2-3)
- Connect widgets to AshPhoenix.Form
- Implement validation display
- Create form layout helpers

### Phase 3: Complex Widgets (Week 3-4)
- Build display widgets (cards, tables)
- Implement layout containers
- Add interactive components

### Phase 4: Polish & Documentation (Week 4-5)
- Complete widget catalog
- Write comprehensive docs
- Create example pages

## Benefits

1. **Predictability**: Fixed grid sizes ensure consistent layouts
2. **Simplicity**: AI agents can easily understand and use the system
3. **Maintainability**: Centralized styling through app.css
4. **Flexibility**: 4pt base unit allows fine-grained adjustments
5. **Integration**: Seamless with Ash validation and Phoenix LiveView
6. **Performance**: Leverages LiveView's efficient DOM patching

## Conclusion

This lego-brick UI system provides a robust foundation for building Superdupernova's interface. By standardizing on a 4pt grid system, leveraging Phoenix LiveView's native components, and integrating tightly with Ash Framework's validation patterns, we create a development experience that is both powerful and approachable for AI agents and junior developers alike.

The system's emphasis on composition over inheritance, combined with its desktop-first responsive design, ensures that UIs built with these widgets will be consistent, maintainable, and performant.