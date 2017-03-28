//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground 1"

//: [To Page2](Page2)

// Xcode 中 Playground 和 项目代码 使用两种不同的 Markdown 注释格式
// 简单来说，在Playground里编写markdown注释时，注释起始的第三个字符用:，在项目源代码中编写markdown注释时，注释起始的第三个字母分别用/和*。

// preference -> Key Binding (com + ,)-> Show Render -> option+m (Playground中快速切换Markdown的渲染效果的快捷键)


//: # heading 1 - 单行注释


/*:
 * #### 多行注释
 * item1
 * item2
 * item3
 */


//: [这里查看Apple官方的Swift markdown语法说明](https://developer.apple.com/library/content/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html#//apple_ref/doc/uid/TP40016497-CH2-SW1)

//* # 常用的注释范式


//* ### 标记重要事项

/*:
 > # IMPORTANT: something important you want to mention:
 A general description here.
 1. item1
 2. item2
 3. item3
 ---
 [More info - Access boxueio.com](https://boxueio.com)
 */


// 在 Playground 之间跳转

// 有时，为了演示一个项目的不同用法和功能，我们可能会在项目中使用多个Playground文件。为了方便在注释中浏览，我们可以在Playground markdown注释中，添加文件跳转链接。

// 选中项目中的MyPlayground，点击右键，选择“New Playground Page”，添加2个新的page进来，我们把这些页面分别命名成Page1 / Page2 / Page3。

// 在新添加进来的page2和page3里，先分别添加一个标题注释以方便区分它们。然后我们可以看到，在Playground页面的头部和尾部，Xcode已经为我们自动添加了两个链接：

// 当然，我们也可以实现跨文件跳转，打开Page1，这次在括号里写上要跳转到的目标Playground页面的名字："//: [To Page2](Page2)"

//: ### Code Snippets Library

//: ### 标记自定义的常用范式

/*:
 >
 对于一个自定义类型来说，我们要在注释中说明以下问题：

 * 一句话描述；
 * 类型主要功能；
 * 常用的初始化方法以及拷贝语义；
 * 补充说明；
*/

/*:
 `IntArray` is a C-like random access collection of integers.
 
 ## Overview
 An `IntArray` stores values of integers in an ordered list.
 The same value can appear in an IntArray multiple times at
 different positions.
 
 ## Initializers
 You can create an IntArray in the following ways:
 
 // An empty IntArray
 var empty: IntArray = []
 
 // Initialzied by an array literal
 var odds: IntArray = [0, 2, 4, 6, 8]
 
 // Initialized by a default value
 var tenInts: IntArray = IntArray(repeating: 0, count: 10)
 
 ## Value semantics
 - important:
 `IntArray` object perform value type semantics. But we have the COW optimization.
 
 Like all value types, `IntArray` use a COW optimization.
 Multiple copies of `IntArray` share the same storage as long as
 none of the copies are modified.
 
 ---
 
 - note:
 Check [Swift Standard Library](https://developer.apple.com/reference/swift/array)
 for more informaton about arrays.
 */

// 在上面的注释里，有几个用法是要特别说明下的：
// 1. 我们可以在注释中使用`single line of code`来插入单行代码；
// 2. 在注释中插入代码块时，代码块的缩进要和当前最近的一个内容缩进有4个以上的空格，否则XCode不会识别；
// 3. 我们在注释中使用了两个用-开始的标记，它们叫做callout，实际上你可以选择使用加号、减号或乘号来表示一个callout。XCode可以识别它们，并突出显示其中的内容。大家可以在这里找到所有的callout元素列表。要说明的是，并不是所有callout都可以同时在Playground和Quick Help中使用，选择的时候，要注意这点；
// 4. 最后，我们可以使用三个及以上的-，表示一条分割线，用来区分正文和内容引用的部分

//* ### 标记函数或方法的常用范式
/*:
  通常，对一个方法的描述，更多是用在Quick Help里。对于一个函数来说，最重要的内容无非有以下：

  * 一句话功能描述；
  * 常见应用场景；
  * 参数；
  * 返回值；
  * 时间复杂度；
*/

/*:
  如果我们要在上面IntArray里，添加一个“返回不包括末尾N个元素的IntArray”的方法：
       
     `public func dropLast(_ n: Int) -> IntArray`
  
  它的注释可以是这样的：
*/

/// Returns a subsequence containing all but the specified number of final
/// elements.
///
/// If the number of elements to drop exceeds the number of elements in the
/// collection, the result is an empty subsequence.
///
///     let numbers = [1, 2, 3, 4, 5]
///     print(numbers.dropLast(2))
///     // Prints "[1, 2, 3]"
///     print(numbers.dropLast(10))
///     // Prints "[]"
///
/// - Parameter n: The number of elements to drop off the end of the collection.
///   `n` must be greater than or equal to zero.
///
/// - Returns: A subsequence that leaves off `n` elements from the end.
///
/// - Complexity: O(*n*), where *n* is the number of elements to drop.

//* ### 标记属性的常用范式

// 关于属性的注释，我们只强调一点，就是对于computed property来说，**如果它的算法复杂度不是O(1)，必须在注释中予以说明**。因为对于绝大多数人来说，不会预期访问一个属性会带来严重的性能开销。

//以上，就是在Swift 3 API设计指南中，关于注释的内容。在编码前，用写文档的方式来编写注释，可能在初期会让我们觉得不适应，或者觉得没必要，但至少在设计一个新的类型或方法时，尝试着去做它们，它会让你明确类型表达的语意，理清方法功能的边界，进而让你的代码，更加易于理解和交流。
