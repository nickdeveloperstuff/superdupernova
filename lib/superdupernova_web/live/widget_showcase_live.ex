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

  # Implement showcase sections
  defp render_inputs_showcase(assigns) do
    ~H"""
    <.lego_grid>
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Text Inputs</h2>
      
      <.text_input field={@test_form[:text]} label="Text Input" size="4x1" placeholder="Enter text..." />
      <.email_input field={@test_form[:email]} label="Email" size="4x1" placeholder="email@example.com" />
      <.password_input field={@test_form[:password]} label="Password" size="4x1" placeholder="••••••••" />
      <.number_input field={@test_form[:number]} label="Number" size="4x1" placeholder="123" />
      <.textarea field={@test_form[:bio]} label="Bio" size="6x2" rows={4} placeholder="Tell us about yourself..." />
      
      <div class="widget-6x2">
        <h3 class="text-lg font-semibold mb-2">Input States</h3>
        <div class="space-y-2">
          <.text_input field={@test_form[:disabled]} label="Disabled" size="12x1" placeholder="Disabled input" />
          <.text_input field={@test_form[:required]} label="Required" size="12x1" required placeholder="Required field" />
        </div>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Selection Controls</h2>
      
      <.select_input 
        field={@test_form[:country]} 
        label="Country" 
        size="6x1"
        options={[
          {"Choose a country...", ""},
          {"United States", "us"},
          {"Canada", "ca"},
          {"United Kingdom", "uk"},
          {"Australia", "au"}
        ]}
      />
      
      <div class="widget-6x1">
        <.checkbox field={@test_form[:subscribe]} label="Subscribe to newsletter" />
      </div>
      
      <div class="widget-6x1">
        <.toggle field={@test_form[:notifications]} label="Enable notifications" />
      </div>
      
      <.radio_group 
        field={@test_form[:plan]} 
        label="Select Plan" 
        size="6x1"
        options={[
          {"Basic - $9/month", "basic"},
          {"Pro - $29/month", "pro"},
          {"Enterprise - Contact us", "enterprise"}
        ]}
      />
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Date, Time & File Inputs</h2>
      
      <.date_input field={@test_form[:date]} label="Date" size="4x1" />
      <.time_input field={@test_form[:time]} label="Time" size="4x1" />
      <.datetime_input field={@test_form[:datetime]} label="Date & Time" size="4x1" />
      
      <div class="widget-12x1 mb-4">
        <.range_slider field={@test_form[:range]} label="Volume" size="12x1" min={0} max={100} />
      </div>
      
      <div class="widget-12x1">
        <.file_input field={@test_form[:file]} label="Upload File" size="12x1" />
      </div>
    </.lego_grid>
    """
  end

  defp render_display_showcase(assigns) do
    ~H"""
    <.lego_grid>
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Cards</h2>
      
      <.card title="Basic Card" size="4x4">
        <p>This is a basic card with default settings. Cards are perfect for grouping related content.</p>
      </.card>
      
      <.card title="Card with Actions" size="4x4" bordered={false}>
        <p>This card has action buttons and no border for a cleaner look.</p>
        <:actions>
          <.widget_button variant="primary" size="sm">Buy Now</.widget_button>
          <.widget_button variant="ghost" size="sm">Cancel</.widget_button>
        </:actions>
      </.card>
      
      <.card title="Compact Card" size="4x4" compact>
        <p>Compact cards have less padding for dense layouts.</p>
      </.card>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Alerts</h2>
      
      <.alert type="info">
        <strong>Info:</strong> This is an informational alert message.
      </.alert>
      
      <.alert type="success" title="Success!" dismissible>
        Your operation completed successfully. This alert can be dismissed.
      </.alert>
      
      <.alert type="warning" title="Warning" dismissible>
        Please review your input. This is a warning that can be dismissed.
      </.alert>
      
      <.alert type="error" title="Error!" dismissible>
        Something went wrong. Please try again later.
      </.alert>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Badges</h2>
      
      <div class="widget-12x1 flex flex-wrap gap-2 mb-4">
        <.badge>Default</.badge>
        <.badge variant="primary">Primary</.badge>
        <.badge variant="secondary">Secondary</.badge>
        <.badge variant="accent">Accent</.badge>
        <.badge variant="info">Info</.badge>
        <.badge variant="success">Success</.badge>
        <.badge variant="warning">Warning</.badge>
        <.badge variant="error">Error</.badge>
      </div>
      
      <div class="widget-12x1 flex flex-wrap gap-2 mb-4">
        <.badge variant="primary" outline>Outline Primary</.badge>
        <.badge variant="secondary" outline>Outline Secondary</.badge>
        <.badge variant="accent" outline>Outline Accent</.badge>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Progress Bars</h2>
      
      <div class="widget-6x1">
        <.progress value={25} />
      </div>
      <div class="widget-6x1">
        <.progress value={50} variant="secondary" />
      </div>
      <div class="widget-6x1">
        <.progress value={75} variant="accent" />
      </div>
      <div class="widget-6x1">
        <.progress value={100} variant="success" />
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Stats</h2>
      
      <.stat title="Total Users" value="31K" desc="↗︎ 400 (22%)" size="3x1" />
      <.stat title="Revenue" value="$4,200" desc="↘︎ 90 (14%)" size="3x1" />
      <.stat title="Downloads" value="1.2M" desc="Jan 1st - Feb 1st" size="3x1" />
      <.stat title="Tasks Done" value="86%" size="3x1" />
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Tables</h2>
      
      <div class="widget-12x1">
        <.widget_table 
          data={@table_data} 
          columns={@table_columns}
          striped 
          hover 
        />
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Loading States</h2>
      
      <div class="widget-12x1 bg-base-200 p-4 rounded-lg mb-4">
        <h3 class="text-lg font-semibold mb-4">Loading Spinners</h3>
        <div class="flex items-center justify-around">
          <div class="text-center">
            <.loading size="xs" />
            <p class="text-xs mt-2">Extra Small</p>
          </div>
          <div class="text-center">
            <.loading size="sm" />
            <p class="text-sm mt-2">Small</p>
          </div>
          <div class="text-center">
            <.loading size="md" />
            <p class="text-sm mt-2">Medium</p>
          </div>
          <div class="text-center">
            <.loading size="lg" />
            <p class="text-sm mt-2">Large</p>
          </div>
        </div>
      </div>
      
      <div class="widget-6x1">
        <h3 class="text-lg font-semibold mb-2">Text Skeleton</h3>
        <.skeleton type="text" lines={3} />
      </div>
      
      <div class="widget-6x1">
        <h3 class="text-lg font-semibold mb-2">Card Skeleton</h3>
        <.skeleton type="card" />
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Progress Steps</h2>
      
      <.steps 
        steps={["Account", "Profile", "Shipping", "Payment", "Review"]} 
        current_step={2} 
      />
      
      <div class="widget-12x1 mt-4">
        <p class="text-sm text-base-content/70">Step 3 of 5: Currently on Shipping</p>
      </div>
    </.lego_grid>
    """
  end

  defp render_actions_showcase(assigns) do
    ~H"""
    <.lego_grid>
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Button Variants</h2>
      
      <.widget_button variant="primary" grid_size="2x1">Primary</.widget_button>
      <.widget_button variant="secondary" grid_size="2x1">Secondary</.widget_button>
      <.widget_button variant="accent" grid_size="2x1">Accent</.widget_button>
      <.widget_button variant="ghost" grid_size="2x1">Ghost</.widget_button>
      <.widget_button variant="link" grid_size="2x1">Link</.widget_button>
      <.widget_button variant="info" grid_size="2x1">Info</.widget_button>
      <.widget_button variant="success" grid_size="2x1">Success</.widget_button>
      <.widget_button variant="warning" grid_size="2x1">Warning</.widget_button>
      <.widget_button variant="error" grid_size="2x1">Error</.widget_button>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Outline Buttons</h2>
      
      <.widget_button variant="primary" outline grid_size="2x1">Primary</.widget_button>
      <.widget_button variant="secondary" outline grid_size="2x1">Secondary</.widget_button>
      <.widget_button variant="accent" outline grid_size="2x1">Accent</.widget_button>
      <.widget_button variant="info" outline grid_size="2x1">Info</.widget_button>
      <.widget_button variant="success" outline grid_size="2x1">Success</.widget_button>
      <.widget_button variant="warning" outline grid_size="2x1">Warning</.widget_button>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Button Sizes</h2>
      
      <div class="widget-12x1 flex items-end gap-2">
        <.widget_button size="xs">Extra Small</.widget_button>
        <.widget_button size="sm">Small</.widget_button>
        <.widget_button size="md">Medium</.widget_button>
        <.widget_button size="lg">Large</.widget_button>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Special Button States</h2>
      
      <.widget_button loading grid_size="2x1">Loading</.widget_button>
      <.widget_button disabled grid_size="2x1">Disabled</.widget_button>
      <.widget_button wide grid_size="4x1">Wide Button</.widget_button>
      <.widget_button block grid_size="12x1">Block Button (Full Width)</.widget_button>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Icon Buttons</h2>
      
      <div class="widget-12x1 flex items-center gap-4">
        <.icon_button variant="primary" size="sm">❤️</.icon_button>
        <.icon_button variant="secondary" size="md">⭐</.icon_button>
        <.icon_button variant="accent" size="lg">🎯</.icon_button>
        <.icon_button variant="error" size="md">🗑️</.icon_button>
        <.icon_button variant="info" size="md">ℹ️</.icon_button>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Button Groups</h2>
      
      <div class="widget-6x1">
        <.button_group>
          <.widget_button variant="primary">First</.widget_button>
          <.widget_button variant="primary">Second</.widget_button>
          <.widget_button variant="primary">Third</.widget_button>
        </.button_group>
      </div>
      
      <div class="widget-6x1">
        <.button_group>
          <.widget_button variant="secondary" outline>Option A</.widget_button>
          <.widget_button variant="secondary" outline>Option B</.widget_button>
        </.button_group>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Dropdowns</h2>
      
      <.dropdown label="User Menu" variant="primary" size="4x1">
        <li><a>👤 Profile</a></li>
        <li><a>⚙️ Settings</a></li>
        <li class="divider"></li>
        <li><a>🚪 Logout</a></li>
      </.dropdown>
      
      <.dropdown label="Actions" variant="secondary" size="4x1">
        <li><a>✏️ Edit</a></li>
        <li><a>📋 Copy</a></li>
        <li><a>🗑️ Delete</a></li>
      </.dropdown>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Modal Dialog</h2>
      
      <div class="widget-12x1 bg-base-200 p-6 rounded-lg">
        <p class="mb-4">Modals are used for important interactions that require user attention.</p>
        <.widget_button variant="primary" phx-click={show_modal("demo-modal")} grid_size="4x1">
          Open Demo Modal
        </.widget_button>
      </div>
      
      <.modal id="demo-modal" title="Confirm Action">
        <p class="mb-4">This is a modal dialog example. Modals are perfect for:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>Confirmation dialogs</li>
          <li>Forms that need focus</li>
          <li>Important notifications</li>
          <li>Detail views</li>
        </ul>
        <:actions>
          <.widget_button variant="ghost" phx-click={hide_modal("demo-modal")}>
            Cancel
          </.widget_button>
          <.widget_button variant="primary" phx-click={hide_modal("demo-modal")}>
            Confirm
          </.widget_button>
        </:actions>
      </.modal>
    </.lego_grid>
    """
  end

  defp render_layout_showcase(assigns) do
    ~H"""
    <.lego_grid>
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Tabs Component</h2>
      
      <div class="widget-12x1 bg-base-100 border border-base-300 rounded-lg p-4 mb-8">
        <h3 class="text-lg font-semibold mb-4">Interactive Tab Navigation</h3>
        <.tabs active_tab={@demo_tab} tabs={[
          {:overview, "Overview"},
          {:details, "Details"},
          {:settings, "Settings"}
        ]}>
          <.tab_panel tab={:overview} active_tab={@demo_tab}>
            <div class="p-6 bg-base-100">
              <h4 class="font-semibold mb-2">Overview Content</h4>
              <p>This is the overview tab content. Tabs help organize complex information into digestible sections.</p>
            </div>
          </.tab_panel>
          <.tab_panel tab={:details} active_tab={@demo_tab}>
            <div class="p-6 bg-base-100">
              <h4 class="font-semibold mb-2">Details Content</h4>
              <p>This is the details tab content. Each tab panel can contain any type of content including forms, lists, or other widgets.</p>
            </div>
          </.tab_panel>
          <.tab_panel tab={:settings} active_tab={@demo_tab}>
            <div class="p-6 bg-base-100">
              <h4 class="font-semibold mb-2">Settings Content</h4>
              <p>This is the settings tab content. Tab navigation provides a clean way to switch between different views.</p>
            </div>
          </.tab_panel>
        </.tabs>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Accordion Component</h2>
      
      <div class="widget-12x1 mb-8">
        <h3 class="text-lg font-semibold mb-4">Collapsible Content Sections</h3>
        <.accordion 
          items={[
            {"item1", "What is the Lego Widget System?", "The Lego Widget System is a comprehensive UI component library built on Phoenix LiveView and DaisyUI. It provides a consistent, grid-based approach to building user interfaces with reusable components."},
            {"item2", "How do I use widgets?", "Simply use the SuperdupernovaWeb.Widgets module and call widget functions in your templates. Each widget follows a predictable API with size, variant, and other customization options."},
            {"item3", "Can I customize the styling?", "Yes! All widgets support custom CSS classes and DaisyUI variants. You can also override default styles by passing additional classes or using DaisyUI's theming system."},
            {"item4", "What grid sizes are available?", "The system supports various grid sizes: 1x1, 2x1, 4x1, 6x1, 12x1, and multi-row variants like 12x2 and 12x4. This ensures consistent spacing and alignment."}
          ]}
          multiple={false}
        />
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Layout Utilities</h2>
      
      <div class="widget-12x1 bg-base-200 p-6 rounded-lg mb-4">
        <h3 class="text-lg font-semibold mb-4">Visual Separators</h3>
        
        <p class="mb-4">Standard divider:</p>
        <.divider />
        
        <p class="mb-4 mt-6">Divider with label:</p>
        <.divider label="Section Break" />
        
        <p class="mt-6">Dividers help separate content sections and improve visual hierarchy.</p>
      </div>
      
      <div class="widget-12x1 bg-base-200 p-6 rounded-lg mb-4">
        <h3 class="text-lg font-semibold mb-4">Spacing Control</h3>
        
        <div class="bg-primary text-primary-content p-3 rounded">Content Block 1</div>
        <.spacer size="2" />
        <div class="bg-secondary text-secondary-content p-3 rounded">Content Block 2 (2 units spacing)</div>
        <.spacer size="4" />
        <div class="bg-accent text-accent-content p-3 rounded">Content Block 3 (4 units spacing)</div>
        
        <p class="text-sm text-base-content/70 mt-4">
          Spacers provide consistent vertical spacing between elements using our unit-based system.
        </p>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Form Sections</h2>
      
      <div class="widget-12x1 mb-8">
        <.form_section title="User Information" description="Basic information about the user account">
          <.lego_grid>
            <.text_input field={@test_form[:first_name]} label="First Name" size="6x1" />
            <.text_input field={@test_form[:last_name]} label="Last Name" size="6x1" />
            <.email_input field={@test_form[:section_email]} label="Email Address" size="12x1" />
          </.lego_grid>
        </.form_section>
        
        <.form_section title="Preferences" description="Customize your experience">
          <.lego_grid>
            <div class="widget-6x1">
              <.toggle field={@test_form[:newsletter]} label="Receive newsletter" />
            </div>
            <div class="widget-6x1">
              <.toggle field={@test_form[:notifications]} label="Push notifications" />
            </div>
          </.lego_grid>
        </.form_section>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4">Drawer Component</h2>
      
      <div class="widget-12x1 bg-info/10 border border-info/20 p-6 rounded-lg">
        <h3 class="text-lg font-semibold mb-2">Slide-out Navigation Panel</h3>
        <p class="mb-4">
          The drawer widget provides a slide-out panel perfect for navigation menus, filters, or additional content that doesn't need to be visible at all times.
        </p>
        <.widget_button variant="info" grid_size="4x1">
          <a href="/drawer-test" class="block w-full">
            View Interactive Drawer Demo →
          </a>
        </.widget_button>
      </div>
      
      <h2 class="text-2xl font-semibold widget-12x1 mb-4 mt-8">Complete Layout Example</h2>
      
      <div class="widget-12x1 bg-base-100 border border-base-300 rounded-lg p-6">
        <h3 class="text-lg font-semibold mb-2">Combining Layout Widgets</h3>
        <p class="text-base-content/70 mb-4">
          Layout widgets can be combined to create complex, organized interfaces. Use tabs for major sections, 
          accordions for FAQs or collapsible content, form sections for grouping inputs, and dividers for visual separation.
        </p>
        <.divider label="Example Implementation" />
        <div class="text-sm bg-base-200 p-4 rounded mt-4 overflow-x-auto">
          <pre><code class="language-elixir"><%= example_code() %></code></pre>
        </div>
      </div>
    </.lego_grid>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "test_form")
    
    table_data = [
      %{id: 1, name: "John Doe", email: "john@example.com", status: "Active"},
      %{id: 2, name: "Jane Smith", email: "jane@example.com", status: "Active"},
      %{id: 3, name: "Bob Johnson", email: "bob@example.com", status: "Inactive"}
    ]
    
    table_columns = [
      %{key: :id, label: "ID"},
      %{key: :name, label: "Name"},
      %{key: :email, label: "Email"},
      %{key: :status, label: "Status"}
    ]
    
    {:ok, 
     socket
     |> assign(
       active_tab: :inputs,
       demo_tab: :overview,
       test_form: form,
       table_data: table_data,
       table_columns: table_columns
     )}
  end

  @impl true
  def handle_event("tab_clicked", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: String.to_atom(tab))}
  end

  @impl true
  def handle_event("demo_tab_clicked", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, demo_tab: String.to_atom(tab))}
  end
  
  def handle_event(event, params, socket) do
    IO.inspect({event, params}, label: "Unhandled event")
    {:noreply, socket}
  end
  
  defp example_code do
    """
    <.tabs active_tab={@active_tab} tabs={[
      {:general, "General"}, 
      {:advanced, "Advanced"}
    ]}>
      <.tab_panel tab={:general} active_tab={@active_tab}>
        <.form_section title="Basic Settings">
          <!-- form fields here -->
        </.form_section>
      </.tab_panel>
    </.tabs>
    """
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
  end
end