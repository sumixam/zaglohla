SitemapGenerator::Sitemap.default_host = "http://zaglohla.ru"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  Cto.where(show_on_site: true).each do |cto|
    add "/ctos/#{cto.id}", lastmod: cto.updated_at, changefreq: 'weekly'
  end
  Question.where(visible: true).each do |question|
    add "/questions/#{question.id}", lastmod: question.updated_at, changefreq: 'weekly'
  end
  Page.where(visible: true).each do |page|
    add "/wikis/#{page.id}", lastmod: page.updated_at, changefreq: 'weekly'
  end
end
