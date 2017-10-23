class ProductsController < ApplicationController
  PAGE_SIZE = 15

  def index
    @page = (params[:page] || 0).to_i #Pagination
    if params[:keywords].present?
      @keywords = params[:keywords]
      products_search_term = ProductSearchTerm.new(@keywords)
      @products = Product.where(
        products_search_term.where_clause,
        products_search_term.where_args).
        order(products_search_term.order).
        offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    else
      @products = []
    end
  end

end

