module RssMockHelper
  def rss_mock_enable(resource:)
    # NOTE: Feedのclientをattribute定義したので、それを差し替えるようにしても良いかもしれない。
    allow_any_instance_of(Feed::Rss::Client).to receive(:resource).and_return(resource)
  end
end
