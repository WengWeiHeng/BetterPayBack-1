//
//  PageMenuView.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

protocol PageMenuViewDelegate: class {
    func willMoveToPage(_ pageMenu: PageMenuView, from viewController: UIViewController, index currentViewControllerIndex : Int)
    func didMoveToPage(_ pageMenu: PageMenuView, to viewController: UIViewController, index currentViewControllerIndex: Int)
}

// MARK: - Page Menu Option
struct PageMenuOption {
    
    var frame: CGRect
    var menuItemHeight: CGFloat
    var menuItemWidth: CGFloat
    var menuItemBackgroundColorNormal: UIColor
    var menuItemBackgroundColorSelected: UIColor
    var menuTitleMargin: CGFloat
    var menuTitleFont: UIFont
    var menuTitleColorNormal: UIColor
    var menuTitleColorSelected: UIColor
    var menuIndicatorHeight: CGFloat
    var menuIndicatorColor: UIColor
    
    init(frame: CGRect,
         menuItemHeight: CGFloat = 400,
         menuItemWidth: CGFloat = 0,
         menuItemBackgroundColorNormal: UIColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0),
         menuItemBackgroundColorSelected: UIColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0),
         menuTitleMargin: CGFloat = 40,
         menuTitleFont: UIFont = .systemFont(ofSize: 20),
         menuTitleColorNormal: UIColor = .white,
         menuTitleColorSelected: UIColor = .white,
         menuIndicatorHeight: CGFloat = 3,
         menuIndicatorColor: UIColor = UIColor(red: 18/255, green: 21/255, blue: 91/255, alpha: 1.0)) {
        self.frame = frame
        self.menuItemHeight = menuItemHeight
        self.menuItemWidth = menuItemWidth
        self.menuItemBackgroundColorNormal = menuItemBackgroundColorNormal
        self.menuItemBackgroundColorSelected = menuItemBackgroundColorSelected
        self.menuTitleMargin = menuTitleMargin
        self.menuTitleFont = menuTitleFont
        self.menuTitleColorNormal = menuTitleColorNormal
        self.menuTitleColorSelected = menuTitleColorSelected
        self.menuIndicatorHeight = menuIndicatorHeight
        self.menuIndicatorColor = menuIndicatorColor
    }
}

// MARK: - Page Menu
class PageMenuView: UIView {
    
    var delegate: PageMenuViewDelegate?
    
    fileprivate let cellId = "PageMenuCell"
    fileprivate var option = PageMenuOption(frame: .zero)
    fileprivate var viewControllers = [UIViewController]()
    
    fileprivate var menuScrollView: UIScrollView!
    fileprivate var menuBorderLine: UIView!
    fileprivate var collectionView: UICollectionView!
    // 下地のViewを追加する
    fileprivate var foundationView: UIView!
    
    convenience init() {
        self.init(viewControllers: [], option: PageMenuOption(frame: .zero))
    }
    
    init(viewControllers: [UIViewController], option: PageMenuOption) {
        super.init(frame: option.frame)
        self.viewControllers = viewControllers
        self.option = option
        backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
        setupMenus()
        setupPageView()
        //setuOrientationpNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Scroll View (Buttons)
extension PageMenuView: UIScrollViewDelegate {
    
    fileprivate func setupMenus() {
        setupFoundation()
        addSubview(foundationView)
        setupMenuScrollView()
        setupMenuButtons()
        setupMenuIndicatorBorder()
        addSubview(menuScrollView)
    }
    
    fileprivate func setupMenuScrollView() {
        menuScrollView = UIScrollView()
        menuScrollView.backgroundColor = option.menuItemBackgroundColorNormal
        //menuScrollView.backgroundColor = .red
        menuScrollView.delegate = self
        menuScrollView.isPagingEnabled = false
        menuScrollView.showsHorizontalScrollIndicator = false
        let x = CGRect(x: 0, y: foundationView.frame.height*0.9,
                       width: foundationView.frame.width,
                       height: foundationView.frame.height-foundationView.frame.height*0.4)
        menuScrollView.frame = x
        
        print("scrollView:\(x)")
    }
    
    fileprivate func setupFoundation() {
        foundationView = UIView()
        foundationView.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
        let a = CGRect(x: 0, y: frame.size.height*0.2, width: frame.size.width, height: 500)
        foundationView.frame = a
        
        print("foundationView:\(a)")
    }
    
    fileprivate func setupMenuButtons() {
        //menuXを40から105変わる
        var menuX = 220 as CGFloat
        for i in 1...viewControllers.count {
            let viewControllerIndex = i - 1
            
            // Menu button
            let menuButton = UIButton(type: .custom)
            menuButton.tag = i
            menuButton.setBackgroundColor(option.menuItemBackgroundColorNormal, forState: .normal)
            menuButton.setBackgroundColor(option.menuItemBackgroundColorSelected, forState: .selected)
            menuButton.setTitle(viewControllers[viewControllerIndex].title, for: .normal)
            menuButton.setTitleColor(option.menuTitleColorNormal, for: .normal)
            menuButton.setTitleColor(option.menuTitleColorSelected, for: .selected)
            menuButton.titleLabel?.font = option.menuTitleFont
            menuButton.addTarget(self, action: #selector(selectedMenuItem(_:)), for: .touchUpInside)
            menuButton.isSelected = (viewControllerIndex == 0)
            
            // Resize Menu item based on option
            let buttonWidth = getMenuButtonWidth(button: menuButton)
            let d = CGRect(x: menuX, y: foundationView.frame.height*0.4,
                           width: buttonWidth,
                           height: 50)
            menuButton.frame = d
            
            print("menuButton:\(d)")
            menuScrollView.addSubview(menuButton)
            
            // Update x position
            menuX += frame.size.width/3
        }
        menuScrollView.contentSize.width = menuX
    }
    
    fileprivate func setupMenuIndicatorBorder() {
        guard let firstMenuButton = menuScrollView.viewWithTag(1) as? UIButton else { return }
        menuBorderLine = UIView()
        menuBorderLine.backgroundColor = option.menuIndicatorColor
        menuBorderLine.frame = CGRect(
            x: firstMenuButton.frame.origin.x,
            y: firstMenuButton.frame.maxY - option.menuIndicatorHeight,
            width: firstMenuButton.frame.size.width,
            height: option.menuIndicatorHeight)
        menuScrollView.addSubview(menuBorderLine)
    }
    
    func updateMenuTitle(title: String, viewControllerIndex: Int) {
        let buttonIndex = viewControllerIndex + 1
        guard let menuButton = menuScrollView.viewWithTag(buttonIndex)
            as? UIButton else { return }
        menuButton.setTitle(title, for: .normal)
        var rect = menuButton.frame
        rect.size.width = getMenuButtonWidth(button: menuButton)
        menuButton.frame = rect
        var minX = menuButton.frame.minX
        for i in buttonIndex...viewControllers.count {
            guard let button = menuScrollView.viewWithTag(i) as? UIButton else { continue }
            var origin = button.frame.origin
            origin.x = minX
            button.frame.origin = origin
            minX = button.frame.maxX
        }
        let currentButtonIndex = getCurrentMenuButtonIndex()
        updateIndicatorPosition(menuButtonIndex: currentButtonIndex)
    }
    
    fileprivate func updateIndicatorPosition(menuButtonIndex: Int) {
        guard let menuButton = menuScrollView.viewWithTag(menuButtonIndex) else { return }
        var rect = menuBorderLine.frame
        rect.origin.x = menuButton.frame.minX
        rect.size.width = menuButton.frame.size.width
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
            self.menuBorderLine.frame = rect
        }, completion: nil)
    }
    
    fileprivate func updateButtonStatus(menuButtonIndex: Int) {
        guard let menuButton = menuScrollView.viewWithTag(menuButtonIndex) as? UIButton else { return }
        for subview in menuScrollView.subviews {
            if let button = subview as? UIButton {
                button.setTitleColor(option.menuTitleColorNormal, for: .normal)
                button.isSelected = false
            }
        }
        menuButton.isSelected = true
        menuButton.setTitleColor(option.menuTitleColorSelected, for: .normal)
    }
    
    fileprivate func updateMenuScrollOffsetIfNeeded(menuButtonIndex: Int) {
        guard let menuButton = menuScrollView.viewWithTag(menuButtonIndex) else { return }
        let collectionPagingWidth = collectionView.frame.size.width
        let currentMenuOffsetMinX = menuScrollView.contentOffset.x
        let currentMenuOffsetMaxX = currentMenuOffsetMinX + collectionPagingWidth
        let selectedButtonMinX = menuButton.frame.minX
        let selectedButtonMaxX = menuButton.frame.maxX
        if selectedButtonMinX < currentMenuOffsetMinX {
            // out of screen (left)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn], animations: {
                self.menuScrollView.contentOffset.x = selectedButtonMinX
            }, completion: nil)
        } else if selectedButtonMaxX > currentMenuOffsetMaxX {
            // out of screen (right)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn], animations: {
                let newOffsetX = selectedButtonMinX - (collectionPagingWidth - menuButton.frame.size.width)
                self.menuScrollView.contentOffset.x = newOffsetX
            }, completion: nil)
        }
    }
    
    @objc fileprivate func selectedMenuItem(_ sender: UIButton) {
        // PageMenuViewDelegate [WillMoveToPage]
        let currentViewControllerIndex = getCurrentMenuButtonIndex() - 1
        delegate?.willMoveToPage(self,
                                 from: viewControllers[currentViewControllerIndex],
                                 index: currentViewControllerIndex)
        
        // Move to selected page
        let buttonIndex = sender.tag
        let nextViewControllerIndex = sender.tag - 1
        updateIndicatorPosition(menuButtonIndex: buttonIndex)
        updateButtonStatus(menuButtonIndex: buttonIndex)
        updateMenuScrollOffsetIfNeeded(menuButtonIndex: buttonIndex)
        collectionView.scrollToItem(
            at: IndexPath.init(row: nextViewControllerIndex, section: 0),
            at: .left,
            animated: true)
        
    }
}

// MARK: - Collection View (ViewControllers)
extension PageMenuView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate func setupPageView() {
        // CollectionView Layout
        let collectionViewHeight = foundationView.frame.height*0.7
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.sectionInset = .zero
        collectionViewLayout.itemSize = CGSize(
            width: frame.size.width,
            height: collectionViewHeight)
        
        // CollectionView
        
        let s = UICollectionView(
            frame: CGRect(x: 0,
                          y: frame.size.height*0.2,
                          width: frame.size.width,
                          height: collectionViewHeight),
            collectionViewLayout: collectionViewLayout)
        
        collectionView = s
        
        print("collectionView:\(s)")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        guard let controllerView = viewControllers[indexPath.row].view else {
            return UICollectionViewCell()
        }
        controllerView.frame = cell.bounds
        cell.addSubview(controllerView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == menuScrollView { return }
        
        // PageMenuViewDelegate [WillMoveToPage]
        let viewControllerIndex = getCurrentMenuButtonIndex() - 1
        delegate?.willMoveToPage(self,
                                 from: viewControllers[viewControllerIndex],
                                 index: viewControllerIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == menuScrollView { return }
        let buttonIndex = getCurrentMenuButtonIndex()
        updateIndicatorPosition(menuButtonIndex: buttonIndex)
        updateButtonStatus(menuButtonIndex: buttonIndex)
        updateMenuScrollOffsetIfNeeded(menuButtonIndex: buttonIndex)
        
        // PageMenuViewDelegate [DidMoveToPage]
        let viewControllerIndex = buttonIndex - 1
        delegate?.didMoveToPage(self,
                                to: viewControllers[viewControllerIndex],
                                index: viewControllerIndex)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == menuScrollView { return }
        
        // PageMenuViewDelegate [DidMoveToPage]
        let viewControllerIndex = getCurrentMenuButtonIndex() - 1
        delegate?.didMoveToPage(self,
                                to: viewControllers[viewControllerIndex],
                                index: viewControllerIndex)
    }
}


// MARK: - Supporting Functions
extension PageMenuView {
    
    fileprivate func getCurrentMenuButtonIndex() -> Int {
        let offsetX = collectionView.contentOffset.x
        let collectionViewWidth = collectionView.bounds.size.width
        return Int(ceil(offsetX / collectionViewWidth)) + 1
    }
    
    fileprivate func getMenuButtonWidth(button: UIButton) -> CGFloat {
        var buttonWidth = 0 as CGFloat
        if option.menuItemWidth == 0 {
            // based on title text
            buttonWidth = button.sizeThatFits(
                CGSize(width: CGFloat.greatestFiniteMagnitude,
                       height: option.menuItemHeight)).width + option.menuTitleMargin / 2
        } else {
            // based on specified width
            buttonWidth = option.menuItemWidth + option.menuTitleMargin / 2
        }
        return buttonWidth
    }
}

// MARK: - UIButton Extension
extension UIButton {
    
    fileprivate func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: forState)
    }
}

class ChartView: UIView {
    let caShapeLayerForBase: CAShapeLayer = CAShapeLayer.init()
    let caShapeLayerForValue: CAShapeLayer = CAShapeLayer.init()
    
    func drawChart(rate: Double) {
        // グラフを表示
        drawBaseChart()
        drawValueChart(rate: rate)
        
        let caBasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        caBasicAnimation.duration = 1.0
        caBasicAnimation.fromValue = 0.0
        caBasicAnimation.toValue = 1.0
        caShapeLayerForValue.add(caBasicAnimation, forKey: "chartAnimation")
    }
    
    /// 円グラフの軸となる円を表示
    private func drawBaseChart() {
        
        let shapeFrame = CGRect.init(x: 60, y: 62, width: self.frame.width, height: self.frame.height)
        caShapeLayerForBase.frame = shapeFrame
        // グラフ下地の色
        caShapeLayerForBase.strokeColor = UIColor(red: 18/255, green: 21/255, blue: 91/255, alpha: 1.0).cgColor
        caShapeLayerForBase.fillColor = UIColor.clear.cgColor
        caShapeLayerForBase.lineWidth = 130
        caShapeLayerForBase.lineCap = .round
        
        let startAngle: CGFloat = CGFloat(0.0)
        let endAngle: CGFloat = CGFloat(Double.pi * 2.0)
        
        caShapeLayerForBase.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0), radius: shapeFrame.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        self.layer.addSublayer(caShapeLayerForBase)
    }
    
    /// 円グラフの値を示す円（半円）を表示
    private func drawValueChart(rate: Double) {
        let shapeFrame = CGRect.init(x: 60, y: 62, width: self.frame.width, height: self.frame.height)
        caShapeLayerForValue.frame = shapeFrame
        
        // CAShareLayerのデザイン
        // 変化グラフの色
        caShapeLayerForValue.strokeColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1.0).cgColor
        caShapeLayerForValue.fillColor = UIColor.clear.cgColor
        caShapeLayerForValue.lineWidth = 130
        
        // 開始位置
        let startAngle: CGFloat = CGFloat(-1 * Double.pi / 2.0)
        // 終了位置
        let endAngle: CGFloat = CGFloat(rate / 100 * Double.pi * 2.0 - (Double.pi / 2.0))
        
        caShapeLayerForValue.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0), radius: shapeFrame.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        self.layer.addSublayer(caShapeLayerForValue)
    }
    
    @objc func touchUpButtonDraw(rateOfPerson:Double){
        drawChart(rateOfPerson:rateOfPerson)
    }
    
    // グラフを表示
    fileprivate func drawChart(rateOfPerson:Double){
        // グラフの変動する値を挿入する
        //let rate = Double(99)
        drawChart(rate: rateOfPerson)
    }
    
}
extension ChartView {
    
    func changeScreen() {
        let screenSize: CGRect = UIScreen.main.bounds
        let widthValue = screenSize.width
        let heightValue = screenSize.height
        
        // サイズ調整用
        var drawWidth = widthValue * 0.8
        if (widthValue > heightValue) {
            drawWidth = heightValue * 0.8
        }
        
    }
}

