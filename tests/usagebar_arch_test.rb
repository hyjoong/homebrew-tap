# frozen_string_literal: true

# Run with `brew ruby tests/usagebar_arch_test.rb`.
# Only hardware discovery is replaced: the cask DSL and installer check are real.
# No application download or installation is performed.
require "cask/cask_loader"
require "cask/installer"

source = File.read(File.expand_path("../Casks/usagebar.rb", __dir__))
cases = [
  { name: "native Apple Silicon is accepted", type: :arm, bits: 64, rosetta: false, accepted: true },
  { name: "Rosetta Homebrew on Apple Silicon is accepted", type: :intel, bits: 64, rosetta: true, accepted: true },
  { name: "Intel hardware is rejected", type: :intel, bits: 64, rosetta: false, accepted: false },
]

# Homebrew prepends its macOS CPU methods, so prepend the simulation as well.
simulation = Module.new
Hardware::CPU.singleton_class.prepend(simulation)
failures = 0

begin
  cases.each do |test_case|
    simulation.define_method(:type) { test_case.fetch(:type) }
    simulation.define_method(:bits) { test_case.fetch(:bits) }
    simulation.define_method(:in_rosetta2?) { test_case.fetch(:rosetta) }

    observed = [Hardware::CPU.type, Hardware::CPU.bits, Hardware::CPU.in_rosetta2?]
    expected = test_case.values_at(:type, :bits, :rosetta)
    raise "CPU simulation failed for #{test_case.fetch(:name)}: #{observed.inspect}" unless observed == expected

    # Reload for every case so architecture-dependent DSL is evaluated anew.
    cask = Cask::CaskLoader.load(source)
    rejection = nil
    begin
      Cask::Installer.new(cask).check_arch_requirements
    rescue Cask::CaskError => e
      rejection = e
    end

    accepted = rejection.nil?
    if accepted == test_case.fetch(:accepted)
      puts "PASS: #{test_case.fetch(:name)}"
    else
      failures += 1
      warn "FAIL: #{test_case.fetch(:name)} (#{rejection&.message || "incorrectly accepted"})"
    end
  end
ensure
  simulation.instance_methods(false).each { |method| simulation.remove_method(method) }
end

abort "#{failures} architecture regression test(s) failed" unless failures.zero?
puts "All #{cases.length} architecture regression tests passed."
