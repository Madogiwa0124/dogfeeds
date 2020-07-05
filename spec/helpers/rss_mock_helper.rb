module RssMockHelper
  def rss_mock_enable(endpoint:, body:, status: 200)
    WebMock.enable!
    WebMock.stub_request(:get, endpoint).to_return(
      body: body,
      status: status,
      headers: { 'Content-Type' => 'application/rss+xml' }
    )
  end
end
