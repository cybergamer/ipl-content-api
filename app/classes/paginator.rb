class Paginator

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 50

  attr_accessor :page, :per_page, :num_pages

  def paginate(items, options = {})
    @page = options[:page] ? options[:page].to_i : DEFAULT_PAGE
    @per_page = options[:per_page] ? options[:per_page].to_i : DEFAULT_PER_PAGE
    if paginate?(items, @page, @per_page, options)
      result = items[((@page - 1) * @per_page)...(@page * @per_page)]
    else
      result = items
    end
    @num_pages = ( items.size.to_f / @per_page.to_f ).ceil
    result
  end

  def paginate?(items, page = nil, per_page = nil, options = {})
    (page > 0) and (per_page > 0)
  end

end