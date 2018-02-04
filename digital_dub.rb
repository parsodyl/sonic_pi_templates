live_loop :skank do
  with_synth :prophet do
    with_fx :reverb, amp: 3 do
      with_fx :echo, phase: 0.75, max_phase: 2, decay: 1, mix: 0.4 do
        3.times do
          sleep 0.5
          play_chord chord(:e4, :minor), amp: 0.6, cutoff: 85, release: 0.20
          sleep 0.5
        end
        1.times do
          sleep 0.5
          play_chord chord(:b3, :minor), amp: 0.6, cutoff: 85, release: 0.20
          sleep 0.5
        end
      end
    end
  end
end

live_loop :chiptune do
  #sync :skank
  #stop
  with_synth :chipbass do
    play chord(:e4, :minor)[0], amp: rrand(0.06, 0.09)*1.5
    sleep 0.250
    play chord(:e3, :minor)[0], amp: rrand(0.06, 0.09)*1.5
    sleep 0.250
    play chord(:e4, :minor)[1], amp: rrand(0.06, 0.09)*1.5
    sleep 0.250
    play chord(:e3, :minor)[2], amp: rrand(0.06, 0.09)*1.5
    sleep 0.250
  end
end

live_loop :beat do
  #sync :skank
  #stop
  sample :bd_klub, amp: 1
  sample :bd_tek, amp: 1
  sleep 1-0.125
  #sample :bd_klub, amp: 0.7
  #sample :bd_tek, amp: 0.7
  sleep 0.125
  sample :sn_zome, amp: 1
  sample :bd_tek, amp: 1
  sleep 1
end

live_loop :hh do
  #sync :skank
  #stop
  sleep 0.25
  sample :drum_cymbal_closed, cutoff: 95, beat_stretch: 0.22, amp: 0.53
  sleep 0.125
  sample :drum_cymbal_closed, cutoff: 95, beat_stretch: 0.22, amp: 0.55
  sleep 0.125
  sleep 0.25
  sample :drum_cymbal_pedal, beat_stretch: 0.22, amp: 0.7
  sleep 0.25
end

# WOBBLE BASS
define :wob do |note, no_of_wobs, duration, vol|
  # using in_thread so we don't block everything
  in_thread do
    use_synth :subpulse
    lowcut = note(:E1) # ~ 40Hz
    highcut = note(:E6) # ~ 3000Hz
    
    duration = duration.to_f || 2.0
    bpm_scale = (60 / current_bpm).to_f
    distort = 0.2
    
    # scale the note length based on current tempo
    slide_duration = duration * bpm_scale
    
    # Distortion helps give crunch
    with_fx :distortion, distort: distort do
      
      # rlpf means "Resonant low pass filter"
      with_fx :rlpf, cutoff: lowcut, cutoff_slide: slide_duration do |c|
        play note, amp: vol, attack: 0, sustain: duration, release: 0
        
        c.ctl cutoff_slide: ((duration / no_of_wobs.to_f) / 2.0)
        
        # Playing with the cutoff gives us the wobble!
        # low cutoff    -> high cutoff        -> low cutoff
        # few harmonics -> loads of harmonics -> few harmonics
        # wwwwwww -> oooooooo -> wwwwwwww
        #
        # N.B.
        # * The note is always the same length *
        # * the no_of_wobs just specifies how many *
        # * 'wow's we fit in that space *
        no_of_wobs.times do
          c.ctl cutoff: highcut
          sleep ((duration / no_of_wobs.to_f) / 2.0)
          c.ctl cutoff: lowcut
          sleep ((duration / no_of_wobs.to_f) / 2.0)
        end
      end
    end
  end
end

live_loop :bass do
  #sync :skank
  #stop
  6.times do
    wob(:e2, 2, 0.25, 0.4)
    sleep 0.25
  end
  1.times do
    wob(:e1, 1, 0.25, 0.4)
    sleep 0.25
  end
  1.times do
    wob(:b1, 1, 0.25, 0.4)
    sleep 0.25
  end
end

live_loop :bass2 do
  #sync :skank
  #stop
  use_synth :subpulse
  6.times do
    play :e2, amp: rrand(1.75,2)*2.5, pitch: rrand(0,0.1), cutoff: 50, release: 0.2
    sleep 0.25
  end
  1.times do
    play :e1, amp: rrand(1.75,2)*2.5, pitch: rrand(0,0.1), cutoff: 50, release: 0.3
    sleep 0.25
  end
  1.times do
    play :b1, amp: rrand(1.75,2)*2.5, pitch: rrand(0,0.1), cutoff: 50, release: 0.25
    sleep 0.25
  end
end
