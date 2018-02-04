use_debug false
use_bpm 68
live_loop :chrd do
  play :Ds5, amp: 0.05
  play :G5, amp: 0.05
  sleep 0.5
  play :C5, amp: 0.05
  sleep 0.5
end
live_loop :chrd2 do
  play :Ds4, amp: 0.2
  play :G4, amp: 0.2
  sleep 0.5
  play :C4, amp: 0.2
  sleep 0.5
end

live_loop :bass do
  use_synth :fm
  #sync :chrd
  stop
  play :C3, amp: 2, release: 2
  sleep 2
  play :As2, amp: 1.5, release: 2
  sleep 2
  play :Gs2, amp: 1.5, release: 2
  sleep 2
  play :Eb2, amp: 1.4, release: 2
  sleep 2
end

live_loop :strings do
  with_synth :prophet do
    with_fx(:reverb, room: 0.9, mix: 0.4) do
      #sync :bass
      #stop
      play :C5, amp: 0.5, release: 0.5, cutoff: 75+5
      sleep 0.5
      play :As4, amp: 0.5, release: 0.5, cutoff: 75+5
      sleep 0.5
      play :Gs4, amp: 0.5, release: 0.5, cutoff: 75+5
      sleep 0.5
      play :Eb4, amp: 0.5, release: 0.5, cutoff: 75+5
      sleep 0.5
    end
  end
end

live_loop :beat do
  use_bpm 68*2
  #sync :bass
  #stop
  sample :bd_klub, amp: 2
  sample :bd_tek, amp: 2
  sleep 2
  sample :sn_dolf, amp: 1.5, cutoff: 110
  sleep 2
  sample :bd_klub, amp: 2
  sample :bd_tek, amp: 2
  sleep 1
  sample :bd_klub, amp: 2
  sample :bd_tek, amp: 2
  sleep 1
  sample :sn_dolf, amp: 1.5, cutoff: 110
  sleep 2-0.25
  sample :bd_klub, amp: 0.65
  sample :bd_tek, amp: 0.65
  sleep 0.25
end

live_loop :groove do
  #sync :bass
  #stop
  with_fx :slicer, phase: 0.5, wave: 2, mix: 0.75 do
    sample :loop_amen, beat_stretch: 4, amp: 1.4
    sleep 4
  end
end

live_loop :hithat do
  #sync :bass
  #stop
  sample :drum_cymbal_closed, amp: 0.2*0.65, rate: 1.2
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.4*0.65, rate: 1.2
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.15*0.65, rate: 1.2
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.45*0.65, rate: 1.2
  sleep 0.25
end

live_loop :tron do
  #sync :bass
  #stop
  with_synth :blade do
    with_fx(:reverb, room: 0.5, mix: 0.3) do
      play :C5, amp: 4, release: 4, note_slide: 4, cutoff: 70, cutoff_slide: 8, detune: rrand(0, 0.2)
      sleep 4
      play :Ds5, amp: 4, release: 3, note_slide: 4, cutoff: 70, cutoff_slide: 8, detune: rrand(0, 0.2)
      sleep 2
      play :G5, amp: 4, release: 3, note_slide: 4, cutoff: 70, cutoff_slide: 8, detune: rrand(0, 0.2)
      sleep 2
    end
  end
end

# Defining standalone wobble

# WOBBLE BASS
define :wob do |note, no_of_wobs, duration, vol|
  # using in_thread so we don't block everything
  in_thread do
    use_synth :dsaw
    lowcut = note(:E1) # ~ 40Hz
    highcut = note(:G8) # ~ 3000Hz
    
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


# first arg is the midi note,
# second is the number
#   of wobs you want to fit in that note
# third is note duration


live_loop :wooble do
  #sync :bass
  stop
  wob(36, 2, 2, 0.8)
  sleep 2
  wob(36+3, 8, 2, 0.8)
  sleep 2
  wob(36+3+4, 6, 2, 0.8)
  sleep 2
  wob(36, 16, 2, 0.8)
  sleep 2
end

live_loop :wooble2 do
  #sync :bass
  stop
  wob(48, 2*4, 2, 0.5*2/3)
  sleep 2
  wob(48+3, 8*4, 2, 0.5*2/3)
  sleep 2
  wob(48+3+4, 6*4, 2, 0.5*2/3)
  sleep 2
  wob(48, 16*4, 2, 0.5*2/3)
  sleep 2
end

