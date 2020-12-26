# frozen_string_literal: true

require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select "h2", "Your Cart"
    assert_select "td", "Programming Ruby 1.9"
  end

  test "should create line_item with multiple products" do
    assert_difference("LineItem.count", 2) do
      post line_items_url, params: { product_id: products(:ruby).id }
      post line_items_url, params: { product_id: products(:ruby).id }
      post line_items_url, params: { product_id: products(:apps).id }
    end

    follow_redirect!

    assert_select "h2", "Your Cart"
    assert_select("tr#line-item-#{products(:ruby).id}") do
      assert_select "td.quantity", "2"
      assert_select "td.price", "$99.00"
    end
    assert_select("tr#line-item-#{products(:apps).id}") do
      assert_select "td.quantity", "1"
      assert_select "td.price", "$29.99"
    end
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item),
      params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to cart_url
  end
end
