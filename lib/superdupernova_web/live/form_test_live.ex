defmodule SuperdupernovaWeb.FormTestLive do
  use SuperdupernovaWeb, :live_view
  use SuperdupernovaWeb.Widgets

  defmodule TestForm do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :name, :string
      field :email, :string
      field :password, :string
      field :age, :integer
      field :bio, :string
      field :country, :string
      field :agree_terms, :boolean, default: false
      field :notifications, :boolean, default: false
      field :plan, :string
      field :avatar, :string
      field :birth_date, :date
      field :appointment_time, :time
      field :event_datetime, :naive_datetime
      field :volume, :integer, default: 50
    end

    def changeset(form, attrs \\ %{}) do
      form
      |> cast(attrs, [:name, :email, :password, :age, :bio, :country, :agree_terms, :notifications, :plan, :avatar, :birth_date, :appointment_time, :event_datetime, :volume])
      |> validate_required([:name, :email, :password])
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 8)
      |> validate_number(:age, greater_than: 0, less_than: 150)
      |> validate_length(:bio, max: 500)
      |> validate_inclusion(:country, ["us", "ca", "uk", "au"])
      |> validate_inclusion(:plan, ["basic", "pro", "enterprise"])
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
            <.email_input field={@form[:email]} label="Email" size="6x1" />
            <.password_input field={@form[:password]} label="Password" size="6x1" />
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
            <.textarea field={@form[:bio]} label="Bio" size="12x2" 
              placeholder="Tell us about yourself..." />
            <.checkbox field={@form[:agree_terms]} label="I agree to terms" size="6x1" />
            <.toggle field={@form[:notifications]} label="Email notifications" size="6x1" />
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
            <.file_input field={@form[:avatar]} label="Upload Avatar" size="6x1" accept="image/*" />
            <.date_input field={@form[:birth_date]} label="Birth Date" size="4x1" />
            <.time_input field={@form[:appointment_time]} label="Appointment Time" size="4x1" />
            <.datetime_input field={@form[:event_datetime]} label="Event Date & Time" size="6x1" />
            <.range_slider field={@form[:volume]} label="Volume" size="6x1" min={0} max={100} />
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