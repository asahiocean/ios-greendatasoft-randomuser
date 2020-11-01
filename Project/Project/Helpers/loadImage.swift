import UIKit.UIImage

func loadImage(_ urlStr: String) -> UIImage {
    DispatchQueue.global(qos: .userInteractive).sync {
        return UIImage(data: try! Data(contentsOf: URL(string: urlStr.urlValid)!)) ?? UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!
    }
}
