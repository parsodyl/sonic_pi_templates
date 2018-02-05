live_loop :ch do
  use_synth :sine
  with_fx :gverb, mix: 0.4 do
    with_fx :flanger, depth: 4 do
      8.times do
        sleep 0.25
        play_chord chord(:f4, :major7), cutoff: 30, release: 0.11
        sleep 0.25
      end
      8.times do
        sleep 0.25
        play_chord chord(:d4, :major), cutoff: 30, release: 0.11
        sleep 0.25
      end
    end
  end
end
