class Eminhelm < Formula
  depends_on "yq"
  depends_on "helm"
  depends_on "git"
  depends_on "jq"
  # ...
  homepage "https://github.com/vrahmanov"
  version "0.0.2"
  head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
  desc "A small tap 🐐 for helm chart version display (current vs latest)"
  on_macos do
      if Hardware::CPU.arm?
        url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/eminhelm.sh"
        def install
          puts "inside install"
          puts %x(whoami)
          installer_script = "eminhelm.sh"
          bin.install installer_script
          system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
          bin.install_symlink "#{prefix}/bin/#{installer_script}" => "eminhelm"
        end
      end
    end
end