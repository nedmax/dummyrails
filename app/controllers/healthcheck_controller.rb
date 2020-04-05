class HealthcheckController < ActionController::Base
  def healthcheck
    article = Article.last
    render plain: "Running nice and smooth. Last article: #{article.created_at}"
  end
end
