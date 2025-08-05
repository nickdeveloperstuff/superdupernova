# Step-by-Step Implementation Guide for Lego-Brick UI System

## Overview
This guide provides a detailed, step-by-step implementation plan for the Superdupernova Lego-Brick UI System. Each section includes specific tasks, testing requirements, and checkboxes for tracking progress.

## Pre-Implementation Checklist

- [ ] Phoenix LiveView application is running
- [ ] Tailwind CSS is installed and configured
- [ ] DaisyUI is installed (`npm install daisyui`)
- [ ] Ash Framework is installed and configured
- [ ] Puppeteer MCP is available for testing
- [ ] Basic LiveView router is set up

---

# PHASE 1: Foundation & Core Layout

## Section 1.1: Grid System Foundation

### Sub-section 1.1.1: Tailwind Configuration
**Task**: Set up the base Tailwind configuration with 4pt atomic units

1. Open `assets/tailwind.config.js`
2. Add the following configuration:

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
      },
      gridTemplateColumns: {
        'lego': 'repeat(12, minmax(0, 1fr))',
      },
      gap: {
        'lego': '1rem', // Standard 16pt gutter
      }
    }
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark"],
  },
}
```

**Testing Requirements:**
```bash
# Run compilation check
mix compile

# Start server
mix phx.server
```

**Puppeteer MCP Test:**
```javascript
// Navigate to http://localhost:4000
// Take screenshot to verify server is running
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000")
mcp__puppeteer__puppeteer_screenshot(name: "phase1_server_running")
```

**Documentation of Hiccups:**
_Record any compilation errors or configuration issues here_

- [ ] Tailwind configuration added
- [ ] mix compile passes
- [ ] Server starts successfully
- [ ] Screenshot captured

### Sub-section 1.1.2: Base CSS Classes
**Task**: Create the core CSS classes in app.css

1. Open `assets/css/app.css`
2. Add the following after Tailwind imports:

```css
/* Lego Grid System */
/* Note: Full-width design with thin padding for maximum screen usage */
/* Desktop-first means no mobile breakpoints, not width constraints */
:root {
  --lego-unit: 0.25rem;
  --lego-gutter: 1rem;
  --lego-columns: 12;
}

.lego-container {
  @apply w-full px-2 py-2;
}

.lego-grid {
  @apply grid grid-cols-12 gap-4;
  grid-auto-rows: minmax(100px, auto);
}

.lego-page {
  @apply overflow-x-hidden overflow-y-auto;
  min-height: 100vh;
}

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

**Testing Requirements:**
```bash
# Rebuild assets
mix assets.build

# Check for CSS compilation errors
mix compile
```

**Documentation of Hiccups:**
_Record any CSS compilation issues_

- [ ] CSS classes added
- [ ] Assets build successfully
- [ ] No CSS errors in browser console

### Sub-section 1.1.3: Test Layout Page
**Task**: Create a test page to verify grid system

1. Create `lib/superdupernova_web/live/test_layout_live.ex`:

```elixir
defmodule SuperdupernovaWeb.TestLayoutLive do
  use SuperdupernovaWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <div class="lego-container">
        <h1 class="text-2xl font-bold mb-unit-4">Grid System Test</h1>
        
        <div class="lego-grid">
          <div class="widget-1x1 bg-blue-200 p-unit-2 text-center">1x1</div>
          <div class="widget-2x1 bg-green-200 p-unit-2 text-center">2x1</div>
          <div class="widget-4x1 bg-yellow-200 p-unit-2 text-center">4x1</div>
          <div class="widget-6x1 bg-purple-200 p-unit-2 text-center">6x1</div>
          <div class="widget-12x1 bg-red-200 p-unit-2 text-center">12x1</div>
          <div class="widget-12x2 bg-indigo-200 p-unit-2 text-center">12x2</div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
```

2. Add route in `lib/superdupernova_web/router.ex`:

```elixir
live "/test-layout", TestLayoutLive
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Navigate to test layout page
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/test-layout")
// Take screenshot of grid system
mcp__puppeteer__puppeteer_screenshot(name: "phase1_grid_system", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any layout issues or unexpected behavior_

- [ ] Test page created
- [ ] Route added
- [ ] Grid displays correctly
- [ ] No horizontal scroll
- [ ] Screenshot captured

## Section 1.2: Core Widget Module Structure

### Sub-section 1.2.1: Widget Module Setup
**Task**: Create the base widget module structure

1. Create directory: `lib/superdupernova_web/widgets/`
2. Create `lib/superdupernova_web/widgets.ex`:

```elixir
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
```

3. Create base modules for each widget category:

`lib/superdupernova_web/widgets/layout.ex`:
```elixir
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
```

**Testing Requirements:**
```bash
mix compile
```

**Documentation of Hiccups:**
_Record any module compilation errors_

- [ ] Widget directory created
- [ ] Base modules compile
- [ ] No warnings

### Sub-section 1.2.2: Update Test Page with Widgets
**Task**: Refactor test page to use widget modules

1. Update `lib/superdupernova_web/live/test_layout_live.ex`:

```elixir
defmodule SuperdupernovaWeb.TestLayoutLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Widget System Test</h1>
        
        <.lego_grid>
          <div class="widget-4x1 bg-blue-200 p-unit-2">
            Container and Grid Test
          </div>
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

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Refresh and verify widgets work
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/test-layout")
mcp__puppeteer__puppeteer_screenshot(name: "phase1_widgets_test", width: 1280, height: 600)
```

**Documentation of Hiccups:**
_Record any widget usage issues_

- [ ] Widgets imported successfully
- [ ] Page renders with widgets
- [ ] Screenshot captured

---

# PHASE 2: Form Input Widgets

## Section 2.1: Basic Text Inputs

### Sub-section 2.1.1: Text Input Widget
**Task**: Create the base text input widget with Ash integration

1. Create `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
        <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
          <%= msg %>
        </.error>
      </fieldset>
    </div>
    """
  end

  defp size_class("2x1"), do: "widget-2x1"
  defp size_class("4x1"), do: "widget-4x1"
  defp size_class("6x1"), do: "widget-6x1"
  defp size_class("12x1"), do: "widget-12x1"
  defp size_class(_), do: "widget-4x1"
  
  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
```

2. Create test LiveView with form at `lib/superdupernova_web/live/form_test_live.ex`:

```elixir
defmodule SuperdupernovaWeb.FormTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  defmodule TestForm do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :name, :string
      field :email, :string
    end

    def changeset(form, attrs \\ %{}) do
      form
      |> cast(attrs, [:name, :email])
      |> validate_required([:name, :email])
      |> validate_format(:email, ~r/@/)
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Form Input Test</h1>
        
        <.form for={@form} phx-change="validate" phx-submit="save">
          <.lego_grid>
            <.text_input field={@form[:name]} label="Name" size="6x1" />
            <.text_input field={@form[:email]} label="Email" type="email" size="6x1" />
          </.lego_grid>
        </.form>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = TestForm.changeset(%TestForm{}) |> to_form()
    {:ok, assign(socket, form: form)}
  end

  @impl true
  def handle_event("validate", %{"test_form" => params}, socket) do
    form = 
      %TestForm{}
      |> TestForm.changeset(params)
      |> Map.put(:action, :validate)
      |> to_form()
    
    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"test_form" => params}, socket) do
    case TestForm.changeset(%TestForm{}, params) |> Ecto.Changeset.apply_action(:insert) do
      {:ok, _data} ->
        {:noreply, put_flash(socket, :info, "Form saved successfully!")}
      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
```

3. Add route:
```elixir
live "/form-test", FormTestLive
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Navigate to form test
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
// Test empty form validation
mcp__puppeteer__puppeteer_click(selector: "input[name='test_form[name]']")
mcp__puppeteer__puppeteer_click(selector: "input[name='test_form[email]']")
// Screenshot validation errors
mcp__puppeteer__puppeteer_screenshot(name: "phase2_validation_errors", width: 1280, height: 600)
// Fill in valid data
mcp__puppeteer__puppeteer_fill(selector: "input[name='test_form[name]']", value: "Test User")
mcp__puppeteer__puppeteer_fill(selector: "input[name='test_form[email]']", value: "test@example.com")
// Screenshot valid state
mcp__puppeteer__puppeteer_screenshot(name: "phase2_valid_form", width: 1280, height: 600)
```

**Documentation of Hiccups:**
_Record any form validation or display issues_

- [ ] Text input widget created
- [ ] Form validation works
- [ ] Error messages display
- [ ] Grid sizing works correctly
- [ ] Screenshots captured

### Sub-section 2.1.2: Email, Password, and Number Inputs
**Task**: Create specialized input variants

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end
```

2. Update test form to include new inputs:

```elixir
# In FormTestLive, update the schema:
embedded_schema do
  field :name, :string
  field :email, :string
  field :password, :string
  field :age, :integer
end

# Update changeset:
def changeset(form, attrs \\ %{}) do
  form
  |> cast(attrs, [:name, :email, :password, :age])
  |> validate_required([:name, :email, :password])
  |> validate_format(:email, ~r/@/)
  |> validate_length(:password, min: 8)
  |> validate_number(:age, greater_than: 0, less_than: 150)
end

# Update render:
<.lego_grid>
  <.text_input field={@form[:name]} label="Name" size="6x1" />
  <.email_input field={@form[:email]} label="Email" size="6x1" />
  <.password_input field={@form[:password]} label="Password" size="6x1" />
  <.number_input field={@form[:age]} label="Age" size="2x1" min={1} max={150} />
</.lego_grid>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Refresh page
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
// Test password field
mcp__puppeteer__puppeteer_fill(selector: "input[name='test_form[password]']", value: "short")
mcp__puppeteer__puppeteer_click(selector: "input[name='test_form[age]']")
// Test number field
mcp__puppeteer__puppeteer_fill(selector: "input[name='test_form[age]']", value: "200")
// Screenshot specialized inputs
mcp__puppeteer__puppeteer_screenshot(name: "phase2_specialized_inputs", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any issues with specialized inputs_

- [ ] Email input works with validation
- [ ] Password input hides text
- [ ] Number input accepts only numbers
- [ ] Validation messages appear correctly
- [ ] Screenshot captured

## Section 2.2: Textarea and Select Widgets

### Sub-section 2.2.1: Textarea Widget
**Task**: Create textarea widget with multiple size options

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end

# Update size_class to handle textarea sizes
defp size_class("6x2"), do: "widget-6x1"
defp size_class("12x2"), do: "widget-12x1"
defp size_class("12x4"), do: "widget-12x1"
# ... existing size classes
```

2. Update test form to include textarea:

```elixir
# Add to schema:
field :bio, :string

# Update changeset:
|> cast(attrs, [:name, :email, :password, :age, :bio])
|> validate_length(:bio, max: 500)

# Add to render:
<.textarea field={@form[:bio]} label="Bio" size="12x2" 
  placeholder="Tell us about yourself..." />
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test textarea
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_fill(selector: "textarea[name='test_form[bio]']", 
  value: "This is a test bio that spans multiple lines.\nIt should display properly in the textarea widget.")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_textarea", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any textarea display issues_

- [ ] Textarea widget created
- [ ] Multi-line text works
- [ ] Size variants display correctly
- [ ] Screenshot captured

### Sub-section 2.2.2: Select Input Widget
**Task**: Create select dropdown widget

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end
```

2. Update test form:

```elixir
# Add to schema:
field :country, :string

# Add validation:
|> validate_inclusion(:country, ["us", "ca", "uk", "au"])

# Add to render:
<.select_input 
  field={@form[:country]} 
  label="Country" 
  size="4x1"
  options={[
    {"United States", "us"},
    {"Canada", "ca"},
    {"United Kingdom", "uk"},
    {"Australia", "au"}
  ]} 
/>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test select dropdown
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_click(selector: "select[name='test_form[country]']")
mcp__puppeteer__puppeteer_select(selector: "select[name='test_form[country]']", value: "ca")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_select", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any select widget issues_

- [ ] Select widget created
- [ ] Options display correctly
- [ ] Selection works
- [ ] Screenshot captured

## Section 2.3: Boolean and Choice Widgets

### Sub-section 2.3.1: Checkbox and Toggle Widgets
**Task**: Create checkbox and toggle switch widgets

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
    <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
      <%= msg %>
    </.error>
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
    <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
      <%= msg %>
    </.error>
  </div>
  """
end
```

2. Update test form:

```elixir
# Add to schema:
field :agree_terms, :boolean, default: false
field :notifications, :boolean, default: false

# Add to render:
<.checkbox field={@form[:agree_terms]} label="I agree to terms" size="6x1" />
<.toggle field={@form[:notifications]} label="Email notifications" size="6x1" />
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test checkbox and toggle
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_click(selector: "input[name='test_form[agree_terms]']")
mcp__puppeteer__puppeteer_click(selector: "input[name='test_form[notifications]']")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_boolean_widgets", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any checkbox/toggle issues_

- [ ] Checkbox widget works
- [ ] Toggle widget works
- [ ] States persist correctly
- [ ] Screenshot captured

### Sub-section 2.3.2: Radio Group Widget
**Task**: Create radio button group widget

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end
```

2. Update test form:

```elixir
# Add to schema:
field :plan, :string

# Add validation:
|> validate_inclusion(:plan, ["basic", "pro", "enterprise"])

# Add to render:
<.radio_group 
  field={@form[:plan]} 
  label="Select Plan" 
  size="4x2"
  options={[
    {"Basic - $9/mo", "basic"},
    {"Pro - $29/mo", "pro"},
    {"Enterprise - $99/mo", "enterprise"}
  ]} 
/>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test radio group
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_click(selector: "input[type='radio'][value='pro']")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_radio_group", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any radio group issues_

- [ ] Radio group widget created
- [ ] Selection works correctly
- [ ] Only one option selectable
- [ ] Screenshot captured

## Section 2.4: Advanced Input Widgets

### Sub-section 2.4.1: File Input Widget
**Task**: Create file upload widget

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test file input display
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_file_input", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any file input styling issues_

- [ ] File input widget created
- [ ] DaisyUI styling applied
- [ ] Screenshot captured

### Sub-section 2.4.2: Date and Time Inputs
**Task**: Create date, time, and datetime input widgets

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
```

2. Update test form:

```elixir
# Add to schema:
field :birth_date, :date
field :appointment_time, :time
field :event_datetime, :naive_datetime

# Add to render:
<.date_input field={@form[:birth_date]} label="Birth Date" size="4x1" />
<.time_input field={@form[:appointment_time]} label="Appointment Time" size="4x1" />
<.datetime_input field={@form[:event_datetime]} label="Event Date & Time" size="6x1" />
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test date/time inputs
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_fill(selector: "input[type='date']", value: "2024-03-15")
mcp__puppeteer__puppeteer_fill(selector: "input[type='time']", value: "14:30")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_datetime_inputs", width: 1280, height: 1000)
```

**Documentation of Hiccups:**
_Record any date/time input issues_

- [ ] Date input works
- [ ] Time input works
- [ ] DateTime input works
- [ ] Screenshot captured

### Sub-section 2.4.3: Range Slider Widget
**Task**: Create range slider input widget

1. Add to `lib/superdupernova_web/widgets/form.ex`:

```elixir
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
      <.error :for={msg <- Enum.map(@field.errors, &translate_error(&1))}>
        <%= msg %>
      </.error>
    </fieldset>
  </div>
  """
end
```

2. Update test form:

```elixir
# Add to schema:
field :volume, :integer, default: 50

# Add to render:
<.range_slider field={@form[:volume]} label="Volume" size="6x1" min={0} max={100} />
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test range slider
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/form-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase2_range_slider", width: 1280, height: 1000)
```

**Documentation of Hiccups:**
_Record any range slider issues_

- [ ] Range slider displays
- [ ] Min/max values show
- [ ] Current value displays
- [ ] Screenshot captured

---

# PHASE 3: Action & Display Widgets

## Section 3.1: Button Widgets

### Sub-section 3.1.1: Basic Button Widget
**Task**: Create button widget with all variants

1. Create `lib/superdupernova_web/widgets/action.ex`:

```elixir
defmodule SuperdupernovaWeb.Widgets.Action do
  use Phoenix.Component
  import Phoenix.LiveView.JS

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

  def button(assigns) do
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
    block_class = if block, do: "btn-block", else: "w-full"
    
    "#{base} #{variant_class} #{size_class} #{wide_class} #{block_class}"
    |> String.trim()
  end

  defp grid_size_class("1x1"), do: "widget-1x1"
  defp grid_size_class("2x1"), do: "widget-2x1"
  defp grid_size_class("4x1"), do: "widget-4x1"
  defp grid_size_class("6x1"), do: "widget-6x1"
  defp grid_size_class("12x1"), do: "widget-12x1"
  defp grid_size_class(_), do: "widget-2x1"
end
```

2. Create button test page at `lib/superdupernova_web/live/button_test_live.ex`:

```elixir
defmodule SuperdupernovaWeb.ButtonTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Button Widget Test</h1>
        
        <h2 class="text-xl font-semibold mb-unit-2">Variants</h2>
        <.lego_grid>
          <.button variant="primary" grid_size="2x1">Primary</.button>
          <.button variant="secondary" grid_size="2x1">Secondary</.button>
          <.button variant="accent" grid_size="2x1">Accent</.button>
          <.button variant="neutral" grid_size="2x1">Neutral</.button>
          <.button variant="ghost" grid_size="2x1">Ghost</.button>
          <.button variant="link" grid_size="2x1">Link</.button>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Sizes</h2>
        <.lego_grid>
          <.button size="xs" grid_size="2x1">Extra Small</.button>
          <.button size="sm" grid_size="2x1">Small</.button>
          <.button size="md" grid_size="2x1">Medium</.button>
          <.button size="lg" grid_size="2x1">Large</.button>
          <.button size="xl" grid_size="2x1">Extra Large</.button>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">States</h2>
        <.lego_grid>
          <.button loading={true} grid_size="2x1">Loading</.button>
          <.button disabled={true} grid_size="2x1">Disabled</.button>
          <.button outline={true} grid_size="2x1">Outline</.button>
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

3. Add route:
```elixir
live "/button-test", ButtonTestLive
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test button variants
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/button-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_buttons", width: 1280, height: 1200)
```

**Documentation of Hiccups:**
_Record any button styling issues_

- [ ] Button widget created
- [ ] All variants display correctly
- [ ] All sizes work
- [ ] Loading state shows spinner
- [ ] Screenshot captured

### Sub-section 3.1.2: Icon Button and Button Group
**Task**: Create icon button and button group widgets

1. Add to `lib/superdupernova_web/widgets/action.ex`:

```elixir
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

defp icon_button_classes(variant, size, shape) do
  base = "btn"
  variant_class = "btn-#{variant}"
  size_class = "btn-#{size}"
  shape_class = "btn-#{shape}"
  
  "#{base} #{variant_class} #{size_class} #{shape_class}"
end

@doc """
Button group widget
"""
attr :size, :string, default: "4x1"

slot :inner_block, required: true

def button_group(assigns) do
  ~H"""
  <div class={grid_size_class(@size)}>
    <div class="join w-full">
      <%= render_slot(@inner_block) %>
    </div>
  </div>
  """
end

@doc """
Group button - for use inside button_group
"""
attr :variant, :string, default: "neutral"
attr :active, :boolean, default: false
attr :rest, :global

slot :inner_block, required: true

def group_button(assigns) do
  active_class = if assigns.active, do: "btn-active", else: ""
  
  ~H"""
  <button
    type="button"
    class={"btn join-item btn-#{@variant} #{active_class}"}
    {@rest}
  >
    <%= render_slot(@inner_block) %>
  </button>
  """
end
```

2. Update button test page:

```elixir
# Add to render:
<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Icon Buttons</h2>
<.lego_grid>
  <.icon_button variant="primary">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
      <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
    </svg>
  </.icon_button>
  <.icon_button shape="circle" variant="secondary">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
    </svg>
  </.icon_button>
</.lego_grid>

<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Button Groups</h2>
<.lego_grid>
  <.button_group size="6x1">
    <.group_button active={true}>Option 1</.group_button>
    <.group_button>Option 2</.group_button>
    <.group_button>Option 3</.group_button>
  </.button_group>
</.lego_grid>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test icon buttons and groups
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/button-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_icon_buttons_groups", width: 1280, height: 1400)
```

**Documentation of Hiccups:**
_Record any icon button or group issues_

- [ ] Icon buttons display correctly
- [ ] Button groups join properly
- [ ] Active state shows
- [ ] Screenshot captured

## Section 3.2: Display Widgets

### Sub-section 3.2.1: Card Widget
**Task**: Create card display widget with variants

1. Create `lib/superdupernova_web/widgets/display.ex`:

```elixir
defmodule SuperdupernovaWeb.Widgets.Display do
  use Phoenix.Component

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
    border = if bordered, do: "card-border", else: ""
    size = if compact, do: "card-compact", else: ""
    
    "#{base} #{border} #{size}" |> String.trim()
  end

  defp grid_size_class("4x4"), do: "widget-4x1"
  defp grid_size_class("6x4"), do: "widget-6x1"
  defp grid_size_class("12x4"), do: "widget-12x1"
  defp grid_size_class("12x6"), do: "widget-12x1"
  defp grid_size_class(_), do: "widget-6x1"
end
```

2. Create display test page at `lib/superdupernova_web/live/display_test_live.ex`:

```elixir
defmodule SuperdupernovaWeb.DisplayTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Display Widget Test</h1>
        
        <.lego_grid>
          <.card title="Basic Card" size="6x4">
            This is a basic card with some content.
            It demonstrates the standard card layout.
          </.card>
          
          <.card title="Card with Actions" size="6x4">
            This card has action buttons.
            <:actions>
              <.button variant="primary" size="sm" grid_size="2x1">Save</.button>
              <.button variant="ghost" size="sm" grid_size="2x1">Cancel</.button>
            </:actions>
          </.card>
          
          <.card title="Full Width Card" size="12x4" bordered={false}>
            This is a full-width card without borders.
            It spans the entire grid width.
          </.card>
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

3. Add route:
```elixir
live "/display-test", DisplayTestLive
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test card displays
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_cards", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any card display issues_

- [ ] Card widget created
- [ ] Multiple sizes work
- [ ] Actions slot renders
- [ ] Screenshot captured

### Sub-section 3.2.2: Alert and Badge Widgets
**Task**: Create alert and badge display widgets

1. Add to `lib/superdupernova_web/widgets/display.ex`:

```elixir
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
        <%= alert_icon(@type) %>
      </svg>
      <div>
        <%= if @title do %>
          <h3 class="font-bold"><%= @title %></h3>
        <% end %>
        <div class="text-sm"><%= render_slot(@inner_block) %></div>
      </div>
      <%= if @dismissible do %>
        <button class="btn btn-sm btn-ghost" phx-click={JS.hide(to: ".alert")}>✕</button>
      <% end %>
    </div>
  </div>
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

@doc """
Badge widget for labels and tags
"""
attr :variant, :string, default: "neutral",
  values: ["neutral", "primary", "secondary", "accent", "ghost", "info", "success", "warning", "error"]
attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg"]
attr :outline, :boolean, default: false

slot :inner_block, required: true

def badge(assigns) do
  outline_class = if assigns.outline, do: "badge-outline", else: ""
  
  ~H"""
  <span class={"badge badge-#{@variant} badge-#{@size} #{outline_class}"}>
    <%= render_slot(@inner_block) %>
  </span>
  """
end
```

2. Update display test page:

```elixir
# Add to render:
<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Alerts</h2>
<.lego_grid>
  <.alert type="info" title="Information">
    This is an informational alert message.
  </.alert>
  <.alert type="success">
    Operation completed successfully!
  </.alert>
  <.alert type="warning" dismissible={true}>
    Warning: Please review before proceeding.
  </.alert>
  <.alert type="error" title="Error" dismissible={true}>
    Something went wrong. Please try again.
  </.alert>
</.lego_grid>

<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Badges</h2>
<.lego_grid>
  <div class="widget-12x1 space-x-2">
    <.badge>Default</.badge>
    <.badge variant="primary">Primary</.badge>
    <.badge variant="secondary" size="lg">Secondary Large</.badge>
    <.badge variant="success" outline={true}>Success Outline</.badge>
    <.badge variant="error" size="xs">Error XS</.badge>
  </div>
</.lego_grid>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test alerts and badges
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_alerts_badges", width: 1280, height: 1200)
// Test dismissible alert
mcp__puppeteer__puppeteer_click(selector: ".alert-warning button")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_alert_dismissed", width: 1280, height: 1200)
```

**Documentation of Hiccups:**
_Record any alert or badge issues_

- [ ] Alert widget displays correctly
- [ ] Badge variants work
- [ ] Dismissible alerts can be closed
- [ ] Screenshots captured

### Sub-section 3.2.3: Table Widget
**Task**: Create table widget for data display

1. Add to `lib/superdupernova_web/widgets/display.ex`:

```elixir
@doc """
Table widget for tabular data
"""
attr :data, :list, required: true
attr :columns, :list, required: true
attr :striped, :boolean, default: true
attr :hover, :boolean, default: true
attr :compact, :boolean, default: false

def table(assigns) do
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
          <%= for {label, _key} <- @columns do %>
            <th><%= label %></th>
          <% end %>
        </tr>
      </thead>
      <tbody>
        <%= for row <- @data do %>
          <tr>
            <%= for {_label, key} <- @columns do %>
              <td><%= Map.get(row, key) %></td>
            <% end %>
          </tr>
        <% end %>
      </tbody>
    </table>
  </div>
  """
end
```

2. Update display test page:

```elixir
# Add to mount:
{:ok, assign(socket, 
  users: [
    %{id: 1, name: "John Doe", email: "john@example.com", status: "Active"},
    %{id: 2, name: "Jane Smith", email: "jane@example.com", status: "Active"},
    %{id: 3, name: "Bob Johnson", email: "bob@example.com", status: "Inactive"},
  ]
)}

# Add to render:
<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Table</h2>
<.lego_grid>
  <.table 
    data={@users}
    columns={[
      {"ID", :id},
      {"Name", :name},
      {"Email", :email},
      {"Status", :status}
    ]}
  />
</.lego_grid>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test table display
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_table", width: 1280, height: 1400)
```

**Documentation of Hiccups:**
_Record any table display issues_

- [ ] Table widget renders data
- [ ] Striped rows show
- [ ] Headers display correctly
- [ ] Screenshot captured

### Sub-section 3.2.4: Progress and Stat Widgets
**Task**: Create progress bar and stat display widgets

1. Add to `lib/superdupernova_web/widgets/display.ex`:

```elixir
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
# Add other size mappings as needed
```

2. Update display test page:

```elixir
# Add to render:
<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Progress Bars</h2>
<.lego_grid>
  <.progress value={25} variant="primary" size="6x1" />
  <.progress value={50} variant="secondary" size="6x1" />
  <.progress value={75} variant="accent" size="6x1" />
  <.progress value={100} variant="success" size="6x1" />
</.lego_grid>

<h2 class="text-xl font-semibold mb-unit-2 mt-unit-8">Stats</h2>
<.lego_grid>
  <.stat title="Total Users" value="1,234" desc="↗︎ 12% from last month" />
  <.stat title="Revenue" value="$45,678" desc="↗︎ 8% from last month" />
  <.stat title="Conversion" value="3.4%" desc="↘︎ 2% from last month" />
</.lego_grid>
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test progress and stats
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_progress_stats", width: 1280, height: 1600)
```

**Documentation of Hiccups:**
_Record any progress or stat widget issues_

- [ ] Progress bars show correct values
- [ ] Stat widgets display metrics
- [ ] Grid sizing works correctly
- [ ] Screenshot captured

## Section 3.3: Interactive Widgets

### Sub-section 3.3.1: Modal Widget
**Task**: Create modal dialog widget

1. Add to `lib/superdupernova_web/widgets/action.ex`:

```elixir
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
        <div class="modal-action">
          <%= if @actions != [] do %>
            <%= render_slot(@actions) %>
          <% else %>
            <button class="btn" onclick={"document.getElementById('#{@id}').close()"}>
              Close
            </button>
          <% end %>
        </div>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>
  """
end

@doc """
Helper to open a modal
"""
def open_modal(js \\ %JS{}, id) do
  JS.dispatch(js, "click", to: "##{id}")
  |> JS.dispatch("modal:open", to: "##{id}")
end
```

2. Create modal test page:

```elixir
defmodule SuperdupernovaWeb.ModalTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Modal Widget Test</h1>
        
        <.lego_grid>
          <.button variant="primary" grid_size="4x1" 
            onclick="document.getElementById('test-modal').showModal()">
            Open Modal
          </.button>
        </.lego_grid>
        
        <.modal id="test-modal" title="Confirm Action">
          Are you sure you want to proceed with this action?
          <:actions>
            <.button variant="ghost" grid_size="2x1" 
              onclick="document.getElementById('test-modal').close()">
              Cancel
            </.button>
            <.button variant="primary" grid_size="2x1">
              Confirm
            </.button>
          </:actions>
        </.modal>
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

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test modal
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/modal-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_modal_closed", width: 1280, height: 600)
mcp__puppeteer__puppeteer_click(selector: "button.btn-primary")
// Wait for modal animation
mcp__puppeteer__puppeteer_evaluate(script: "new Promise(r => setTimeout(r, 500))")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_modal_open", width: 1280, height: 600)
```

**Documentation of Hiccups:**
_Record any modal issues_

- [ ] Modal widget created
- [ ] Modal opens on click
- [ ] Backdrop works
- [ ] Screenshots captured

### Sub-section 3.3.2: Dropdown Widget
**Task**: Create dropdown menu widget

1. Add to `lib/superdupernova_web/widgets/action.ex`:

```elixir
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
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test dropdown
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/button-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_dropdown", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any dropdown issues_

- [ ] Dropdown widget created
- [ ] Menu items render
- [ ] Screenshot captured

## Section 3.4: Layout Enhancement Widgets

### Sub-section 3.4.1: Tabs Widget
**Task**: Create tabbed interface widget

1. Add to `lib/superdupernova_web/widgets/layout.ex`:

```elixir
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
```

2. Create tabs test page:

```elixir
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
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test tabs
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/tabs-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_tabs_general", width: 1280, height: 600)
mcp__puppeteer__puppeteer_click(selector: "a[phx-value-tab='profile']")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_tabs_profile", width: 1280, height: 600)
```

**Documentation of Hiccups:**
_Record any tabs issues_

- [ ] Tabs widget created
- [ ] Tab switching works
- [ ] Active state shows
- [ ] Screenshots captured

### Sub-section 3.4.2: Divider and Spacer Widgets
**Task**: Create divider and spacer layout widgets

1. Add to `lib/superdupernova_web/widgets/layout.ex`:

```elixir
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
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Add dividers to existing test page
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase3_layout_widgets", width: 1280, height: 1600)
```

**Documentation of Hiccups:**
_Record any layout widget issues_

- [ ] Divider widget works
- [ ] Spacer adds proper spacing
- [ ] Form section groups content
- [ ] Screenshot captured

---

# PHASE 4: Advanced Layout & Interactive Widgets

## Section 4.1: Complex Layout Widgets

### Sub-section 4.1.1: Accordion Widget
**Task**: Create accordion/collapsible widget

1. Add to `lib/superdupernova_web/widgets/layout.ex`:

```elixir
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
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test accordion
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/tabs-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_accordion", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any accordion issues_

- [ ] Accordion widget created
- [ ] Collapse/expand works
- [ ] Screenshot captured

### Sub-section 4.1.2: Steps/Stepper Widget
**Task**: Create steps progress indicator widget

1. Add to `lib/superdupernova_web/widgets/display.ex`:

```elixir
@doc """
Steps widget for progress indication
"""
attr :steps, :list, required: true
attr :current_step, :integer, default: 0

def steps(assigns) do
  ~H"""
  <div class="widget-12x1">
    <ul class="steps w-full">
      <%= for {step, index} <- Enum.with_index(@steps) do %>
        <li class={step_class(index, @current_step)}>
          <%= step %>
        </li>
      <% end %>
    </ul>
  </div>
  """
end

defp step_class(index, current) when index < current, do: "step step-primary"
defp step_class(index, current) when index == current, do: "step step-primary"
defp step_class(_, _), do: "step"
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test steps
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_steps", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any steps widget issues_

- [ ] Steps widget displays
- [ ] Current step highlighted
- [ ] Screenshot captured

## Section 4.2: Advanced Interactive Widgets

### Sub-section 4.2.1: Drawer Widget
**Task**: Create slide-out drawer widget

1. Add to `lib/superdupernova_web/widgets/layout.ex`:

```elixir
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
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test drawer
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/layout-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_drawer", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any drawer issues_

- [ ] Drawer widget created
- [ ] Slide animation works
- [ ] Screenshot captured

### Sub-section 4.2.2: Loading and Skeleton Widgets
**Task**: Create loading indicator and skeleton loader widgets

1. Add to `lib/superdupernova_web/widgets/display.ex`:

```elixir
@doc """
Loading spinner widget
"""
attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg"]
attr :variant, :string, default: "spinner"

def loading(assigns) do
  ~H"""
  <span class={"loading loading-#{@variant} loading-#{@size}"}></span>
  """
end

@doc """
Skeleton loader widget
"""
attr :type, :string, default: "text", values: ["text", "card", "image"]
attr :lines, :integer, default: 3

def skeleton(assigns) do
  ~H"""
  <div class="widget-12x1">
    <%= case @type do %>
      <% "text" -> %>
        <%= for _ <- 1..@lines do %>
          <div class="skeleton h-4 w-full mb-2"></div>
        <% end %>
      <% "card" -> %>
        <div class="skeleton h-32 w-full mb-4"></div>
        <div class="skeleton h-4 w-28 mb-2"></div>
        <div class="skeleton h-4 w-full mb-2"></div>
        <div class="skeleton h-4 w-full"></div>
      <% "image" -> %>
        <div class="skeleton h-48 w-full"></div>
    <% end %>
  </div>
  """
end
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test loading states
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/display-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_loading_skeleton", width: 1280, height: 800)
```

**Documentation of Hiccups:**
_Record any loading/skeleton issues_

- [ ] Loading spinner animates
- [ ] Skeleton shows placeholder
- [ ] Screenshot captured

## Section 4.3: Ash Framework Integration

### Sub-section 4.3.1: Ash Form Integration
**Task**: Create comprehensive Ash form example

1. Create Ash resource at `lib/superdupernova/accounts/user.ex`:

```elixir
defmodule Superdupernova.Accounts.User do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshPhoenix.Form]

  attributes do
    uuid_primary_key :id
    attribute :email, :string, allow_nil?: false
    attribute :name, :string, allow_nil?: false
    attribute :age, :integer
    attribute :bio, :string
    attribute :country, :string
    attribute :notifications, :boolean, default: false
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  validations do
    validate match(:email, ~r/^[^\s]+@[^\s]+$/), message: "must be a valid email"
    validate length(:name, min: 2, max: 100)
    validate numericality(:age, greater_than: 0, less_than_or_equal_to: 150)
    validate length(:bio, max: 500)
    validate one_of(:country, ["us", "ca", "uk", "au"])
  end

  actions do
    defaults [:read]
    
    create :register do
      accept [:email, :name, :age, :bio, :country, :notifications]
    end
    
    update :update do
      accept [:name, :age, :bio, :country, :notifications]
    end
  end
end
```

2. Create Ash Domain at `lib/superdupernova/accounts.ex`:

```elixir
defmodule Superdupernova.Accounts do
  use Ash.Domain, extensions: [AshPhoenix.Domain]

  resources do
    resource Superdupernova.Accounts.User
  end
end
```

3. Create Ash test LiveView:

```elixir
defmodule SuperdupernovaWeb.AshFormTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  alias Superdupernova.Accounts
  alias Superdupernova.Accounts.User

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Ash Form Integration Test</h1>
        
        <.form for={@form} phx-change="validate" phx-submit="save">
          <.form_section title="Basic Information">
            <.text_input field={@form[:name]} label="Full Name" size="6x1" />
            <.email_input field={@form[:email]} label="Email Address" size="6x1" />
            <.number_input field={@form[:age]} label="Age" size="2x1" min={1} max={150} />
            <.select_input 
              field={@form[:country]} 
              label="Country" 
              size="4x1"
              options={[
                {"United States", "us"},
                {"Canada", "ca"},
                {"United Kingdom", "uk"},
                {"Australia", "au"}
              ]} 
            />
          </.form_section>
          
          <.form_section title="Additional Information">
            <.textarea field={@form[:bio]} label="Bio" size="12x2" 
              placeholder="Tell us about yourself..." />
            <.toggle field={@form[:notifications]} 
              label="Receive email notifications" size="6x1" />
          </.form_section>
          
          <.divider />
          
          <.lego_grid>
            <.button type="submit" variant="primary" grid_size="4x1" 
              loading={@saving}>
              Register User
            </.button>
            <.button type="button" variant="ghost" grid_size="4x1"
              phx-click="reset">
              Reset Form
            </.button>
          </.lego_grid>
        </.form>
        
        <%= if @success do %>
          <.alert type="success" title="Success!" dismissible={true}>
            User registered successfully with email: <%= @success %>
          </.alert>
        <% end %>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = AshPhoenix.Form.for_create(User, :register)
    
    {:ok, 
     socket
     |> assign(form: form, saving: false, success: nil)}
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
      {:ok, user} ->
        {:noreply,
         socket
         |> assign(saving: false, success: user.email)
         |> assign(form: AshPhoenix.Form.for_create(User, :register))}

      {:error, form} ->
        {:noreply, assign(socket, form: form, saving: false)}
    end
  end

  @impl true
  def handle_event("reset", _, socket) do
    form = AshPhoenix.Form.for_create(User, :register)
    {:noreply, assign(socket, form: form, success: nil)}
  end
end
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test Ash form integration
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/ash-form-test")
// Test validation
mcp__puppeteer__puppeteer_click(selector: "button[type='submit']")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_ash_validation", width: 1280, height: 1200)
// Fill valid data
mcp__puppeteer__puppeteer_fill(selector: "input[name='form[name]']", value: "John Doe")
mcp__puppeteer__puppeteer_fill(selector: "input[name='form[email]']", value: "john@example.com")
mcp__puppeteer__puppeteer_fill(selector: "input[name='form[age]']", value: "30")
mcp__puppeteer__puppeteer_select(selector: "select[name='form[country]']", value: "us")
mcp__puppeteer__puppeteer_fill(selector: "textarea[name='form[bio]']", value: "Software developer")
mcp__puppeteer__puppeteer_click(selector: "input[name='form[notifications]']")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_ash_filled", width: 1280, height: 1200)
// Submit
mcp__puppeteer__puppeteer_click(selector: "button[type='submit']")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_ash_success", width: 1280, height: 1200)
```

**Documentation of Hiccups:**
_Record any Ash integration issues_

- [ ] Ash resource created
- [ ] Form validation works
- [ ] Success message shows
- [ ] All widgets integrate properly
- [ ] Screenshots captured

### Sub-section 4.3.2: Nested Forms with Ash
**Task**: Create nested form example with relationships

1. Create related Ash resource at `lib/superdupernova/accounts/address.ex`:

```elixir
defmodule Superdupernova.Accounts.Address do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets

  attributes do
    uuid_primary_key :id
    attribute :street, :string, allow_nil?: false
    attribute :city, :string, allow_nil?: false
    attribute :state, :string, allow_nil?: false
    attribute :zip, :string, allow_nil?: false
  end

  validations do
    validate length(:street, min: 5)
    validate length(:city, min: 2)
    validate length(:state, equals: 2)
    validate match(:zip, ~r/^\d{5}$/)
  end

  relationships do
    belongs_to :user, Superdupernova.Accounts.User
  end
end
```

2. Update User resource with relationship:

```elixir
# Add to User resource:
relationships do
  has_many :addresses, Superdupernova.Accounts.Address
end

# Update register action:
create :register do
  accept [:email, :name, :age, :bio, :country, :notifications]
  
  argument :addresses, {:array, :map}
  
  change manage_relationship(:addresses, type: :create)
end
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test nested forms
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/ash-form-test")
mcp__puppeteer__puppeteer_screenshot(name: "phase4_nested_forms", width: 1280, height: 1400)
```

**Documentation of Hiccups:**
_Record any nested form issues_

- [ ] Nested forms work
- [ ] Relationships saved
- [ ] Screenshot captured

## Section 4.4: Final Integration & Documentation

### Sub-section 4.4.1: Complete Widget Showcase
**Task**: Create comprehensive showcase page

1. Create showcase page at `lib/superdupernova_web/live/widget_showcase_live.ex`:

```elixir
defmodule SuperdupernovaWeb.WidgetShowcaseLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-3xl font-bold mb-unit-8">Lego Widget System Showcase</h1>
        
        <.tabs active_tab={@active_tab} tabs={[
          {:inputs, "Form Inputs"},
          {:display, "Display"},
          {:actions, "Actions"},
          {:layout, "Layout"}
        ]}>
          <.tab_panel tab={:inputs} active_tab={@active_tab}>
            <%= render_inputs_showcase(assigns) %>
          </.tab_panel>
          
          <.tab_panel tab={:display} active_tab={@active_tab}>
            <%= render_display_showcase(assigns) %>
          </.tab_panel>
          
          <.tab_panel tab={:actions} active_tab={@active_tab}>
            <%= render_actions_showcase(assigns) %>
          </.tab_panel>
          
          <.tab_panel tab={:layout} active_tab={@active_tab}>
            <%= render_layout_showcase(assigns) %>
          </.tab_panel>
        </.tabs>
      </.lego_container>
    </div>
    """
  end

  # Implement showcase sections...
  defp render_inputs_showcase(assigns) do
    ~H"""
    <.form_section title="Text Inputs">
      <.text_input field={@test_form[:text]} label="Text Input" size="4x1" />
      <.email_input field={@test_form[:email]} label="Email" size="4x1" />
      <.password_input field={@test_form[:password]} label="Password" size="4x1" />
    </.form_section>
    <!-- Add all other input widgets -->
    """
  end

  # Similar for other sections...
end
```

**Testing Requirements:**
```bash
mix compile
```

**Puppeteer MCP Test:**
```javascript
// Test complete showcase
mcp__puppeteer__puppeteer_navigate(url: "http://localhost:4000/widget-showcase")
// Test each tab
mcp__puppeteer__puppeteer_screenshot(name: "final_showcase_inputs", width: 1280, height: 1600)
mcp__puppeteer__puppeteer_click(selector: "a[phx-value-tab='display']")
mcp__puppeteer__puppeteer_screenshot(name: "final_showcase_display", width: 1280, height: 1600)
mcp__puppeteer__puppeteer_click(selector: "a[phx-value-tab='actions']")
mcp__puppeteer__puppeteer_screenshot(name: "final_showcase_actions", width: 1280, height: 1600)
mcp__puppeteer__puppeteer_click(selector: "a[phx-value-tab='layout']")
mcp__puppeteer__puppeteer_screenshot(name: "final_showcase_layout", width: 1280, height: 1600)
```

**Documentation of Hiccups:**
_Record any showcase issues_

- [ ] All widgets displayed
- [ ] Navigation works
- [ ] All screenshots captured
- [ ] System complete

### Sub-section 4.4.2: Widget Documentation
**Task**: Create widget usage documentation

1. Create `lib/superdupernova_web/widgets/README.md`:

```markdown
# Lego Widget System Documentation

## Quick Start

```elixir
defmodule MyAppWeb.MyLive do
  use MyAppWeb, :live_view
  use SuperdupernovaWeb.Widgets
  
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <.lego_grid>
          <.text_input field={@form[:name]} label="Name" size="6x1" />
          <.button variant="primary" grid_size="2x1">Save</.button>
        </.lego_grid>
      </.lego_container>
    </div>
    """
  end
end
```

## Widget Reference

### Form Inputs
- `text_input` - Basic text input
- `email_input` - Email with validation
- `password_input` - Password field
- `number_input` - Numeric input
- `textarea` - Multi-line text
- `select_input` - Dropdown selection
- `checkbox` - Single checkbox
- `toggle` - Toggle switch
- `radio_group` - Radio button group
- `file_input` - File upload
- `date_input` - Date picker
- `time_input` - Time picker
- `datetime_input` - Date and time
- `range_slider` - Range selection

### Display Widgets
- `card` - Content card
- `alert` - Alert messages
- `badge` - Labels and tags
- `table` - Data tables
- `progress` - Progress bars
- `stat` - Metric display
- `loading` - Loading spinner
- `skeleton` - Loading placeholder

### Action Widgets
- `button` - Action button
- `icon_button` - Icon-only button
- `button_group` - Grouped buttons
- `dropdown` - Dropdown menu
- `modal` - Modal dialog

### Layout Widgets
- `lego_container` - Page container
- `lego_grid` - 12-column grid
- `form_section` - Form grouping
- `tabs` - Tabbed interface
- `accordion` - Collapsible sections
- `divider` - Visual separator
- `spacer` - Empty space
- `drawer` - Slide-out panel
- `steps` - Progress steps

## Grid Sizes

All widgets support standardized grid sizes:
- `1x1` - 1 column (minimal)
- `2x1` - 2 columns (compact)
- `4x1` - 4 columns (standard)
- `6x1` - 6 columns (half-width)
- `12x1` - 12 columns (full-width)
- `12x2` - Full width, 2 rows
- `12x4` - Full width, 4 rows
```

**Testing Requirements:**
```bash
# Verify documentation renders correctly
cat lib/superdupernova_web/widgets/README.md
```

**Documentation of Hiccups:**
_Record any documentation issues_

- [ ] Documentation created
- [ ] All widgets documented
- [ ] Examples provided
- [ ] System fully implemented

---

## Final Checklist

### Phase 1: Foundation & Core Layout
- [ ] Grid system implemented
- [ ] Base CSS classes created
- [ ] Widget module structure set up
- [ ] All tests passed

### Phase 2: Form Input Widgets
- [ ] All 16 input widgets implemented
- [ ] Validation integration complete
- [ ] All tests passed

### Phase 3: Action & Display Widgets
- [ ] All action widgets implemented
- [ ] All display widgets implemented
- [ ] Interactive widgets working
- [ ] All tests passed

### Phase 4: Advanced Layout & Interactive Widgets
- [ ] Complex layout widgets complete
- [ ] Ash Framework fully integrated
- [ ] Documentation complete
- [ ] All tests passed

### Overall System
- [ ] All DaisyUI components utilized
- [ ] All Phoenix LiveView patterns implemented
- [ ] All Ash patterns integrated
- [ ] Visual testing complete for all widgets
- [ ] No horizontal scrolling issues
- [ ] 4pt atomic unit system working
- [ ] AI-agent friendly implementation
- [ ] Complete documentation available

## Implementation Complete! 🎉

The Lego-Brick UI System is now fully implemented with:
- 40+ widgets covering all use cases
- Complete Ash Framework integration
- Comprehensive visual testing
- Full documentation
- AI-agent friendly patterns

Every widget has been tested visually with Puppeteer MCP, ensuring the system works as designed.