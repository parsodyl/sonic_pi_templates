use_bpm 62
use_debug false
live_loop :dub do
  with_synth :blade do
    with_fx :reverb, amp: 2 do
      with_fx :echo, phase: 0.5, max_phase: 2, mix: 0.1 do
        8.times do
          sleep 0.25
          play_chord chord(:e3, :minor), cutoff: 90, release: 0.25
          sleep 0.25
        end
        8.times do
          sleep 0.25
          play_chord chord(:b2, :minor), cutoff: 90, release: 0.25
          sleep 0.25
        end
      end
    end
  end
end

live_loop :dub2 do
  #sync :dub
  #stop
  with_synth :chiplead do
    with_fx :reverb, amp: 3.5 do
      with_fx :echo, phase: 0.25, decay: 3, max_phase: 4, mix: 0.1 do
        4.times do
          sleep 0.5
          play_chord chord(:e4, :minor), release: 0.25
          sleep 0.5
        end
        4.times do
          sleep 0.5
          play_chord chord(:b3, :minor), release: 0.25
          sleep 0.5
        end
      end
    end
  end
end

live_loop :beat do
  #sync :dub
  #stop
  sample :bd_klub, amp: 2
  sample :bd_tek, amp: 2
  sleep 0.5
end

live_loop :hh do
  #sync :dub
  #stop
  with_fx :slicer, phase: 0.75, wave: 1, mix: 0.75 do
    sample :loop_industrial, beat_stretch: 2, amp: 0.75
    sleep 2
  end
end

live_loop :ff do
  #sync :dub
  #stop
  with_fx :reverb, amp: 0.9 do
    sleep 0.5
    sample :drum_cymbal_closed, release: 0.2
    sleep 0.25
    sample :drum_cymbal_closed, release: 0.2
    sleep 0.25
    sleep 1
  end
end

live_loop :bass do
  #sync :dub
  #stop
  use_synth :square
  8.times do
    play :e2, amp: rrand(1.5,2), cutoff: 55, release: 0.85
    sleep 0.5
  end
  8.times do
    play :b1, amp: rrand(1.5,2), cutoff: 55, release: 0.85
    sleep 0.5
  end
end

live_loop :melody do
  #sync :dub
  #stop
  use_synth_defaults amp: 0.5
  with_synth :piano do
    with_fx :reverb, amp: 0.85 do
      with_fx :slicer, phase: 0.75, wave: 3, mix: 0.75 do
        with_fx :echo, phase: 0.250, decay: 3, max_phase: 4, mix: 0.5 do
          play_pattern_timed (scale :e4, :aeolian).shuffle, [0.5], amp: 1.5, pan: -0.4
          play_pattern_timed (scale :b3, :aeolian).shuffle, [0.5], amp: 1.5, pan: +0.4
        end
      end
    end
  end
end