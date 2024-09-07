require 'fileutils'

def log_warning(message)
  puts "[Permissions] #{message}"
end

def setup_permissions(config)
  if config.nil? || !config.is_a?(Array)
    return log_warning("Invalid config argument")
  end

  permissions_frameworks = {
    'AppTrackingTransparency' => ['AdSupport', 'AppTrackingTransparency'],
    'Bluetooth' => ['CoreBluetooth'],
    'Calendars' => ['EventKit'],
    'CalendarsWriteOnly' => ['EventKit'],
    'Camera' => ['AVFoundation'],
    'Contacts' => ['Contacts'],
    'FaceID' => ['LocalAuthentication'],
    'LocationAccuracy' => ['CoreLocation'],
    'LocationAlways' => ['CoreLocation'],
    'LocationWhenInUse' => ['CoreLocation'],
    'MediaLibrary' => ['MediaPlayer'],
    'Microphone' => ['AVFoundation'],
    'Motion' => ['CoreMotion'],
    'Notifications' => ['UserNotifications'],
    'PhotoLibrary' => ['Photos', 'PhotosUI'],
    'PhotoLibraryAddOnly' => ['Photos'],
    'Reminders' => ['EventKit'],
    'Siri' => ['Intents'],
    'SpeechRecognition' => ['Speech'],
    'StoreKit' => ['StoreKit']
  }

  module_dir = File.expand_path('..', __dir__)
  ios_dir = File.join(module_dir, 'ios')
  ios_dirents = Dir.entries(ios_dir).map { |entry| File.join(ios_dir, entry) }

  directories = ios_dirents
    .select { |entry| File.directory?(entry) || entry.end_with?('.xcodeproj') }
    .map { |entry| File.basename(entry) }
    .select { |name| config.include?(name) }

  unknown_permissions = config.reject { |name| directories.include?(name) }

  unless unknown_permissions.empty?
    log_warning("Unknown permissions: #{unknown_permissions.join(', ')}")
  end

  directories.each do |directory|
    source_files = [
      '"*.{h,mm}"',
      # other files
    ].join(', ')

    frameworks = (permissions_frameworks[directory] || [])
      .map { |name| "\"#{name}\"" }.join(', ')

    podspec_template_path = File.join(module_dir, 'setup', 'podspec.template')
    podspec_template = File.read(podspec_template_path)

    podspec_content = podspec_template
      .gsub(/(# *)?s\.name *=.*/, "s.name = \"Permission-#{directory}\"")
      .gsub(/(# *)?s\.source_files *=.*/, "s.source_files = #{source_files}")
      .gsub(/(# *)?s\.frameworks *=.*/,
        frameworks.length > 0 ?
        "s.frameworks = #{frameworks}" :
        '# s.frameworks = <frameworks>')
      .gsub(/(# *)?s\.resource_bundles *=.*/, 
        directory == 'FaceID' ? 
        "s.resource_bundles = { 'RNPermissionsPrivacyInfo' => 'ios/PrivacyInfo.xcprivacy' }" : 
        '# s.resource_bundles = <resource_bundles>')

    podspec_path = File.join(module_dir, "ios", directory, "Permission-#{directory}.podspec")
    File.write(podspec_path, podspec_content)
  end
end
