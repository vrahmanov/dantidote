class Whiterabbit < Formula
  # ...
  homepage "https://github.com/vrahmanov"
  version "0.0.2"
  head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
  desc "A small tap 🐐 for pure matrix view"
  on_macos do
      if Hardware::CPU.arm?
        url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/whiterabbit.sh"
        def install
          puts "inside install"
          puts %x(whoami)
          installer_script = "whiterabbit.sh"
          bin.install installer_script
          system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
          bin.install_symlink "#{prefix}/bin/#{installer_script}" => "whiterabbit"
        end
      end
    end
end