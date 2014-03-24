defmodule HexWeb.Web.Templates do
  require EEx

  def render(page, config, title \\ nil) do
    template_main(page, config, title)
  end

  defmacrop inner do
    quote do
      apply(__MODULE__, :"template_#{var!(page)}", [var!(config)])
    end
  end

  @templates [
    main: [:page, :config, :title],
    index: [:config] ]

  Enum.each(@templates, fn { name, args } ->
    file = Path.join([__DIR__, "templates", "#{name}.html.eex"])
    EEx.function_from_file(:def, :"template_#{name}", file, args)
  end)
end
