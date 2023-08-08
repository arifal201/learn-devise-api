class Api::V1::InvoicesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false 
  before_action :current_user
  before_action :set_invoice, only: [:show, :update, :destroy]
  before_action :calculate, only: :create

  def index
    @invoices = Invoice.all
    render json: {invoices: InvoiceSerializer.many(@invoices)}
  end

  def user_invoices
    render json: {user_invoices: UserInvoiceSerializer.one(@current_user.resource_owner)}
  end

  def create
    ActiveRecord::Base.transaction do
      @invoice = Invoice.new(invoice_params.merge(hash_full_params))
      if @invoice.save!
        render json: {invoices: InvoiceSerializer.one(@invoice)}
      else
        render json: {messages: 'Failed to create invoice'}, status: 400
      end
    end
  end

  def show
    render json: {invoices: InvoiceSerializer.one(@invoice)}
  rescue => exception
    render json: {messages: exception}, status: 400
  end

  def user_invoice_detail
    @user_invoice_detail = @current_user.resource_owner.invoices.find(params[:id])
    render json: {invoices: InvoiceSerializer.one(@user_invoice_detail)}
  rescue => exception
    render json: {messages: exception}, status: 400
  end

  def calculate
    @total_prices = 0
    @total_qty = 0
    if params[:invoice][:invoice_products_attributes].present?
      params[:invoice][:invoice_products_attributes].map do |product|
        @total_prices += product[:prices].to_f * product[:quantity].to_i
        @total_qty += product[:quantity].to_i
      end
    else
      render json: {
        messages: 'Product not found'
      }, status: 400
    end
  end

  def hash_full_params
    {
      total_prices: @total_prices,
      total_qty: @total_qty,
      invoice_number: "INV-#{Time.now.utc.to_i}",
      user: @current_user.resource_owner
    }
  end

  def destroy
    @current_user.resource_owner.invoices.find(params[:id]).destroy!
    render json: {messages: "Successfuly destroy invoices #{params[:id]}"}, status: 200
  rescue => exception
    render json: {messages: exception}, status: 400
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  rescue => exception 
    render json: {messages: exception}, status: 400
  end

  def invoice_params
    params.require(:invoice).permit(:due_date,:item_name, :total_prices, :total_qty, invoice_products_attributes: [:id, :quantity, :product_id, :prices, :name, :_destroy])
  end
end
