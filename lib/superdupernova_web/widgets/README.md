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
          <.widget_button variant="primary" grid_size="2x1">Save</.widget_button>
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
- `widget_table` - Data tables (renamed to avoid conflict)
- `progress` - Progress bars
- `stat` - Metric display
- `loading` - Loading spinner
- `skeleton` - Loading placeholder
- `steps` - Progress steps indicator

### Action Widgets
- `widget_button` - Action button (renamed to avoid conflict)
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

## Grid Sizes

All widgets support standardized grid sizes:
- `1x1` - 1 column (minimal)
- `2x1` - 2 columns (compact)
- `4x1` - 4 columns (standard)
- `6x1` - 6 columns (half-width)
- `12x1` - 12 columns (full-width)
- `12x2` - Full width, 2 rows
- `12x4` - Full width, 4 rows

## Usage Examples

### Basic Form

```elixir
<.form for={@form} phx-submit="save">
  <.lego_grid>
    <.text_input field={@form[:name]} label="Name" size="6x1" required />
    <.email_input field={@form[:email]} label="Email" size="6x1" required />
    <.select_input 
      field={@form[:country]} 
      label="Country" 
      size="6x1"
      options={[{"United States", "us"}, {"Canada", "ca"}]}
    />
    <.widget_button type="submit" variant="primary" grid_size="2x1">
      Submit
    </.widget_button>
  </.lego_grid>
</.form>
```

### Card with Actions

```elixir
<.card title="Product" size="4x4">
  <p>Product description goes here</p>
  <:actions>
    <.widget_button variant="primary" size="sm">Buy Now</.widget_button>
    <.widget_button variant="ghost" size="sm">Details</.widget_button>
  </:actions>
</.card>
```

### Modal Dialog

```elixir
<.widget_button phx-click={show_modal("my-modal")}>
  Open Modal
</.widget_button>

<.modal id="my-modal" title="Confirm Action">
  <p>Are you sure you want to proceed?</p>
  <:actions>
    <.widget_button variant="ghost" phx-click={hide_modal("my-modal")}>
      Cancel
    </.widget_button>
    <.widget_button variant="primary" phx-click="confirm">
      Confirm
    </.widget_button>
  </:actions>
</.modal>
```

### Tabbed Interface

```elixir
<.tabs active_tab={@active_tab} tabs={[
  {:general, "General"},
  {:advanced, "Advanced"},
  {:security, "Security"}
]}>
  <.tab_panel tab={:general} active_tab={@active_tab}>
    General settings content
  </.tab_panel>
  <.tab_panel tab={:advanced} active_tab={@active_tab}>
    Advanced settings content
  </.tab_panel>
  <.tab_panel tab={:security} active_tab={@active_tab}>
    Security settings content
  </.tab_panel>
</.tabs>
```

## Component Attributes

### Common Attributes
- `size` - Grid size (e.g., "4x1", "6x1")
- `class` - Additional CSS classes
- `variant` - Style variant (primary, secondary, etc.)

### Form Input Attributes
- `field` - Phoenix form field
- `label` - Input label text
- `required` - Required field marker
- `placeholder` - Placeholder text
- `disabled` - Disable input

### Button Attributes
- `type` - Button type (button, submit, reset)
- `loading` - Show loading spinner
- `disabled` - Disable button
- `outline` - Outline style
- `size` - Button size (xs, sm, md, lg)
- `wide` - Wide button
- `block` - Full-width button

## Notes

1. Some components were renamed to avoid conflicts with Phoenix CoreComponents:
   - `button` → `widget_button`
   - `table` → `widget_table`

2. The widget system uses DaisyUI for styling, so all DaisyUI classes are available.

3. All widgets follow a consistent grid-based layout system for predictable positioning.

4. Form inputs automatically integrate with Phoenix forms and changesets.

5. Interactive components like modals and dropdowns use Phoenix.LiveView.JS for client-side interactions.