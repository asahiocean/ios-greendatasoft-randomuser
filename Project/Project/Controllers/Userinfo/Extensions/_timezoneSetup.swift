import Foundation

extension UserinfoVC {
    internal func _timezoneSetup(_ result: Result) {
        if let tz = result.location.timezone.offset {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone(identifier: "GMT" + tz)
            localtime.text = formatter.string(from: currentDate) + " (GMT \(tz.prefix(2)))"
        }
    }
}
