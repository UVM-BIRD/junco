# manually load libs for production environment, where lib auto-loading is disabled for thread-safety

#if Rails.env == 'production'
  Dir["#{Rails.root}/lib/**/*.rb"].each do |rb|
    require rb
  end

  Dir["#{Rails.root}/app/models/*.rb"].each do |rb|
    require rb
  end
#end
