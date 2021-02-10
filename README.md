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

# Overview
<img src="https://github.com/itsukiss/Assets/blob/main/TopContentPager/demo.gif" width="300" align='left'>

## What is `TopContentPager` ?
`TopContentPager` is framework you can make page like Instagram's MyPage simply.

Specifically, This is UIPageViewController with common scrollable headerView and PageSection fixed at the top in all pages.

A big feature of TopContentPager is that there is a common header that can be scrolled to the top.

It is very difficult to implement such an implementation using ordinary UIPageViewController and UITableView.
Because the top header also needs to be scrolled along with the UITableView.

Also, because the header at the top is common, if you scroll to the top on any page, you need to scroll to the top on all other pages.
There are many other complicated parts regarding scrolling, but I will omit them here.
See the `Logic` section for more details.

`TopContentPager` makes it easy to create such pages without having to worry about these difficult issues.
<br><br><br><br><br><br><br><br><br>


# Usage
1. ***Make Base Class***

First, you can make base class extended `TopContentPagerViewController` and add `TopContentPagerDataSource` to that.

Then, you must add `setupWillLoadDataSource()` function and bind dataSource in the function.
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

Second, please add `TopContentTableBody` to every ViewController to use them as page.

You can set pagerItem. (`PagerItem` has types `.text`, `.image`, `.textAndImage`, `.custom`)

So, need to set tableView to scrollView.
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

Finally, make TopView extended `TopContentView`.

```swift
class TopView: TopContentView {    
    // write your custom code
}
```

That's all. you can use `TopContentViewController`.
If you want to customize, you read properties section and sample code.

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

# Properties and functions
## TopContentPagerViewController
| property  | access | description |
|:-:|:-:|:-:|
| selectedIndex | get, set | current page index |
| dataSource | get, set | dataSource for topview and pageViewControllers |
| delegate | get, set | see `TopContentPagerDelegate`. it is able to make TopMargin on TopView. |
| viewControllers | get | innner ViewControllers with TableView |
| selectedViewController | get | current page ViewController |
| tabHeight | get | PagerItemsView's Height |
| headerHeight | get | TopView's Height |
| topMargin | get | TopMarginHeight by delegate |

## TopContentView
| property  | access | description |
|:-:|:-:|:-:|
| isHideTabView | get, override | flag to hide pagerItemsView |
| tabView | get, set | PagerItemsView |
| dataSource | get, set | see `TopContentViewDataSource`. you can set TopViewHeight if you don't want to use autolayout. |
| tabViewHeight | get | PagerItemsView's Height |
| estimateHeight | get | TopView's Height |

| function | description |
|:-:|:-:|
| updateTab(options: UpdatePagerOptions) | customize PagerItemsView. see `UpdatePagerOptions` properties in code. |
| updateLayout() | if you update TopView autolayout, you have to call this method. |

## PagerItem
| case | description |
|:-:|:-:|
| text | you can set page title text. (text and font) |
| image | you can set page title image. (image, size, and cornerRaius) |
| textAndImage | you can set page title text on the right side of the image |
| custom | you can set custom view for page title. |

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
