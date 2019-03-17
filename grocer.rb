require "pry"
def consolidate_cart(cart)
  
  cart.each_with_object({}) do |item, hash|
    item.each do |name, attributes|
     if hash[name]
       attributes[:count] += 1 
     else 
       attributes[:count] = 1
       hash[name] = attributes
     end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    
      if cart[name] && cart[name][:count] >= coupon[:num]
        if cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += 1 
        elsif
           cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
           else
             cart[name][:count] > coupon[:num]
        end
        cart[name][:count] -= coupon[:num]
      end  
    end
  cart
end

def apply_clearance(cart)
  cart.each do |name, items|
    if items[:clearance] == true
      updated_price = items[:price] * 0.80
      items[:price] = updated_price.round(2)
    end
  end 
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = coupon_cart
  total = 0 
  clearance_cart.each do |name, properties|
    total += properties[:price] + properties[:count]
    
  end
    
  total = total * 0.9  if total > 100
  total
end
