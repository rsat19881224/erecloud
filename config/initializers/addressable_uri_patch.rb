module Addressable
  class URI
    def self.trail_slash(base_uri)
      parse(base_uri).trail_slash.to_s
    end

    def trail_slash
      dup.trail_slash!
    end

    def trail_slash!
      self.path = path && path.sub(/\/$/, '') + SLASH
      self
    end
  end
end
