class TimeFormatter

  TIME_FORMAT = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def call(format_params)
    @time_params = []
    @unknown_params = []
    format_params.split(',').uniq.each{ |p| filter_param(p.strip.downcase) } unless format_params.nil?
  end

  def time_string
    Time.now.strftime(@time_params.join('-'))
  end

  def invalid_string
    "Unknown time format #{@unknown_params}!"
  end

  def success?
    @unknown_params.empty?
  end

  private

  def filter_param(param)
    if TIME_FORMAT[param]
      @time_params << TIME_FORMAT[param]
    else
      @unknown_params << param
    end
  end
end
