module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Mysize -スニーカーサイジング共有SNS-"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
end
