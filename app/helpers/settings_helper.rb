module SettingsHelper
  def size_array
    ary = []
    17.times do |n|
      ary << ["#{21.5+0.5*(n+1)}cm", 21.5+0.5*(n+1)]
    end
    ary
  end
end
