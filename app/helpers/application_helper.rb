module ApplicationHelper
  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def time_ago time
    time_ago_in_words(time)
  end

  def remove_html_tag html
    html.gsub('<h1>', '').gsub('</h1>', '').gsub('<h2>', '').gsub('</h2>', '').gsub('<i>', '').gsub('</i>', '').gsub('<b>', '').gsub('</b>', '').gsub('<strong>', '').gsub('</strong>', '')
  end
end
