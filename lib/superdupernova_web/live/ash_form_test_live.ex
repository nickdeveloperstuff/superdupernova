defmodule SuperdupernovaWeb.AshFormTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets
  alias Superdupernova.Accounts.TestUser

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lego-page">
      <.lego_container>
        <h1 class="text-2xl font-bold mb-unit-4">Ash Form Integration Test</h1>
        
        <.lego_grid>
          <.card title="User Registration Form" size="12x4" bordered>
            <.form
              :let={f}
              for={@form}
              phx-change="validate"
              phx-submit="submit"
            >
              <.lego_grid>
                <.text_input 
                  field={f[:email]} 
                  label="Email" 
                  type="email" 
                  size="6x1" 
                  required 
                />
                
                <.text_input 
                  field={f[:name]} 
                  label="Name" 
                  size="6x1" 
                  required 
                />
                
                <.number_input 
                  field={f[:age]} 
                  label="Age" 
                  size="6x1" 
                />
                
                <.select_input 
                  field={f[:country]} 
                  label="Country" 
                  size="6x1"
                  options={[
                    {"United States", "us"},
                    {"Canada", "ca"},
                    {"United Kingdom", "uk"},
                    {"Australia", "au"}
                  ]}
                />
                
                <.textarea 
                  field={f[:bio]} 
                  label="Bio" 
                  size="12x2" 
                  rows={4} 
                />
                
                <.checkbox 
                  field={f[:notifications]} 
                  label="Receive email notifications" 
                  size="12x1"
                />
                
                <.form_section title="Addresses" description="Add your addresses">
                  <div class="widget-12x1">
                    <.inputs_for :let={faddr} field={f[:addresses]}>
                      <div class="border border-base-300 rounded-lg p-4 mb-4">
                        <.lego_grid>
                          <.text_input 
                            field={faddr[:street]} 
                            label="Street" 
                            size="12x1" 
                            required 
                          />
                          
                          <.text_input 
                            field={faddr[:city]} 
                            label="City" 
                            size="6x1" 
                            required 
                          />
                          
                          <.text_input 
                            field={faddr[:state]} 
                            label="State" 
                            size="2x1" 
                            placeholder="XX"
                            required 
                          />
                          
                          <.text_input 
                            field={faddr[:zip]} 
                            label="ZIP Code" 
                            size="4x1" 
                            placeholder="12345"
                            required 
                          />
                          
                          <div class="widget-12x1">
                            <.widget_button 
                              type="button" 
                              variant="error" 
                              size="sm"
                              phx-click="remove_address"
                              phx-value-path={faddr.name}
                            >
                              Remove Address
                            </.widget_button>
                          </div>
                        </.lego_grid>
                      </div>
                    </.inputs_for>
                    
                    <.widget_button 
                      type="button" 
                      variant="secondary" 
                      phx-click="add_address"
                    >
                      Add Address
                    </.widget_button>
                  </div>
                </.form_section>
                
                <div class="widget-12x1 flex gap-2 justify-end mt-4">
                  <.widget_button type="button" variant="ghost" phx-click="reset">
                    Reset
                  </.widget_button>
                  <.widget_button type="submit" variant="primary">
                    Submit
                  </.widget_button>
                </div>
              </.lego_grid>
            </.form>
            
            <%= if @submitted_data do %>
              <.alert type="success" title="Form Submitted!" dismissible>
                User created successfully with ID: <%= @submitted_data.id %>
              </.alert>
            <% end %>
          </.card>
          
          <.card title="Form State" size="6x4">
            <h3 class="font-semibold mb-2">Current Form Data:</h3>
            <pre class="bg-base-200 p-2 rounded text-sm overflow-auto"><%= Jason.encode!(form_data(@form), pretty: true) %></pre>
          </.card>
          
          <.card title="Form Errors" size="6x4">
            <h3 class="font-semibold mb-2">Validation Errors:</h3>
            <%= if form_errors(@form) == [] do %>
              <p class="text-success">No errors</p>
            <% else %>
              <ul class="list-disc list-inside text-error">
                <%= for {field, errors} <- form_errors(@form) do %>
                  <%= for error <- errors do %>
                    <li><%= field %>: <%= error %></li>
                  <% end %>
                <% end %>
              </ul>
            <% end %>
          </.card>
        </.lego_grid>
      </.lego_container>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form = 
      TestUser
      |> AshPhoenix.Form.for_create(:register)
      |> to_form()
    
    {:ok, assign(socket, form: form, submitted_data: nil)}
  end

  @impl true
  def handle_event("validate", %{"form" => params}, socket) do
    form = 
      socket.assigns.form
      |> AshPhoenix.Form.validate(params)
      |> to_form()
    
    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("submit", %{"form" => params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, user} ->
        {:noreply, 
         socket
         |> assign(submitted_data: user)
         |> put_flash(:info, "User created successfully!")
        }
      
      {:error, form} ->
        {:noreply, assign(socket, form: to_form(form))}
    end
  end

  @impl true
  def handle_event("reset", _, socket) do
    form = 
      TestUser
      |> AshPhoenix.Form.for_create(:register)
      |> to_form()
    
    {:noreply, assign(socket, form: form, submitted_data: nil)}
  end

  @impl true
  def handle_event("add_address", _, socket) do
    form = AshPhoenix.Form.add_form(socket.assigns.form, [:addresses])
    {:noreply, assign(socket, form: to_form(form))}
  end

  @impl true
  def handle_event("remove_address", %{"path" => path}, socket) do
    form = AshPhoenix.Form.remove_form(socket.assigns.form, path)
    {:noreply, assign(socket, form: to_form(form))}
  end

  defp form_data(form) do
    AshPhoenix.Form.params(form)
  end

  defp form_errors(form) do
    form.errors
  end
end