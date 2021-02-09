<p align='center'>
<img src='https://github.com/itsukiss/Assets/blob/main/TopContentPager/title_logo.png' width='500px' />
</p>
<p align='center'>
<a href='https://cocoapods.org/pods/TopContentPager'>
<img src='https://img.shields.io/cocoapods/l/TopContentPager.svg?style=flat' alt='License' />
</a>

<a href='https://cocoapods.org/pods/TopContentPager'>
<img src='https://img.shields.io/cocoapods/p/TopContentPager.svg?style=flat' alt='Platform' />
</a>

<a href='https://cocoapods.org/pods/TopContentPager'>
<img src='https://img.shields.io/cocoapods/v/TopContentPager.svg?style=flat' alt='Version' />
</a>
</p>

# OverView
<img src="https://github.com/itsukiss/Assets/blob/main/TopContentPager/demo.gif" width="300" align='left'>

## What is `TopContentPager` ?
`TopContentPager` is PagerViewController like Instagram's MyPage.

Specifically, This is UIPageViewController with common scrollable headerView and PageSection fixed at the top in all pages.

It enables you to make rich pager simply.
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


# Usage
1. ***Make Base Class***

first, you can make base class extended `TopContentPagerViewController` and add `TopContentPagerDataSource` to that.

then, you must add `setupWillLoadDataSource()` function and bind dataSource in the function.
```swift
class CustomTopContentPagerViewController: TopContentPagerViewController {
    
    override func setupWillLoadDataSource() {
        super.setupWillLoadDataSource()
        dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CustomTopContentPagerViewController: TopContentPagerDataSource {
    func topContentPagerViewControllerTopContentView(_ viewController: TopContentPagerViewController) -> TopContentView {
        // 共通のHeaderViewを返す
        TopView()
    }
    
    func topContentPagerViewControllerViewControllers(_ viewController: TopContentPagerViewController) -> [ContentTableBody] {
        // PageとなるそれぞれのViewController
        [Page1ViewController(), Page2ViewController(), Page2ViewController()]
    }
}
```
2. ***Make Content Page***

second, please add `TopContentTableBody` to every ViewController to use them as page.

you can set pagerItem. (`PagerItem` has types `.text`, `.image`, `.textAndImage`, `.custom`)

so, need to set tableView to scrollView.
```swift
class Page1ViewController: UIViewController, ContentTableBody {
    
    var pagerItem: PagerItem = .text(.init(title: "ページ1"))
    var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            scrollView = tableView
        }
    }
}
```
3. ***Make TopView***

finally, make TopView extended `TopContentView`.

```swift
class TopView: TopContentView {    
    // write your custom code
}
```

that's all. you can use `TopContentViewController`.

# Logic
## View Structure
coming soon...

<p align='center'>
<img src='https://github.com/itsukiss/Assets/blob/main/TopContentPager/TopContentPagerStructure.png'>
</p>

## Fix Scrollable Header View Logic
coming soon...

<p align='center'>
<img src='https://github.com/itsukiss/Assets/blob/main/TopContentPager/TopContentPagerLogic.gif' width='800px'>
</p>

# Sample
coming soon...

# Installation
## CocoaPods
TopContentPager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TopContentPager"
```

# Requirements

- Swift 5 or greater
- iOS 11.0 or greater
