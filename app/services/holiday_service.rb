require "httparty"
require "json"

class HolidayService

  def self.holiday_info
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/us")
    parsed = JSON.parse(response.body, symbolize_names: true)
    holiday = parsed.map do |data|
      Holiday.new(data)
    end
    holiday.first(3)
  end
end