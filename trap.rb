use_bpm 134

live_loop :ciao do
  sample :bd_808, amp: 2
  sample :bd_boom, amp: 2.5
  sleep 2
  sample :sn_zome, rate: 1.8, release: 0.35
  sleep 3
  sample :bd_808, amp: 2
  sample :bd_boom, amp: 2.5
  sleep 1
  sample :sn_zome, rate: 1.8, release: 0.35
  sleep 0.5
  sample :bd_808, amp: 2
  sample :bd_boom, amp: 2.5
  sleep 1.5
end

live_loop :mondo do
  4.times do
    sample :tabla_dhec, rate: 2.9, amp: 0.15
    sleep 0.5
  end
  8.times do
    sample :tabla_dhec, rate: 2.9, amp: 0.15
    sleep 0.25
  end
end

live_loop :bleed do
  use_synth :dpulse
  play_pattern_timed scale(:b4, :minor).reverse, [0.5], release: 0.3, amp: 0.2
  play_pattern_timed scale(:b4, :minor), [0.25], release: 0.3, amp: 0.2
  play_pattern_timed scale(:b4, :minor), [0.25], release: 0.3, amp: 0.2
end

live_loop :caos do
  use_synth :chiplead
  play_chord chord(:d4, :add13), amp: 0.7, release: 4
  sleep 8
  play_chord chord(:b3, :add13), amp: 0.7, release: 4
  sleep 8
end
