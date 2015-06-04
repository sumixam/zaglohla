namespace :import do

  desc "Run Test Import"
  task test:  :environment do |t|
    CarModel.all.each { m.destroy }
    ActiveRecord::Base.connection.execute("TRUNCATE car_models")
    ActiveRecord::Base.connection.execute("TRUNCATE car_generations")
    ActiveRecord::Base.connection.execute("TRUNCATE car_engines")
    ActiveRecord::Base.connection.execute("TRUNCATE repair_costs")
    require 'nokogiri'
    require 'csv'
    files = Dir.glob("/home/zaglohla/static/autodata/reformatted/*.xml") + Dir.glob("/home/zaglohla/static/autodata/reformatted-2/*.xml")
    files.each do |file|
    csv_file = "#{Rails.root}/data/test-import-1.csv"
    ca = CategoryAuto.where name: "Легковые"
    CSV.open( csv_file, 'w' ) do |writer|
      writer << ["Производитель", "Модель", "Двигатель", "Поколение", "Начало производства", "Конец произовдства", "VIN"]
      xml = Nokogiri::XML(open file)
      producers = xml.xpath("//producer")
      producers.each do |p|
        models = p.xpath("model")
        models.each do |m|
          mname = m.attr("value").split(" (")[0]
          [" I", " II", " III", " IV", " V", " VI", " 1", " 2", " 3", " 4", " 5", " 6", " 7"].each do |n|
            mname.gsub!(n) if mname.end_with?(n)
          end
          engines = m.xpath("engine")
          engines.each do |e|
            puts e.attr("value")
            generations = e.xpath("engineCode")
            generations.each do |g|
              years = g.xpath("code").first.attr("productionPeriod")
              start, ends = years.split(" - ")
              sstms = g.xpath("data")
              unless sstms.present?
                postfix = " "+g.xpath("transmission").first.attr("value")
                sstms = g.xpath("transmission").xpath("data")
              else
                postfix = ""
              end
              writer << [p.attr("value"), mname, e.attr("value") + postfix, years, start, ends, g.xpath("code").first.attr("vin")]
              cb = CarBrand.where(name: p.attr("value")).first || CarBrand.create(name: p.attr("value"))
              cb.category_autos << ca
              cb.save
              cm = cb.car_models.where(name: mname).first || CarModel.create(name: mname, car_brand_id: cb.id)
              cg = cm.car_generations.where(name: years).first || CarGeneration.create(name: years, start: start, ends: ends, car_model_id: cm.id)
              ce = cg.car_engines.where(name: e.attr("value") + postfix).first || CarEngine.create(name: e.attr("value") + postfix, car_generation_id: cg.id)
              sstms.children.each do |s|
                puts s.attr("value")
                writer << ["", s.attr("value")]
                rws = RepairWorkSector.where(name: s.attr("value")).first || RepairWorkSector.create(name: s.attr("value"))
                subsytems = s.xpath("subsystem")
                subsytems.each do |ss|
                  writer << ["", "", ss.attr("value")]
                  rwt = RepairWorkType.where(name: ss.attr("value"), repair_work_sector_id: rws.id).first || RepairWorkType.create(name: ss.attr("value"), repair_work_sector_id: rws.id)
                  ss.children.each do |w|
                    time = w.xpath("time").first.attr("hours")
                    rwj = RepairWorkJob.where(name: w.attr("value"), repair_work_type_id: rwt.id).first || RepairWorkJob.create(name: w.attr("value"), repair_work_type_id: rwt.id)
                    writer << ["", "", "", w.attr("value"), "#{time} часов"]
                    if RepairCost.where(repair_work_type_id:rwt.id, repair_work_sector_id:rws.id, car_generation_id:cg.id, car_engine_id:ce.id, car_model_id:cm.id,  car_brand_id:cb.id).count == 0
                      RepairCost.create repair_work_type_id:rwt.id, repair_work_sector_id:rws.id, car_generation_id:cg.id, car_engine_id:ce.id, car_model_id:cm.id,  car_brand_id:cb.id, hours:time.gsub(",","."), repair_work_job_id: rwj.id
                    end
                    w.xpath("includes").children.each do |ww|
                      writer << ["", "", "", "", ww.attr("value")]
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    end
  end
end
