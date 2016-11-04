defmodule ExForm do

    def new do
        []
    end

    def multiple_choice(state, question, choices, required \\ false, description \\ "") do
        kind = "multiple_choice"
        body = %{
            "type": kind,
            "question": question,
            "description": description,
            "required": required,
            "choices": Enum.map(choices, fn c -> %{ "label" => c } end)
        }
        state ++ [body]
    end

    def publish(fields, title, web_hook, tags \\ [:deafult]) do
        data = %{
            "title": title,
            "tags": tags,
            "webhook_submit_url": web_hook,
            "fields": fields
        } |> Poison.encode!
        secret = System.get_env("TYPE_SECRET")
        response = Tesla.post("https://api.typeform.io/v0.4/forms", data, headers: %{"Content-Type" => "application/json", "X-API-TOKEN" => secret})
        response
    end
end
