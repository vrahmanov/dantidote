
class 50Cheat < Formula
    # ...
    desc "50Cheat"
    homepage "https://github.com/vrahmanov"
    version "0.0.2"
    # head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
    on_macos do
        if Hardware::CPU.arm?
          url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/50cheat.sh"
          def install
            puts "inside install"
            puts %x(whoami)
            installer_script = "50cheat.sh"
            bin.install installer_script
            system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
            bin.install_symlink "#{prefix}/bin/#{installer_script}" => "50cheat"
          end
        end
      end
end