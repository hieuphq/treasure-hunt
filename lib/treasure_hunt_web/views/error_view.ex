defmodule TreasureHuntWeb.ErrorView do
  use TreasureHuntWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("400.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def template_not_found(_template, %{message: message}) do
    %{message: message}
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
