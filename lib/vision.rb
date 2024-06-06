require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def image_analysis(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['Vision_API_Key']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(image_file.tempfile.read)
      
      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: "SAFE_SEARCH_DETECTION"
            }
          ]
        }]
      }.to_json
      
      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      
      # レスポンスの解析とエラーハンドリング
      result = JSON.parse(response.body)
      # レスポンスが空かnilかをチェック
      if result["responses"].nil? || result["responses"].empty?
        Rails.logger.error("Vision API response is empty or nil")
        return false
      end
      # エラーハンドリング
      if (error = result["responses"][0]["error"]).present?
        Rails.logger.error("Vision API error: #{error['message']}")
        raise error["message"]
      else
        # レスポンスを解析して不適切な要素が含まれているかチェック
        result_arr = result["responses"].flatten.map do |parsed_image|
          parsed_image["safeSearchAnnotation"].values
        end.flatten
        if result_arr.include?("LIKELY") || result_arr.include?("VERY_LIKELY")
          false
        else
          true
        end
      end
    # JSONの解析中にエラーが発生した場合のエラーハンドリング
    rescue JSON::ParserError => e
      Rails.logger.error("JSON parsing error: #{e.message}")
      raise "JSON parsing error"
    rescue StandardError => e
      Rails.logger.error("Standard error: #{e.message}")
      raise e.message
    end
  end
end