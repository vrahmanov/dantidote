class Lowrider < Formula
    # ...
    desc "Schema registry"
    homepage "https://github.com/vrahmanov"
    version "0.0.2"
    head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
    on_macos do
        if Hardware::CPU.arm?
          #url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/helm.sh"
          url "https://gist.githubusercontent.com/vrahmanov/2dd662a6628f06dd5561428afa990582/raw/a14a82450765a912d7baf797bdeb5132b95925fa/brew_gist.sh"
          def install
            puts "inside install"
            puts %x(whoami)
            installer_script = "brew_gist.sh"
            bin.install installer_script
            # exec("#{prefix}/bin/#{installer_script}")
            system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
            # system "alias", "lowrider" ,"=", "#{prefix}/bin/#{installer_script}"
            # bin.install_symlink "#{prefix}/bin/#{installer_script}"
            bin.install_symlink "#{prefix}/bin/#{installer_script}" => "lowrider"
            # alias lowrider="/opt/homebrew/Cellar/lowrider/0.0.1/bin/helm.sh"
                        # # Move everything under #{libexec}/
                        # libexec.install Dir["*"]
                        # # Then write executables under #{bin}/
                        # bin.write_exec_script (libexec/"test.sh")
          end
        end
      end
end