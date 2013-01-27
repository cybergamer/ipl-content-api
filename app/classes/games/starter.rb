module Games
  class Starter

    def start(target)
      target.update_attributes({:starts_at => Time.now})
    end

  end
end