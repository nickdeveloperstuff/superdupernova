defmodule SuperdupernovaWeb.DisplayTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  @sample_data [
    %{id: 1, name: "John Doe", email: "john@example.com", status: "Active"},
    %{id: 2, name: "Jane Smith", email: "jane@example.com", status: "Active"},
    %{id: 3, name: "Bob Johnson", email: "bob@example.com", status: "Inactive"},
    %{id: 4, name: "Alice Brown", email: "alice@example.com", status: "Active"},
    %{id: 5, name: "Charlie Wilson", email: "charlie@example.com", status: "Pending"}
  ]

  @columns [
    %{key: :id, label: "ID"},
    %{key: :name, label: "Name"},
    %{key: :email, label: "Email"},
    %{key: :status, label: "Status"}
  ]

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Display Widgets Test</h1>
        
        <h2 class="text-xl font-semibold mb-unit-2">Card Widgets</h2>
        <.lego_grid>
          <.card title="Basic Card" size="4x4">
            This is a basic card with default settings.
          </.card>
          
          <.card title="Card with Actions" size="4x4" bordered={false}>
            This card has action buttons.
            <:actions>
              <button class="btn btn-primary btn-sm">Buy Now</button>
              <button class="btn btn-ghost btn-sm">Cancel</button>
            </:actions>
          </.card>
          
          <.card title="Compact Card" size="4x4" compact>
            This is a compact card with less padding.
          </.card>
          
          <.card 
            title="Card with Image" 
            size="6x4"
            image_url="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg"
          >
            This card includes an image at the top.
            <:actions>
              <button class="btn btn-primary">View Details</button>
            </:actions>
          </.card>
          
          <.card title="Full Width Card" size="12x4">
            This is a full-width card that spans the entire grid.
            It's perfect for content that needs more horizontal space.
          </.card>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Alert Widgets</h2>
        <.lego_grid>
          <.alert type="info">
            This is an informational alert message.
          </.alert>
          
          <.alert type="success" title="Success!">
            Your operation completed successfully.
          </.alert>
          
          <.alert type="warning" title="Warning" dismissible>
            This is a warning that can be dismissed.
          </.alert>
          
          <.alert type="error" title="Error!" dismissible>
            Something went wrong. Please try again.
          </.alert>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Badge Widgets</h2>
        <.lego_grid>
          <div class="widget-12x1 space-x-2">
            <.badge>Default</.badge>
            <.badge variant="primary">Primary</.badge>
            <.badge variant="secondary">Secondary</.badge>
            <.badge variant="accent">Accent</.badge>
            <.badge variant="ghost">Ghost</.badge>
            <.badge variant="info">Info</.badge>
            <.badge variant="success">Success</.badge>
            <.badge variant="warning">Warning</.badge>
            <.badge variant="error">Error</.badge>
          </div>
          
          <div class="widget-12x1 space-x-2">
            <.badge variant="primary" size="sm">Small</.badge>
            <.badge variant="primary" size="md">Medium</.badge>
            <.badge variant="primary" size="lg">Large</.badge>
          </div>
          
          <div class="widget-12x1 space-x-2">
            <.badge variant="primary" outline>Outline Primary</.badge>
            <.badge variant="secondary" outline>Outline Secondary</.badge>
            <.badge variant="accent" outline>Outline Accent</.badge>
          </div>
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Table Widget</h2>
        <.lego_grid>
          <.widget_table data={@sample_data} columns={@columns} />
          
          <.widget_table 
            data={@sample_data} 
            columns={@columns} 
            striped={false} 
            hover={false} 
            compact 
          />
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Progress Widgets</h2>
        <.lego_grid>
          <.progress value={25} />
          <.progress value={50} variant="secondary" />
          <.progress value={75} variant="accent" />
          <.progress value={100} variant="success" />
          <.progress value={33} variant="warning" size="6x1" />
          <.progress value={10} variant="error" size="6x1" />
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Stat Widgets</h2>
        <.lego_grid>
          <.stat title="Total Users" value="31K" desc="↗︎ 400 (22%)" />
          <.stat title="Revenue" value="$4,200" desc="↘︎ 90 (14%)" />
          <.stat title="Downloads" value="1.2M" desc="Jan 1st - Feb 1st" />
          <.stat title="Tasks Done" value="86%" />
        </.lego_grid>
        
        <h2 class="text-xl font-semibold mb-unit-2 mt-unit-4">Layout Enhancement Widgets</h2>
        
        <.divider label="Divider with Label" />
        
        <.spacer size="2" />
        
        <.divider />
        
        <.spacer size="4" />
        
        <.form_section title="User Information" description="Please provide your basic details">
          <div class="widget-6x1">
            <p>Form elements would go here</p>
          </div>
          <div class="widget-6x1">
            <p>More form elements</p>
          </div>
        </.form_section>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, sample_data: @sample_data, columns: @columns)}
  end
end