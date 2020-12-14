# PORO = Plain Old Ruby Object 純ruby物件
class Cart

  def initialize
    @items = []
  end

  # 如果在這邊用items=[]每次要add item時，都會是空陣列
  def add_item(item_id, quantity = 1)
    # 判斷
    found_item = @items.find { |item| item.item_id == item.id }

    # 如果找到的話，就增加數量，否則就給這個新的商品
    if found_item
      found_item.increment(quantity)
    else
      @items << CartItem.new(item_id, quantity)
    end
  end

  # 陣列裡面本來就會有empty方法
  def empty?
    @items.empty?
  end

  def items
    @items
  end
  
  def total_price
    total = @items.sum { |item| item.totla_price }
    if Date.today.month == 12 && Date.today.day == 25
      total = total * 0.9
    end

    total
  end

  def serialize
    items = [
        { "item_id" => 1, "quantity" => 3 },
        { "item_id" => 2, "quantity" => 2 }
    ]

    { "items" => items }
  end

end