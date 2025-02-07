module ApplicationHelper
  def status_button_class(status)
    case status
    when "not_started"
      "mt-2 rounded-md px-3.5 py-2.5 bg-gray-400 hover:bg-gray-300 text-white font-medium"
    when "in_process"
      "mt-2 rounded-md px-3.5 py-2.5 bg-blue-500 hover:bg-blue-400 text-white font-medium"
    when "completed"
      "mt-2 rounded-md px-3.5 py-2.5 bg-green-500 hover:bg-green-400 text-white font-medium"
    end
  end
end
