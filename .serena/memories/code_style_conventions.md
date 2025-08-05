# Code Style and Conventions

## Elixir Style
- **Formatting**: Use `mix format` with Phoenix.LiveView.HTMLFormatter
- **Naming**: snake_case for functions, PascalCase for modules
- **File Organization**: One module per file, matching directory structure
- **Documentation**: Use @doc and @moduledoc for all public functions and modules

## Phoenix LiveView Conventions
- **Components**: Use Phoenix.Component with attr/slot declarations
- **Templates**: HEEx templates with proper attribute binding
- **Event Handlers**: Prefix with "handle_event"
- **Mount Functions**: Use pattern matching for params

## Ash Framework Patterns
- **Resource Definition**: Use Ash.Resource DSL
- **Actions**: Define create, read, update, delete actions explicitly
- **Validations**: Use Ash validations over Ecto changesets
- **Relationships**: Define belongs_to, has_many using Ash syntax

## CSS/Styling Guidelines
- **Atomic Units**: Base all spacing on 4pt (0.25rem) units
- **Grid System**: Use 12-column grid with predictable widget sizes
- **DaisyUI**: Prefer DaisyUI component classes over custom CSS
- **Responsive**: Desktop-first design approach
- **Naming**: Widget sizes in "COLxROW" format (e.g., "4x1", "12x6")

## Widget Implementation Standards
- **Module Structure**: `MyAppWeb.Widgets.{WidgetName}`
- **Component Functions**: snake_case naming
- **Attributes**: Use attr with proper validation
- **Slots**: Define slots for flexible content
- **Grid Integration**: All widgets must support size variants
- **Form Integration**: Form widgets must use Phoenix.HTML.FormField

## File Organization
- **Widgets**: `lib/superdupernova_web/widgets/`
- **Core Components**: `lib/superdupernova_web/components/`
- **Business Logic**: `lib/superdupernova/`
- **Tests**: Mirror lib structure in `test/`

## Testing Patterns
- **Unit Tests**: Test each widget in isolation
- **Integration Tests**: Test with Ash forms and LiveView
- **Visual Tests**: Use Puppeteer for UI regression testing
- **Property Tests**: Use ExCheck for edge cases