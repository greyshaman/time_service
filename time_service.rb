require "sinatra"
require 'sinatra/base'
require "yaml"
require "time"
require 'timezone'

TIME_FORMAT = '%Y-%m-%d %T'

CITIES_TIMEZONES_FILE = 'cities_tz.yml'
CTZ_DB                = YAML.load_file CITIES_TIMEZONES_FILE


class TimeService < Sinatra::Base

  def initialize
    super
    @cities_tz = YAML.load_file CITIES_TIMEZONES_FILE
  end

  get "/time" do
    output = []
    output << "UTC: #{Time.now.utc.strftime(TIME_FORMAT)}"
    cities = params.keys.first
    if cities
      output << time_for_cities(cities)
    end
    output.join("<br>")
  end

  def time_for_cities(cities_line)
    arr_times = []
    cities    = cities_line.split ','

    cities.each do |city|
      time = time_now_for(city)
      arr_times << time if time
    end
    arr_times
  end

  def time_now_for(city)
    tz_name = @cities_tz[city]
    # p "tz_name: #{tz_name}"

    if tz_name
      timezone = Timezone[tz_name]
      time     = timezone.time(Time.now).strftime(TIME_FORMAT)
      "#{city}: #{time}"
    else
      ""
    end
  end

  TimeService.run!
end
