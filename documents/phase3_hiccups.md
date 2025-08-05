# Phase 3 Hiccups Documentation

## Sub-section 3.1.1: Basic Button Widget

### Hiccup: Button Name Conflict
- **Issue**: Function name conflict with CoreComponents `button/1` function
- **Error**: `function button/1 imported from both SuperdupernovaWeb.Widgets.Action and SuperdupernovaWeb.CoreComponents, call is ambiguous`
- **Solution**: Renamed widget function from `button` to `widget_button` to avoid conflict
- **Impact**: All button components in Phase 3 must use `<.widget_button>` instead of `<.button>`

### Hiccup: Unused Import Warning
- **Issue**: Import of Phoenix.LiveView.JS was unused
- **Solution**: Removed the import since it wasn't needed for the basic button widget
- **Note**: Will need to re-add when implementing interactive widgets that use JS commands

## Sub-section 3.2.2: Alert and Badge Widgets

### Hiccup: Missing raw/1 Function
- **Issue**: Undefined function `raw/1` when trying to render SVG path strings
- **Error**: `undefined function raw/1 (expected SuperdupernovaWeb.Widgets.Display to define such a function or for it to be imported, but none are available)`
- **Solution**: Added `import Phoenix.HTML` to the Display module
- **Impact**: Must import Phoenix.HTML whenever using `raw/1` for rendering HTML/SVG strings

## Sub-section 3.2.3: Table Widget

### Hiccup: Table Name Conflict
- **Issue**: Function name conflict with CoreComponents `table/1` function
- **Error**: `function table/1 imported from both SuperdupernovaWeb.Widgets.Display and SuperdupernovaWeb.CoreComponents, call is ambiguous`
- **Solution**: Renamed widget function from `table` to `widget_table` to avoid conflict
- **Impact**: Must use `<.widget_table>` instead of `<.table>` for the table widget

## Sub-section 3.3.1: Modal Widget

### Hiccup: JS Struct Reference Error
- **Issue**: Compile error when using `def show_modal(js \\ %JS{}, id)` with imported JS module
- **Error**: `JS.__struct__/1 is undefined, cannot expand struct JS`
- **Solution**: Changed from `import Phoenix.LiveView.JS` to `alias Phoenix.LiveView.JS`
- **Impact**: When referencing structs in default parameter values, must use alias instead of import

---