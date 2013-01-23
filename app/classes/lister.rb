class Lister

  attr_accessor :paginator

  def to_list(items, options = {})
    @paginator = options[:paginator] || Paginator.new
    items = @paginator.paginate(items, options)
    items
  end

end