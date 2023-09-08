
class Bumb < Formula
    # ...
    desc "BackUp my brew"
    homepage "https://github.com/vrahmanov"
    version "0.0.2"
    desc "A small tap 🐐 backing up your brew to ~/BUMBBrewfile"
    # head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
    on_macos do
        if Hardware::CPU.arm?
          url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/bumb.sh"
          def install
            puts "inside install"
            puts "A small tap 🐐 backing up your brew to ~/BUMBBrewfile"
            puts %x(whoami)
            installer_script = "bumb.sh"
            bin.install installer_script
            system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
            bin.install_symlink "#{prefix}/bin/#{installer_script}" => "bumb"
          end
        end
      end
end