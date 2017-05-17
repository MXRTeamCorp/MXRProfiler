Pod::Spec.new do |s|
  s.name         = "MXRProfiler"
  s.version      = "0.0.5"
  s.summary      = "A tool for monitor iPhone's performance"
  s.description  = <<-DESC
    A tool for monitor iPhone's performance, it can monitor app's memory, cpu, fps and so on.
                   DESC
  s.homepage     = "https://github.com/MXRTeamCorp/MXRProfiler.git"
  s.license      = "MIT"
  s.author    = { "MXRTeam" => "long.liu@mxrcorp.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/MXRTeamCorp/MXRProfiler.git", :tag => "#{s.version}" }
  s.source_files  = "MXRProfiler/**/*.{h,m}"
  s.requires_arc  = true
end
