require 'fileutils'

PERMISSIONS_FRAMEWORKS = {
  'AppTrackingTransparency' => ['AdSupport', 'AppTrackingTransparency'],
  'Bluetooth' => ['CoreBluetooth'],
  'Calendars' => ['EventKit'],
  'CalendarsWriteOnly' => ['EventKit'],
  'Camera' => ['AVFoundation'],
  'Contacts' => ['Contacts'],
  'FaceID' => ['LocalAuthentication'],
  'LocationAccuracy' => ['CoreLocation'],
  'LocationAccuracyAppClip' => [],
  'LocationAlways' => ['CoreLocation'],
  'LocationAlwaysAppClip' => [],
  'LocationWhenInUse' => ['CoreLocation'],
  'LocationWhenInUseAppClip' => [],
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

def log_warning(message)
  puts "[Permissions] #{message}"
end

def setup_permissions(config)
  if config.nil? || !config.is_a?(Array) || config.empty?
    return log_warning("Invalid config argument (expected a non-empty Array)")
  end

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

  source_files = [
    '"ios/*.{h,mm}"',
    *directories.map { |name| "\"ios/#{name}/*.{h,mm}\"" }
  ].join(', ')

  frameworks = directories
    .reduce([]) do |acc, dir|
    arr = PERMISSIONS_FRAMEWORKS[dir]
    arr ? acc.concat(arr) : acc
  end
    .map { |name| "\"#{name}\"" }
    .uniq
    .join(', ')

  podspec_path = File.join(module_dir, 'RNPermissions.podspec')
  podspec = File.read(podspec_path)

  podspec_content = podspec
    .gsub(/(# *)?s\.source_files *=.*/, "s.source_files = #{source_files}")
    .gsub(/(# *)?s\.frameworks *=.*/, "s.frameworks = #{frameworks}")

  File.write(podspec_path, podspec_content)
end


def setup_target_permission(permission)
  if permission.nil? || !permission.is_a?(String)
    return log_warning("Invalid permission argument")
  end

  module_dir = File.expand_path('..', __dir__)
  ios_dir = File.join(module_dir, 'ios')
  ios_dirents = Dir.entries(ios_dir).map { |entry| File.join(ios_dir, entry) }

  directories = ios_dirents
    .select { |entry| File.directory?(entry) || entry.end_with?('.xcodeproj') }
    .map { |entry| File.basename(entry) }
    .select { |name| name == permission }

  if directories.empty?
    return log_warning("Unknown permission: #{permission}")
  end

  frameworks = directories
    .reduce([]) do |acc, dir|
    arr = PERMISSIONS_FRAMEWORKS[dir]
    arr ? acc.concat(arr) : acc
  end
    .map { |name| "\"#{name}\"" }
    .uniq
    .join(', ')

  podspec_template_path = File.join(module_dir, 'setup', 'podspec.template')
  podspec_template = File.read(podspec_template_path)

  podspec_content = podspec_template
    .gsub(/(# *)?s\.name *=.*/, "s.name = \"RNPermissions-#{permission}\"")
    .gsub(/(# *)?s\.source_files *=.*/, "s.source_files = \"#{permission}/*.{h,mm}\"")
    .gsub(/(# *)?s\.header_mappings_dir *=.*/, "s.header_mappings_dir = \"#{permission}\"")
    .gsub(/(# *)?s\.frameworks *=.*/, frameworks.length > 0 ? "s.frameworks = #{frameworks}" : '# s.frameworks = <frameworks>')

  podspec_path = File.join(module_dir, 'ios', "RNPermissions-#{permission}.podspec")
  File.write(podspec_path, podspec_content)
end