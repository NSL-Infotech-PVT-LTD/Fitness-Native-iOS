


import Foundation
import UIKit
import GooglePlacePicker
import GoogleMaps

// MARK: - UICOLOR EXTENSION
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static var placeholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
}

// MARK: - UIIMAGE EXTENSION
extension UIImage {
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
}

// MARK: - STRING
extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert(separator: String, every n: Int) {
        indices.reversed().forEach {
            if $0 != startIndex { if distance(from: startIndex, to: $0) % n == 0 { insert(contentsOf: separator, at: $0) } }
        }
    }
    func inserting(separator: String, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}

// MARK: - UITAPGESTURE
extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

// MARK: - NSMUTABLEATTRIBUTED STRING
//extension NSMutableAttributedString {
//    func setAttributedText(_ string: String, _ startLoc: Int, _ count: Int) -> NSMutableAttributedString {
//        let attributedString = NSMutableAttributedString.init(string: string)
//        attributedString.addAttribute(NSAttributedStringKey.font, value: TNotebookFonts.FONT_PROIMANOVA_REGULAR_14 ?? UIFont.systemFont(ofSize: 14), range: NSRange.init(location: startLoc, length: count))
//        return attributedString
//    }
//
//    func mutableText(appendedString: String, attributes: [NSAttributedStringKey: Any], range: NSRange) -> NSMutableAttributedString {
//        let attributedString = NSMutableAttributedString.init(string: appendedString)
//        attributedString.addAttributes(attributes, range: range)
//        return attributedString
//    }
//
//    func attributedText(_ text: String) -> NSMutableAttributedString {
//        let attributedString = NSMutableAttributedString.init(string: text)
//        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: TNotebookColors.BLACK_COLOR, range: NSRange.init(location: 0, length: 3))
//        attributedString.addAttribute(NSAttributedStringKey.font, value: TNotebookFonts.FONT_PROIMANOVA_REGULAR_10 ?? UIFont.systemFont(ofSize: 10), range: NSRange.init(location: 0, length: 3))
//        return attributedString
//    }
//}

// MARK: - UITEXTVIEW EXTENSION
extension UITextView {
    func blackBorder() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func blueBorder() {
        self.layer.borderWidth = 0.5
        //self.layer.borderColor = TNotebookColors.SKYBLUE_COLOR.cgColor
    }
}

// MARK: - UIVIEW CORNER RADIUS
extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
// MARK: - DATE EXTENSION
extension Date {
    func getWeekDates() -> (thisWeek:[Date],nextWeek:[Date]) {
        var tuple: (thisWeek:[Date],nextWeek:[Date])
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek,nextWeek: arrNextWeek)
        return tuple
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
    func toDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func daysRemaining(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}

// MARK: - BUNDLE EXTENSION
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
}


extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green
    
    @IBInspectable var vertical: Bool = true
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()
    
    //MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        applyGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyGradient()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    //MARK: -
    
    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }
    
    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }
    
    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class ThreeColorsGradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green
    @IBInspectable var thirdColor: UIColor = UIColor.blue
    
    @IBInspectable var vertical: Bool = true {
        didSet {
            updateGradientDirection()
        }
    }
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()
    
    //MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        applyGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyGradient()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    //MARK: -
    
    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }
    
    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }
    
    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class RadialGradientView: UIView {
    
    @IBInspectable var outsideColor: UIColor = UIColor.red
    @IBInspectable var insideColor: UIColor = UIColor.green
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyGradient()
    }
    
    func applyGradient() {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()
        
        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        #if TARGET_INTERFACE_BUILDER
        applyGradient()
        #endif
    }
}

extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}

func openTrackerInBrowser(lat: String, long: String, dlat: String, dlong: String){
    
    if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=\(lat),\(long)&daddr=\(dlat),\(dlong)&directionsmode=driving") {
        UIApplication.shared.open(urlDestination, options: [:], completionHandler: nil)
        
    }
}

func expDateValidation(dateStr:String) {
    
    let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
    let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
    
    let enterdYr = Int(dateStr.suffix(2)) ?? 0   // get last two digit from entered string as year
    let enterdMonth = Int(dateStr.prefix(2)) ?? 0  // get first two digit from entered string as month
    print(dateStr) // This is MM/YY Entered by user
    
    if enterdYr > currentYear
    {
        if (1 ... 12).contains(enterdMonth){
            print("Entered Date Is Right")
        } else
        {
            print("Entered Date Is Wrong")
        }
        
    } else  if currentYear == enterdYr {
        if enterdMonth >= currentMonth
        {
            if (1 ... 12).contains(enterdMonth) {
                print("Entered Date Is Right")
            }  else
            {
                print("Entered Date Is Wrong")
            }
        } else {
            print("Entered Date Is Wrong")
        }
    } else
    {
        print("Entered Date Is Wrong")
    }
    
}

class CustomTabBar : UITabBar {
    
    @IBInspectable var height: CGFloat = 65.0
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            
            if #available(iOS 11.0, *) {
                sizeThatFits.height = height + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = height
            }
        }
        return sizeThatFits
    }
}
