//  Copyright © 2016 Gavan Chan. All rights reserved.

import UIKit

final class WeatherViewController: UIViewController {

  @IBOutlet private weak var locationLabel: UILabel!
  @IBOutlet private weak var weatherInformationLabel: UILabel!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private var weatherView: WeatherView!

}

final class WeatherView: UIView {

  enum Theme {
    case blistering
    case hot
    case neutral
    case cold
  }

  override static var layerClass: AnyClass { return CAGradientLayer.self }

}

struct WeatherViewModel {

  private let data: Weather

  init(with data: Weather) {
    self.data = data
  }

  var location: City.Name { return data.city.name }

  var information: String { return String(format: "Current: %.1fºC", data.current) }

  var theme: WeatherView.Theme! {
    switch data.current {
    case let x where x >= 35.0: return .blistering
    case 25.0 ..< 35.0: return .hot
    case 18.0 ..< 25.0: return .neutral
    case let x where x < 18.0: return .cold
    default: return nil // This case should not be reached.
    }
  }

}

fileprivate extension WeatherView.Theme {
  var gradientColors: (top: UIColor, bottom: UIColor) {
    switch self {
    case .blistering:
      return (.init(rgb: (254, 229, 207)), .init(rgb: (253, 191, 132)))
    case .hot:
      return (.init(rgb: (254, 212, 171)), .init(rgb: (255, 240, 233)))
    case .neutral:
      return (.init(rgb: (226, 232, 254)), .init(rgb: (255, 249, 255)))
    case .cold:
      return (.init(rgb: (253, 194, 164)), .init(rgb: (226, 232, 254)))
    }
  }
}

fileprivate extension UIColor {

  convenience init(rgb: (Int, Int, Int), alpha: CGFloat = 1.0) {
    let red: CGFloat = CGFloat(rgb.0) / 255.0
    let green: CGFloat = CGFloat(rgb.1) / 255.0
    let blue: CGFloat = CGFloat(rgb.2) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

}
