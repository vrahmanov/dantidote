class Kport < Formula
  depends_on "kubent"
  depends_on "kubectx"
  depends_on "kubent"
  # ...
  homepage "https://github.com/vrahmanov"
  version "0.0.2"
  head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
  desc "A small tap 🐐 to show depracations in specific context and version :-)"
  on_macos do
      if Hardware::CPU.arm?
        url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/kport.sh"
        def install
          puts "use with kport --version TARGET_VERSION --type CONTEXT_NAME "
          puts %x(whoami)
          installer_script = "kport.sh"
          bin.install installer_script
          system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
          bin.install_symlink "#{prefix}/bin/#{installer_script}" => "kport"
        end
      end
    end
end