require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '購物車基本功能' do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變" do
      cart = Cart.new
      3.times { cart.add_item(1) }
      5.times { cart.add_item(2) }
      2.times { cart.add_item(1) }
      expect(cart.items.count).to be 2
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart = Cart.new
      p1 = Product.create(title: '紅寶石會員', price: 100)

      cart.add_item(p1.id)

      expect(cart.items.first.product.id).to be p1.id
    end

    it "每個 Cart Item 都可以計算它自己的金額（小計）" do
      cart = Cart.new
      p1 = Product.create(title: '紅寶石會員', price: 100)
      p2 = Product.create(title: '藍寶石會員', price: 500)

      3.times{ cart.add_item(p1.id) }
      2.times{ cart.add_item(p2.id) }

      expect(cart.items.first.total_price).to be 300
      expect(cart.items.last.total_price).to be 1000
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      p1 = Product.create(title: '紅寶石會員', price: 100)
      p2 = Product.create(title: '藍鑽石會員', price: 500)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to be 1300
    end
    it "特別活動可能可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百）" do
      cart = Cart.new
      p1 = Product.create(title: '紅寶石會員', price: 100)
      p2 = Product.create(title: '藍鑽石會員', price: 500)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      t = Time.local(2008, 12, 25, 10, 5, 0)
      Timecop.travel(t)
      expect(cart.total_price).to eq 1170
    end

    # 透過網路傳輸的過程中，物件會消失，因此希望透過轉成hash的方式
  describe "購物車進階功能" do
    it "可以將購物車內容轉換成 Hash，存到 Session 裡" do
      cart = Cart.new

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }


      expect(cart.serialize).to eq cart_hash
    end

    it "可以把 Session 的內容（Hash 格式），還原成購物車的內容"
  end
end

  private
  def cart_hash
  {
      "items" => 
      [
        { "item_id" => 1, "quantity" => 3 },
        { "item_id" => 2, "quantity" => 2 }
      ]
  }
  end
end