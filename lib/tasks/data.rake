require 'ffaker'

namespace :data do

  desc "Cert seed"
  task certs: :environment do
    ["Renault" , "Bosch", "Manowar"].each do |c|
      ManufactureCert.create name: c
    end
  end

  desc "Spare seed"
  task spares: :environment do
    require 'csv'
    csv_file = "#{Rails.root}/data/search/spares.csv"
    CSV.foreach(csv_file, headers: true,col_sep: ";", header_converters: :symbol) do |row|
      Spare.create(manufacture: row[:manufacture].strip, number: row[:number], title: row[:title], price: row[:price],seller: row[:seller],avalaible: row[:avalaible])
    end
  end

  desc "City seed"
  task city: :environment do
    state = State.create name: "Санкт-Петербург"
    City.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE cities RESTART IDENTITY")
    [ "Санкт-Петербург", "Зеленогорск", "Пушкин", "Павловск", "Колпино", "Красное Село",
      "Сестрорецк", "Петергоф", "Ломоносов", "Кронштадт", "Бокситогорск", "Волосово",
      "Волхов", "Всеволожск", "Выборг", "Высоцк", "Гатчина", "Кингисепп", 'Кириши',
      "Кировск", "Лодейное поле", "Луга", "Любань", "Новая Ладога", "Отрадное",
      "Шлиссельбург", "Пикалёво", "Подпорожье", "Приозерск", 'Приморск', "Сертолово",
      "Сланцы", "Сосново", "Сосновый Бор", "Тихвин", "Тосно" ].each do |c|
      City.create name: c, state: state
    end
  end

  task district: :environment do
    [
      "Адмиралтейский", "Василеостровский", "Выборгский СПб", "Калининский", "Кировский СПб",
      "Колпинский", "Красногвардейский", "Красносельский", "Кронштадтcкий", "Курортный",
      "Московский", "Невский", "Петроградский", "Петродворцовый", "Приморский", "Пушкинский",
      "Фрунзенский", "Центральный"
    ].each do |d|
      District.create(name: d, city_id: 1)
    end
  end

  task category_auto: :environment do
    [
      "Легковые", "Легкие грузовики и микроавтобусы", "Средние и тяжелые грузовики",
      "Автобусы", "Грузовые прицепы", "Легковые прицепы", "Мотоциклы", "Автокраны",
      "Бульдозеры", "Экскаваторы", "Автопогрузчики", "Строительная техника", "Спецтехника"
   ].each do |ca|
      CategoryAuto.create(name: ca)
    end
  end

  task job_type: :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE job_types RESTART IDENTITY")
    ActiveRecord::Base.connection.execute("TRUNCATE sub_job_types RESTART IDENTITY")
    job_types = {
      "Ремонт подвески" => "Восстановление рулевых наконечников, Диагностика подвески, Замена и ремонт рулевых реек, Замена тормозных колодок, Проточка тормозных дисков, Развал-схождение, Ремонт гидроусилителей (ГУР), Ремонт электроусилителей (ЭУР), Ремонт дисков, Ремонт пневмоподвески, Ремонт рулевого управления, Ремонт тормозной системы",
      "Ремонт двигателей" => "Диагностика двигателя, Замена масла в двигателе, Замена ремня ГРМ, Замена свечей, Замена фильтров, Промывка, диагностика и ремонт форсунок, Промывка инжекторов, Ремонт Common Rail, Ремонт дизельных двигателей, Ремонт карбюраторов, Ремонт ТНВД, Ремонт топливной системы, Ремонт турбин",
      "Ремонт системы охлаждения" => "Ремонт радиаторов, Промывка системы охлаждения, Заправка и ремонт автокондиционеров, Ремонт отопителей",
      "Ремонт трансмиссии" => "Замена масла в АКПП, Ремонт АКПП, Ремонт МКПП, Ремонт вариаторов (CVT), Ремонт роботизированных коробок (РКПП), Ремонт карданных валов, Ремонт редукторов, Ремонт сцепления",
      "Кузовной ремонт" => "Восстановление геометрии кузова, Ремонт и покраска бамперов, Ремонт пластика, Сварка аргоном, Сварочные работы",
      "Малярные работы" => "Аэрография, Бронирование антигравийной плёнкой, Нанокерамическая обработка кузова, Оклейка винилом, Покраска, Полировка, Ремонт вмятин без покраски, Ремонт лакокрасочного покрытия",
      "Ремонт электрооборудования" => "Автозвук, Регулировка фар, Ремонт генераторов, Ремонт стартеров, Ремонт электронных систем, Установка Webasto, Установка и ремонт рефрижераторов, Установка и ремонт сигнализаций, Установка ксенона, Установка парктроников",
      "Другое" => "Антикоррозийная обработка, Замена и ремонт автостекол, Компьютерная диагностика, Отогрев авто, Перетяжка салона, Плановое ТО, Подготовка внедорожников, Полировка фар, Предпродажная подготовка, Программирование ключей иммобилайзера, Ремонт выхлопной системы, Установка защиты двигателя, Шумоизоляция"
    }
    job_types.keys.each do |jt|
      j = JobType.create(name: jt)
      job_types[jt].split(", ").each do |sjt|
        SubJobType.create(name: sjt, job_type_id: j.id)
      end
    end
  end

  task service: :environment do
    [
      "Автокредитование", "Автострахование", "Выездной ремонт", "Выкуп автомобилей",
      "Грузовой шиномонтаж", "Зона ожидания", "Кафе", "Магазин аксессуаров",
      "Магазин запчастей", "Магазин масел и автохимии", "Мойка", "Независимая экспертиза",
      "Оплата по безналу", "Оплата по банковским картам", "Парковка", "Подменный автомобиль",
      "Полировка", "Продажа автомобилей", "Работа с юридическими лицами", "Ремонт в кредит",
      "Сезонное хранение колес", "Такси", "Телевизор", "Тюнинг", "Химчистка", "Чай-кофе", "Шиномонтаж",
      "Эвакуатор", "Юридические услуги", "Wi-fi"
      ].each do |s|
        Service.create(name: s)
      end
  end

  task control_programm: :environment do
    [
      "1С", "Autodata", "Autosoft", "Нет", "Другая"
    ].each do |s|
      ControlProgramm.create(name: s)
    end
  end

  task fix: :environment do
    opel    = CarBrand.find_by_name "Opel"
    ford    = CarBrand.find_by_name "Ford"
    renault = CarBrand.find_by_name "Renault"

    lite = CategoryAuto.find_by_name "Автобусы"
    lite.car_brands << renault
    lite.car_brands << ford
    lite.save

    lite = CategoryAuto.find_by_name "Средние и тяжелые грузовики"
    lite.car_brands << opel
    lite.car_brands << ford
    lite.save
  end

  task brand: :environment do
    CarBrand.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE car_brands RESTART IDENTITY")
    %w( Acura Alfa\ Romeo Aston\ Martin Audi BAW Bentley BMW Bogdan Brilliance Buick
        BYD Cadillac Chery Chevrolet Chrysler Citroen Dacia Daewoo Daihatsu Derways
        Dodge Dong\ Feng Doninvest FAW Fiat Ford Geely GMC Great\ Wall Haima Honda
        Hummer Hyundai Infiniti Iran\ Khodro Isuzu JAC Jaguar Jeep Kia Lancia Land\ Rover
        LDV Lexus Lifan Lincoln Mazda Mercedes-Benz Mini Mitsubishi Nissan Peugeot Plymouth
        Pontiac Porsche Renault Rolls\ Royce Rover SAAB Seat Skoda Smart SsangYong Subaru
        Suzuki Toyota Volkswagen Volvo Vortex ВАЗ ГАЗ ЗАЗ ИЖ ЛуАЗ Москвич СеАЗ ТагАЗ).each do |s|
      cb = CarBrand.create(name: s)
      lite = CategoryAuto.find_by_name "Легковые"
      lite.car_brands << cb
      lite.save
    end

    files = Dir.glob('/home/zaglohla/static/autodata/reformatted/*.xml')
    for file in files
      xml = Nokogiri::XML(open file)
      producers = xml.xpath("//producer")
      producers.each do |p|
        br = p.attr("value")
        unless CarBrand.find_by_name(br)
          cb = CarBrand.create(name: br)
          lite = CategoryAuto.find_by_name "Легковые"
          lite.car_brands << cb
          lite.save
        end
      end
    end

    files = Dir.glob('/home/zaglohla/static/autodata/reformatted-2/*.xml')
    for file in files
      xml = Nokogiri::XML(open file)
      producers = xml.xpath("//producer")
      producers.each do |p|
        br = p.attr("value")
        unless CarBrand.find_by_name(br)
          cb = CarBrand.create(name: br)
          lite = CategoryAuto.find_by_name "Легковые"
          lite.car_brands << cb
          lite.save
        end
      end
    end

  end

  task rus_brand: :environment do
    CarBrand.all.each do |c|
      if c.name.match /[А-Яа-я]/
        c.local_brand = true
        c.save
      end
    end
  end

  task metro: :environment do
    [ "Автово", "Адмиралтейская", "Академическая", "Балтийская", "Бухарестская",
      "Василеостровская", "Владимирская", "Волковская", "Выборгская", "Горьковская",
      "Гостиный двор", "Гражданский проспект", "Девяткино", "Достоевская", "Елизаровская",
      "Звёздная", "Звенигородская", "Кировский завод", "Комендантский проспект",
      "Крестовский остров", "Купчино", "Ладожская", "Ленинский проспект", "Лесная",
      "Лиговский проспект", "Ломоносовская", "Маяковская", "Международная", "Московская",
      "Московские ворота", "Нарвская", "Невский проспект", "Новочеркасская", "Обводный канал",
      "Обухово", "Озерки", "Парк Победы", "Парнас", "Петроградская", "Пионерская",
      "Площадь Александра Невского", "Площадь Восстания", "Площадь Ленина", "Площадь Мужества",
      "Политехническая", "Приморская", "Пролетарская", "Проспект Большевиков", "Проспект Ветеранов",
      "Проспект Просвещения", "Пушкинская", "Рыбацкое", "Садовая", "Сенная площадь",
      "Спасская", "Спортивная", "Старая деревня", "Технологический институт", "Удельная",
      "Улица Дыбенко", "Фрунзенская", "Чёрная речка", "Чернышевская", "Чкаловская", "Электросила"
    ].each do |s|
      MetroStation.create(name: s, city_id: 1)
    end
  end

  task car: :environment do
    brands = {
      "Renault" => [ "Logan", "Lagoona", "Megane" ],
      "Opel"    => [ "Zafira", "Record", "Asona"],
      "Ford"    => [ "Focus", "Scorpio", "Ka", "Sierra" ]
    }
    brands.keys.each do |b|
      brand = CarBrand.find_by_name(b)
      brands[b].each do |m|
        model = CarModel.create(name: m, car_brand_id: brand.id)
        4.times do |y|
          generation = CarGeneration.create name: (1985..2013).to_a.sample, car_model_id: model.id
          ["1.2", "1.4", "1.6", "1.6i", "1.4 TSI", "2.0"].each do |e|
            CarEngine.create(name: e, car_generation_id: generation.id)
          end
        end
      end
    end
  end

  desc "Run Test Import"
  task reseed: :environment do |t|
    puts "Users count: #{User.count}"
    User.destroy_all

    30.times do
      User.create! email: Faker::Internet.email, password: Devise.friendly_token[0, 20],
        name: Faker::NameRU.name, phone: Faker::PhoneNumber.phone_number, city: City.first,
        rating: rand(0..100), avatar: "http://lorempixel.com/500/500/"
    end

    puts "Reseed Success"
    puts "Users count: #{User.count}"

    users = User.all

    puts "Reseed Thanks"
    UserThank.destroy_all
    users.each do |u|
      rand(0..6).times do
        u.thanks << users.sample
      end
      u.save
    end
    puts "Reseed Success"
    puts "Thanks count: #{UserThank.count}"

    puts "Cto count: #{Cto.count}"
    Cto.destroy_all

    10.times do
      Cto.create! email: Faker::Internet.email, city: City.first, name: Faker::Company.name,
        description: Faker::Lorem.sentences(3).join(" "), logo: "http://lorempixel.com/500/500/",
        adress_street: Faker::Address.street_name, adress_buildng: Faker::Address.building_number
    end
    puts "Reseed Success"
    puts "Post count: #{Cto.count}"

    ctos = Cto.all

    puts "UserCtoFav count: #{UserCtoFav.count}"
    UserCtoFav.destroy_all
    users.each do |u|
      rand(0..4).times do
        u.cto_favs << ctos.sample
      end
      u.save
    end
    puts "Reseed Success"
    puts "UserCtoFav count: #{UserCtoFav.count}"

    engines = CarEngine.all

    puts "Cars count: #{Car.count}"
    Car.destroy_all
    users.each do |u|
      rand(0..3).times do
        car = Car.create(user_id: u.id, category_type: "A", car_engine_id: engines.sample.id, year: rand(2006..2013),
          vin: Devise.friendly_token[0, 20])
        rand(1..5).times do
          Photo.create(imageable: car, pic: "http://lorempixel.com/500/500/")
        end
      end
    end

    puts "Question count: #{Question.count}"
    puts "Answer count: #{Answer.count}"
    100.times do
      question = Question.create topic: Faker::Lorem.sentence(rand(3..9)), body: Faker::Lorem.paragraph, car_engine_id: engines.sample.id,
                                 user_id: users.sample.id, email_notification: true
      rand(0..4).times do
        Answer.create question_id: question.id, user_id: users.sample.id, body: Faker::Lorem.paragraph(rand(1..4)), email_notification: true
      end
    end
    puts "Reseed Success"
    puts "Question count: #{Question.count}"
    puts "Answer count: #{Answer.count}"

    puts "Admin count: #{Administrator.count}"
    Administrator.destroy_all
    Administrator.create! email: "admin@zaglohla.ru", password: "123123123", acl: [ :ctos, :users, :questions, :administrators ]
    puts "Reseed Success"
    puts "Admin count: #{Administrator.count}"

  end
end
