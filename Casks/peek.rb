cask "peek" do
  version "0.3.6"
  sha256 "ed067bca3c62125bf34c06fcd44d9b6666d180f874aac7ee2e93def409e13b48"

  url "https://github.com/rsdrahat/peek/releases/download/v#{version}/peek-v#{version}.zip"
  name "peek"
  desc "Light, native macOS markdown viewer"
  homepage "https://github.com/rsdrahat/peek"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "peek.app"
  # Point at the shim (not the raw binary) so argv[0] resolves back to
  # the .app via readlink and SwiftPM's Bundle.module can locate resources.
  binary "#{appdir}/peek.app/Contents/MacOS/peek-cli", target: "peek"

  # Re-register the upgraded bundle with Launch Services. Without this,
  # macOS can keep serving the pre-upgrade icon (blank square in the Dock)
  # and routing file args based on the old Info.plist's CFBundleDocumentTypes
  # until the user reboots or kills the Dock. `brew upgrade` swaps the .app
  # in place but does not notify LS on its own.
  postflight do
    system "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister",
           "-f", "#{appdir}/peek.app"
  end

  zap trash: [
    "~/Library/Preferences/dev.peek.app.plist",
    "~/Library/Saved Application State/dev.peek.app.savedState",
  ]
end
