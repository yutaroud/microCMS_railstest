module ArticlesHelper
  def pagination_num(offset, content_length)
    return [] if content_length < 0

    last_page = (content_length.to_f / Microcms::PAGE_LIMIT).ceil
    current_page = (offset / Microcms::PAGE_LIMIT).floor + 1

    return [*1..last_page] if last_page < 10

    near_page_size = 2
    first_page = 1

    if (current_page - first_page) < 0
      [*first_page..(first_page + near_page_size), last_page]
    elsif (current_page - first_page) <= near_page_size
      [*first_page..(current_page + near_page_size), last_page]
    elsif (current_page - first_page) >= near_page_size && current_page < last_page - near_page_size
      [first_page, *(current_page - near_page_size)..(current_page + near_page_size), last_page].uniq
    elsif (current_page - last_page) <= near_page_size
      [first_page, *(current_page - near_page_size)..last_page]
    else
      []
    end
  end
end
