import Foundation

extension UserinfoVC {
    internal func userTimezone(_ result: Result) {
        guard let timezone = result.location.timezone.offset else { return }
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "GMT" + timezone)
        localtime.text = formatter.string(from: currentDate) + " (GMT \(timezone.prefix(2)))"
    }
}
