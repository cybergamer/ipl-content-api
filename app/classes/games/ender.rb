module Games
  class Ender

    def end(target)
      target.update_attributes({:ends_at => Time.now})
    end

  end
end