require_relative "time_formatter"

class App

  HEADERS = { "Content-Type" => "text/plain" }

  def call(env)
    if env["PATH_INFO"] == '/time'
      prepare_response(env["QUERY_STRING"])
    else
      response(404, "Not found")
    end
  end

  private

  def prepare_response(query_string)
    time_formatter = TimeFormatter.new
    time_formatter.call(query_string)

    if time_formatter.success?
      response(200, time_formatter.time_string)
    else
      response(400, time_formatter.invalid_string)
    end
  end

  def response(code, body)
    [code, HEADERS, ["#{body}\n"]]
  end
  
end
