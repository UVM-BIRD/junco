module SearchHelper
  def build_link(nlm_id)
    "http://www.ncbi.nlm.nih.gov/nlmcatalog/?term=#{nlm_id}[nlmid]"
  end
end
