class CartItem
  # 為了能夠統計購物車內容的數量，所以做出這PORO
  attr_reader :item_id, :quantity

  def initialize(item_id, quantity = 1)
    @item_id = item_id
    @quantity = quantity
  end

  def increment(n = 1)
    @quantity += n
  end

  def product
    # 回傳指定商品
    Product.find(@item_id)
  end

  def total_price
    @quantity * product.price
  end
end