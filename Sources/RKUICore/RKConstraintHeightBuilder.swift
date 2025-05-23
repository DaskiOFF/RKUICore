import Foundation
import UIKit

@available(iOS 9, *)
class RKConstraintHeightBuilder: RKConstraintBaseBuilder<NSLayoutDimension>, RKConstraintBuilder {

    // MARK: - RKConstraintBuilder
    func build(withView view: UIView, isActive: Bool) -> RKConstraint {
        let baseAnchor = view.heightAnchor
        let constraint: RKConstraint
        if let anchor = self.anchor {
            switch relation {
            case .equal:
                constraint = baseAnchor.constraint(equalTo: anchor, multiplier: value)
            case .lessThanOrEqual:
                constraint = baseAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: value)
            case .greaterThanOrEqual:
                constraint = baseAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: value)
            @unknown default:
                fatalError()
            }
        } else {
            switch relation {
            case .equal:
                constraint = baseAnchor.constraint(equalToConstant: value)
            case .lessThanOrEqual:
                constraint = baseAnchor.constraint(lessThanOrEqualToConstant: value)
            case .greaterThanOrEqual:
                constraint = baseAnchor.constraint(greaterThanOrEqualToConstant: value)
            @unknown default:
                fatalError()
            }
        }

        return constraint.set(priority: priority).set(active: self.isActive && isActive)
    }
}
