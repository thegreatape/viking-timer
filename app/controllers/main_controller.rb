class MainController < UIViewController
  SNATCH_SOUND_ID = 1007
  SWITCH_SOUND_ID = 1008

  attr_accessor :current_timer
  def viewDidLoad
    super

    # Sets a top of 0 to be below the navigation control
    self.edgesForExtendedLayout = UIRectEdgeNone
    self.title = "CMV02 Test Timer"

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    rmq.append(UIButton, :go).on(:tap) do
      start_timer
    end

    rmq.append(UIButton, :stop).on(:tap) do
      stop_timer
    end
  end

  def start_timer
    self.current_timer = NSTimer.scheduledTimerWithTimeInterval(interval, target:self, selector: :tick, userInfo: {}, repeats:true)
  end

  def stop_timer
    self.current_timer.invalidate
    @elapsed = 0.0
    rmq(:go).style do |st|
      st.text = "GO"
    end
  end

  def interval
    0.1
  end

  def tick
    @elapsed ||= 0.0
    @elapsed += interval
    rmq(:go).style do |st|
      st.text = @elapsed.round(1).to_s
    end

    play_sounds
    true
  end

  def play_sounds
    {
      (0.0..60.0) => 6.0,
      (60.0..120.0) => 4.2,
      (120.0..180.0) => 3.3,
      (180.0..240.0) => 2.7
    }.each do |range, interval|
      if range.cover? @elapsed
        if @elapsed.modulo(60.0).round(1) == 0.1.round(1)
          return switch_hands
        elsif @elapsed.modulo(interval).round(1) == 0.1.round(1)
          return beep
        end
      end
    end
  end

  def switch_hands
    AudioServicesPlaySystemSound(SWITCH_SOUND_ID)
  end

  def beep
    AudioServicesPlaySystemSound(SNATCH_SOUND_ID)
  end
end
