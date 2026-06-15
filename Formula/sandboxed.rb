class Sandboxed < Formula
  desc "Run command-line tools inside disposable project containers"
  homepage "https://github.com/Kirill-Znamenskiy/sandboxed"
  url "https://github.com/Kirill-Znamenskiy/sandboxed/archive/refs/tags/v0.0.5.tar.gz"
  version "0.0.5"
  sha256 "c124bbbcae45a2cac5f6b88057d17d123f23d34e803c603f829895d5877b26a8"
  license "MIT"

  head "https://github.com/Kirill-Znamenskiy/sandboxed.git", branch: "dev"

  depends_on "python"

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  def install
    libexec.install "src", "targets"

    # The launcher only needs PyYAML's pure-Python safe_load/safe_dump path.
    resource("pyyaml").stage do
      (libexec/"vendor").install "lib/yaml", "lib/_yaml"
    end

    ["sandboxed", "sbxd"].each do |command_name|
      (bin/command_name).write <<~SH
        #!/bin/bash
        export SANDBOXED_HOME="#{libexec}"
        export SANDBOXED_PYTHON="#{Formula["python"].opt_bin}/python3"
        export PYTHONPATH="#{libexec}/vendor${PYTHONPATH:+:$PYTHONPATH}"
        exec "#{libexec}/src/sandboxed.sh" "$@"
      SH
      chmod 0755, bin/command_name
    end
  end

  test do
    output = shell_output("#{bin}/sandboxed --just-print=config opencode")
    assert_match "target: opencode", output
    assert_match "targets/opencode/compose.yaml", output
  end
end
