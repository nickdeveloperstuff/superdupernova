# Complete Widget Creation Guide for Superdupernova Lego-Brick UI System

## Table of Contents
1. [Overview & Architecture](#overview--architecture)
2. [Pre-requisites & Setup](#pre-requisites--setup)
3. [Widget Categories & Organization](#widget-categories--organization)
4. [Step-by-Step Widget Creation Process](#step-by-step-widget-creation-process)
5. [Common Patterns & Best Practices](#common-patterns--best-practices)
6. [Testing Your Widget](#testing-your-widget)
7. [Integration with Ash Framework](#integration-with-ash-framework)
8. [Troubleshooting Common Issues](#troubleshooting-common-issues)
9. [Widget Conversion Checklist](#widget-conversion-checklist)
10. [Advanced Widget Features](#advanced-widget-features)

---

## Overview & Architecture

The Superdupernova Lego-Brick UI System is a modular, grid-based widget system built on Phoenix LiveView with Tailwind CSS and DaisyUI. It provides consistent, reusable UI components that snap into a 12-column grid system.

### Core Principles
- **Desktop-first design**: Full-width layouts with thin padding for maximum screen usage
- **4pt atomic units**: All spacing based on 0.25rem (4pt) increments
- **12-column grid**: Flexible grid system with 16pt standard gutter
- **Widget-based composition**: All UI elements are widgets that fit into the grid
- **DaisyUI styling**: Leverages DaisyUI component classes for consistent theming

### Architecture Components
```
lib/superdupernova_web/
├── widgets.ex              # Main module that imports all widget categories
├── widgets/
│   ├── form.ex            # Form input widgets
│   ├── display.ex         # Display/presentation widgets
│   ├── action.ex          # Interactive action widgets
│   └── layout.ex          # Layout and container widgets
```

---

## Pre-requisites & Setup

### Required Dependencies
1. **Phoenix LiveView** - Already integrated
2. **Tailwind CSS** - Must be configured with custom spacing units
3. **DaisyUI** - Install with: `npm install daisyui`
4. **Ash Framework** (optional) - For advanced form integration

### Tailwind Configuration
Your `assets/tailwind.config.js` must include:
```javascript
module.exports = {
  content: [
    "./lib/**/*.{ex,heex}",
    "./node_modules/daisyui/dist/**/*.js"
  ],
  theme: {
    extend: {
      spacing: {
        'unit': '0.25rem',    // 4pt
        'unit-2': '0.5rem',   // 8pt
        'unit-3': '0.75rem',  // 12pt
        'unit-4': '1rem',     // 16pt (standard gutter)
        'unit-6': '1.5rem',   // 24pt
        'unit-8': '2rem',     // 32pt
        'unit-12': '3rem',    // 48pt
        'unit-16': '4rem',    // 64pt
      }
    }
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark"],
  },
}
```

### CSS Classes
Add to `assets/css/app.css`:
```css
/* Widget Size Classes */
.widget-1x1 { @apply col-span-1; }
.widget-2x1 { @apply col-span-2; }
.widget-3x1 { @apply col-span-3; }
.widget-4x1 { @apply col-span-4; }
.widget-6x1 { @apply col-span-6; }
.widget-8x1 { @apply col-span-8; }
.widget-12x1 { @apply col-span-12; }
.widget-6x2 { @apply col-span-6 row-span-2; }
.widget-12x2 { @apply col-span-12 row-span-2; }
.widget-12x4 { @apply col-span-12 row-span-4; }
```

---

## Widget Categories & Organization

### 1. Form Widgets (`form.ex`)
Input components for user data collection:
- `text_input` - Basic text field
- `email_input` - Email-specific input
- `password_input` - Password field with masking
- `number_input` - Numeric input with min/max/step
- `textarea` - Multi-line text input
- `select_input` - Dropdown selection
- `checkbox` - Boolean checkbox
- `toggle` - Toggle switch
- `radio_group` - Radio button group
- `file_input` - File upload
- `date_input`, `time_input`, `datetime_input` - Date/time pickers
- `range_slider` - Numeric range selector

### 2. Display Widgets (`display.ex`)
Presentation components for showing data:
- `card` - Content container with optional header/footer
- `alert` - Notification messages with icons
- `badge` - Status indicators
- `widget_table` - Data table (renamed to avoid conflicts)
- `progress` - Progress bars
- `stat` - Statistical displays
- `steps` - Progress steps/stepper
- `loading` - Loading spinners
- `skeleton` - Loading placeholders

### 3. Action Widgets (`action.ex`)
Interactive components for user actions:
- `widget_button` - Action buttons (renamed to avoid conflicts)
- `icon_button` - Icon-only buttons
- `button_group` - Grouped buttons
- `modal` - Popup dialogs
- `dropdown` - Dropdown menus
- `dropdown_item` - Dropdown menu items

### 4. Layout Widgets (`layout.ex`)
Structure and organization components:
- `lego_container` - Main container with padding
- `lego_grid` - 12-column grid layout
- `tabs` - Tabbed navigation
- `tab_panel` - Tab content panels
- `divider` - Visual separators
- `spacer` - Spacing elements
- `form_section` - Form grouping
- `accordion` - Collapsible sections
- `drawer` - Slide-out panels

---

## Step-by-Step Widget Creation Process

### Step 1: Determine Widget Category
Decide which module your widget belongs to:
- **Form input?** → `form.ex`
- **Display data?** → `display.ex`
- **User action?** → `action.ex`
- **Layout/structure?** → `layout.ex`

### Step 2: Define Widget Structure
Create a Phoenix Component function with proper attributes:

```elixir
@doc """
Brief description of what the widget does
"""
# Define all attributes with types and defaults
attr :field, Phoenix.HTML.FormField, required: true  # For form widgets
attr :label, :string, default: nil
attr :size, :string, default: "4x1", values: ["2x1", "4x1", "6x1", "12x1"]
attr :class, :string, default: ""
attr :rest, :global, include: ~w(additional html attrs)  # For pass-through attrs
slot :inner_block  # If widget accepts content

def my_widget(assigns) do
  ~H"""
  <!-- Widget HTML here -->
  """
end
```

### Step 3: Implement Grid Sizing
Use the size helper function pattern:

```elixir
defp size_class("2x1"), do: "widget-2x1"
defp size_class("4x1"), do: "widget-4x1"
defp size_class("6x1"), do: "widget-6x1"
defp size_class("12x1"), do: "widget-12x1"
defp size_class(_), do: "widget-4x1"  # Default fallback
```

### Step 4: Apply DaisyUI Classes
Use DaisyUI component classes for consistent styling:
- Forms: `input`, `input-bordered`, `select`, `textarea`, `checkbox`, `toggle`, `radio`
- Buttons: `btn`, `btn-primary`, `btn-sm`, `btn-circle`
- Cards: `card`, `card-body`, `card-title`
- Alerts: `alert`, `alert-info`, `alert-success`, `alert-warning`, `alert-error`
- Tables: `table`, `table-zebra`, `table-compact`

### Step 5: Handle Form Integration
For form widgets, include error handling:

```elixir
def form_widget(assigns) do
  ~H"""
  <div class={size_class(@size)}>
    <fieldset class="fieldset">
      <%= if @label do %>
        <label class="label" for={@field.id}><%= @label %></label>
      <% end %>
      
      <!-- Input element here -->
      <input
        id={@field.id}
        name={@field.name}
        value={@field.value}
        class="input input-bordered w-full"
        phx-feedback-for={@field.name}
        {@rest}
      />
      
      <!-- Error display -->
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end

# Helper function for error translation
defp translate_error({msg, opts}) do
  Enum.reduce(opts, msg, fn {key, value}, acc ->
    String.replace(acc, "%{#{key}}", to_string(value))
  end)
end
```

### Step 6: Add to Module Imports
Ensure your widget is accessible by being in the correct module that gets imported via `use SuperdupernovaWeb.Widgets`.

---

## Common Patterns & Best Practices

### 1. Naming Conventions
- **Avoid conflicts**: If a function name conflicts with CoreComponents, prefix with `widget_`
  - Example: `widget_button` instead of `button`
  - Example: `widget_table` instead of `table`

### 2. Size Attribute Pattern
Always provide a `size` attribute for grid-aware widgets:
```elixir
attr :size, :string, default: "4x1", values: ["2x1", "4x1", "6x1", "12x1"]
```

### 3. Slot Usage
Use slots for widgets that wrap content:
```elixir
slot :inner_block, required: true  # Required content
slot :header  # Optional header slot
slot :footer  # Optional footer slot
```

### 4. Global Attributes
Use `attr :rest, :global` for HTML pass-through:
```elixir
attr :rest, :global, include: ~w(disabled readonly required pattern)
```

### 5. JavaScript Interactions
For widgets needing Phoenix.LiveView.JS:
```elixir
# Use alias instead of import to avoid struct reference errors
alias Phoenix.LiveView.JS

def show_modal(js \\ %JS{}, id) do
  js
  |> JS.show(to: "##{id}")
  |> JS.show(to: "##{id}_overlay")
end
```

### 6. Import Requirements
Different widgets may need different imports:
```elixir
use Phoenix.Component
import Phoenix.HTML  # For raw/1 function (HTML/SVG rendering)
alias Phoenix.LiveView.JS  # For JavaScript commands
```

---

## Testing Your Widget

### 1. Create a Test LiveView
Create a dedicated test page for your widget:

```elixir
defmodule SuperdupernovaWeb.MyWidgetTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets
  
  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">My Widget Test</h1>
        
        <.lego_grid>
          <!-- Test your widget here -->
          <.my_widget size="4x1" label="Test Widget" />
        </.lego_grid>
      </.lego_container>
    </div>
    """
  end
  
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
```

### 2. Add Route
Add to `router.ex`:
```elixir
live "/test/my-widget", MyWidgetTestLive
```

### 3. Visual Testing
Use Puppeteer MCP for automated visual testing:
```javascript
// Navigate to test page
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/test/my-widget")

// Interact with widget
mcp__puppeteer__puppeteer_fill(selector: "#my_input", value: "test")

// Capture screenshot
mcp__puppeteer__puppeteer_screenshot(name: "my_widget_test", width: 1280, height: 800)
```

### 4. Validation Testing
For form widgets, test validation:
- Empty state validation
- Invalid input handling
- Error message display
- Valid state confirmation

---

## Integration with Ash Framework

### 1. Resource Setup
When creating Ash-integrated forms:

```elixir
defmodule MyApp.MyResource do
  use Ash.Resource,
    domain: MyApp.MyDomain,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshPhoenix.Form]
  
  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :email, :string, allow_nil?: false
  end
  
  actions do
    defaults [:create, :read, :update, :destroy]
  end
  
  validations do
    validate string_length(:name, min: 2)  # Note: string_length, not length
    validate match(:email, ~r/@/)
  end
end
```

### 2. Form Creation
```elixir
def mount(_params, _session, socket) do
  form = 
    MyResource
    |> AshPhoenix.Form.for_create(:create)
    |> to_form()
  
  {:ok, assign(socket, form: form)}
end
```

### 3. Form Rendering
Use widgets with Ash forms normally:
```elixir
<.form for={@form} phx-submit="save" phx-change="validate">
  <.lego_grid>
    <.text_input field={@form[:name]} label="Name" size="6x1" />
    <.email_input field={@form[:email]} label="Email" size="6x1" />
  </.lego_grid>
</.form>
```

---

## Troubleshooting Common Issues

### Issue 1: Function Name Conflicts
**Problem**: `function button/1 imported from both SuperdupernovaWeb.Widgets.Action and SuperdupernovaWeb.CoreComponents`

**Solution**: Rename your widget function:
```elixir
def widget_button(assigns) do  # Prefix with widget_
```

### Issue 2: Undefined raw/1 Function
**Problem**: `undefined function raw/1` when rendering HTML/SVG

**Solution**: Add import to your module:
```elixir
import Phoenix.HTML
```

### Issue 3: JS Struct Reference Error
**Problem**: `JS.__struct__/1 is undefined, cannot expand struct JS`

**Solution**: Use alias instead of import:
```elixir
alias Phoenix.LiveView.JS  # Not import!
```

### Issue 4: Size Attribute Not Supported
**Problem**: Widget doesn't respond to size attribute

**Solution**: Ensure size_class/1 helper is defined and used:
```elixir
<div class={size_class(@size)}>
```

### Issue 5: Ash Validation Functions
**Problem**: `validate length/2` function not found

**Solution**: Use correct Ash validation function names:
```elixir
validate string_length(:field, min: 2)  # For strings
validate number(:field, greater_than: 0)  # For numbers
```

### Issue 6: Form Field Errors Not Displaying
**Problem**: Validation errors don't show

**Solution**: Include error handling in widget:
```elixir
<.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
  <%= msg %>
</.error>
```

---

## Widget Conversion Checklist

When converting UI components from other systems into Superdupernova widgets:

### Pre-Conversion Analysis
- [ ] Identify the component's category (form/display/action/layout)
- [ ] List all required attributes and their types
- [ ] Determine grid sizes needed (2x1, 4x1, 6x1, 12x1, etc.)
- [ ] Check for DaisyUI equivalent classes
- [ ] Identify any JavaScript interactions needed

### Implementation Checklist
- [ ] Create function in appropriate widget module
- [ ] Add @doc documentation
- [ ] Define all attributes with proper types
- [ ] Implement size_class helper if needed
- [ ] Apply DaisyUI classes for styling
- [ ] Add error handling for form widgets
- [ ] Include slots for content-wrapping widgets
- [ ] Use proper imports (Phoenix.HTML, JS alias)
- [ ] Handle naming conflicts with prefix

### Testing Checklist
- [ ] Create test LiveView
- [ ] Add route to router
- [ ] Test all size variants
- [ ] Test with empty/invalid data
- [ ] Test JavaScript interactions
- [ ] Capture screenshots for documentation
- [ ] Verify responsive behavior
- [ ] Check accessibility (labels, ARIA)

### Integration Checklist
- [ ] Widget is accessible via `use SuperdupernovaWeb.Widgets`
- [ ] Works with Phoenix forms
- [ ] Compatible with Ash resources (if applicable)
- [ ] Follows existing widget patterns
- [ ] Documentation is complete

---

## Advanced Widget Features

### 1. Dynamic Sizing
Support responsive sizing based on conditions:

```elixir
def adaptive_widget(assigns) do
  size = if assigns.compact, do: "2x1", else: "4x1"
  assigns = assign(assigns, :computed_size, size)
  
  ~H"""
  <div class={size_class(@computed_size)}>
    <!-- Widget content -->
  </div>
  """
end
```

### 2. Compound Widgets
Create widgets that compose other widgets:

```elixir
def form_row(assigns) do
  ~H"""
  <.lego_grid>
    <.text_input field={@form[:first_name]} label="First Name" size="6x1" />
    <.text_input field={@form[:last_name]} label="Last Name" size="6x1" />
  </.lego_grid>
  """
end
```

### 3. Widget Variants
Support multiple visual variants:

```elixir
attr :variant, :string, default: "primary", 
     values: ["primary", "secondary", "success", "warning", "error"]

def alert_widget(assigns) do
  variant_class = case assigns.variant do
    "primary" -> "alert-info"
    "secondary" -> "alert"
    "success" -> "alert-success"
    "warning" -> "alert-warning"
    "error" -> "alert-error"
  end
  
  assigns = assign(assigns, :variant_class, variant_class)
  
  ~H"""
  <div class={"alert #{@variant_class} #{size_class(@size)}"}>
    <%= render_slot(@inner_block) %>
  </div>
  """
end
```

### 4. Conditional Rendering
Add conditional features based on attributes:

```elixir
def smart_input(assigns) do
  ~H"""
  <div class={size_class(@size)}>
    <%= if @label do %>
      <label class="label"><%= @label %></label>
    <% end %>
    
    <input class="input input-bordered w-full" {...@rest} />
    
    <%= if @helper_text do %>
      <span class="label-text-alt"><%= @helper_text %></span>
    <% end %>
  </div>
  """
end
```

### 5. Event Handling
Support Phoenix events in widgets:

```elixir
attr :on_click, :string, default: nil
attr :confirm, :string, default: nil

def action_button(assigns) do
  ~H"""
  <button
    type="button"
    class="btn btn-primary"
    phx-click={@on_click}
    data-confirm={@confirm}
  >
    <%= render_slot(@inner_block) %>
  </button>
  """
end
```

---

## Widget Examples

### Example 1: Custom Search Widget
```elixir
@doc """
Search input with integrated search button
"""
attr :field, Phoenix.HTML.FormField, required: true
attr :placeholder, :string, default: "Search..."
attr :size, :string, default: "6x1"
attr :on_search, :string, required: true

def search_box(assigns) do
  ~H"""
  <div class={size_class(@size)}>
    <div class="join w-full">
      <input
        id={@field.id}
        name={@field.name}
        value={@field.value}
        type="search"
        placeholder={@placeholder}
        class="input input-bordered join-item flex-1"
        phx-change={@on_search}
        phx-debounce="300"
      />
      <button class="btn join-item" phx-click={@on_search}>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
        </svg>
      </button>
    </div>
  </div>
  """
end
```

### Example 2: Data Card Widget
```elixir
@doc """
Card displaying key-value data pairs
"""
attr :title, :string, required: true
attr :data, :list, required: true  # List of {label, value} tuples
attr :size, :string, default: "6x2"
attr :variant, :string, default: "default"

def data_card(assigns) do
  ~H"""
  <div class={"card bg-base-100 shadow-xl #{size_class(@size)}"}>
    <div class="card-body">
      <h2 class="card-title"><%= @title %></h2>
      <dl class="space-y-2">
        <%= for {label, value} <- @data do %>
          <div class="flex justify-between">
            <dt class="font-semibold"><%= label %>:</dt>
            <dd class="text-right"><%= value %></dd>
          </div>
        <% end %>
      </dl>
    </div>
  </div>
  """
end
```

### Example 3: Status Indicator Widget
```elixir
@doc """
Status indicator with icon and label
"""
attr :status, :string, required: true, values: ["online", "offline", "busy", "away"]
attr :label, :string, default: nil
attr :size, :string, default: "2x1"

def status_indicator(assigns) do
  {color, icon} = case assigns.status do
    "online" -> {"bg-green-500", "●"}
    "offline" -> {"bg-gray-500", "○"}
    "busy" -> {"bg-red-500", "●"}
    "away" -> {"bg-yellow-500", "◐"}
  end
  
  assigns = assign(assigns, color: color, icon: icon)
  
  ~H"""
  <div class={"flex items-center gap-2 #{size_class(@size)}"}>
    <span class={"inline-block w-3 h-3 rounded-full #{@color} animate-pulse"}>
    </span>
    <%= if @label do %>
      <span class="text-sm"><%= @label %></span>
    <% else %>
      <span class="text-sm capitalize"><%= @status %></span>
    <% end %>
  </div>
  """
end
```

---

## Conclusion

This guide provides everything needed to create new widgets in the Superdupernova Lego-Brick UI System. Key points to remember:

1. **Always follow the established patterns** - Consistency is crucial
2. **Test thoroughly** - Use both manual and automated testing
3. **Document your widgets** - Include @doc strings and examples
4. **Consider reusability** - Design widgets to be flexible and composable
5. **Handle errors gracefully** - Especially for form widgets
6. **Use DaisyUI classes** - Leverage the existing design system
7. **Respect the grid** - Ensure widgets fit properly in the 12-column layout

When converting components from other systems:
- Analyze the component's structure and behavior
- Map to appropriate DaisyUI classes
- Ensure Phoenix LiveView compatibility
- Add proper grid sizing support
- Test with real data and edge cases

With this guide, developers and AI agents can successfully create new widgets that integrate seamlessly with the existing system while maintaining consistency and quality.