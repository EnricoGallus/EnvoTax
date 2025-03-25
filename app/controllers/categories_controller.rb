# frozen_string_literal: true

# Controller for categories
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result(distinct: true)
  end

  # GET /categories/1
  def show; end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: t("categories.successfully_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: t("categories.successfully_updated"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy!
    redirect_to categories_path, notice: t("categories.successfully_destroyed"), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.expect(category: [:name])
  end
end
