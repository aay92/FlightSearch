import UIKit

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.day], from: self).day
    }
}
