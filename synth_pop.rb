use_debug false
live_loop :beat do
  4.times do
    sample :bd_fat
    sleep 0.25
    sample :bd_fat
    sample :drum_cymbal_pedal, amp: 0.3
    sleep 0.25
    with_fx :reverb, mix: 0.2 do
      sample :sn_dolf, amp: 0.8
    end
    sleep 0.25
    sample :drum_cymbal_pedal, amp: 0.35
    sleep 0.25
    
  end
end
live_loop :bass do
  use_synth :square
  16.times do
    play chord(:c2, :minor7)[0], release: 0.1, amp: 1.5
    sleep 0.25
  end
  8.times do
    play chord(:c2, :minor7)[1], release: 0.1, amp: 1.5
    sleep 0.25
  end
  8.times do
    play chord(:c2, :minor7)[2], release: 0.1, amp: 1.5
    sleep 0.25
  end
end
live_loop :melody do
  use_synth :blade
  play_pattern_timed chord(:c4, :minor7).shuffle, 0.25, amp: 0.3
end
live_loop :efx do
  with_fx :tanh do
    4.times do
      use_synth :fm
      play :c3, amp: 0.7, cutoff: 53
      sleep 1
    end
    4.times do
      use_synth :fm
      play :ds3, amp: 0.7, cutoff: 55
      sleep 1
    end
  end
end
