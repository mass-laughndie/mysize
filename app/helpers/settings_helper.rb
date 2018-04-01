module SettingsHelper
  def size_array
    ary = []
    17.times do |n|
      ary << ["#{21.5+0.5*(n+1)}cm", 21.5+0.5*(n+1)]
    end
    ary
  end

  def brand_array
    ary = [
      ["Adidas(アディダス)", "Adidas(アディダス)"],
      ["Asics(アシックス)", "Asics(アシックス)"],
      ["Converse(コンバース)", "Converse(コンバース)"],
      ["New Balance(ニューバランス)", "New Balance(ニューバランス)"],
      ["Nike(ナイキ)", "Nike(ナイキ)"],
      ["Puma(プーマ)", "Puma(プーマ)"],
      ["Reebok(リーボック)", "Reebok(リーボック)"],
      ["Vans(バンズ)", "Vans(バンズ)"]
    ]
    
  end
end
