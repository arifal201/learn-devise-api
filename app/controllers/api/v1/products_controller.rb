class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false 
  before_action :current_user
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render json: {products: ProductSerializer.many(@products)}
  end

  def show
    render json: ProductSerializer.one(@product)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: ProductSerializer.one(@product)
    else
      render json: {messages: "failed to create product"}
    end
  end

  def update
    @product.update(product_params)
    if @product.save
      render json: ProductSerializer.one(@product)
    else
      render json: {messages: "failed to update product"}
    end
  end

  def destroy
    if @product.destroy
      render json: {messages: "successfuly to destroy product"}
    else
      render json: {messages: "failed to destroy product"}
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :prices, :quantity)
  end
end
