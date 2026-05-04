# Graph Report - /Users/luowei/projects/libs/LWProgressView  (2026-05-04)

## Corpus Check
- Corpus is ~6,130 words - fits in a single context window. You may not need a graph.

## Summary
- 87 nodes · 102 edges · 8 communities detected
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 3 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]

## God Nodes (most connected - your core abstractions)
1. `LWMaskProgressView` - 22 edges
2. `CircleProgressBarView` - 11 edges
3. `LWAppDelegate` - 7 edges
4. `UIKitViewController` - 6 edges
5. `ProgressState` - 6 edges
6. `CircleProgressBar` - 5 edges
7. `LWViewController` - 4 edges
8. `LWProgressViewModifier` - 4 edges
9. `LWMaskProgressViewSwiftUI` - 4 edges
10. `SwiftUIExampleView1` - 3 edges

## Surprising Connections (you probably didn't know these)
- `LWMaskProgressView` --inherits--> `UIView`  [EXTRACTED]
  LWProgressView_swift/Classes/LWMaskProgressView.swift →   _Bridges community 0 → community 2_
- `LWMaskProgressViewSwiftUI` --inherits--> `View`  [EXTRACTED]
  LWProgressView_swift/Classes/LWMaskProgressView.swift →   _Bridges community 5 → community 7_
- `CircleProgressBar` --inherits--> `View`  [EXTRACTED]
  LWProgressView_swift/Classes/CircleProgressBar.swift →   _Bridges community 5 → community 2_

## Communities (13 total, 0 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.13
Nodes (9): LWMaskProgressView, -circleProgressBar, -dismissMaskProgressViewin, -initWithTextprogress, -showMaskProgressViewinwithTextprogressdismissBlock, -showWithTextprogress, -textBtn, -touchesBeganwithEvent (+1 more)

### Community 1 - "Community 1"
Cohesion: 0.14
Nodes (8): EnvironmentValues, LWProgressViewModifier, ProgressState, ProgressStateKey, View, EnvironmentKey, ObservableObject, ViewModifier

### Community 2 - "Community 2"
Cohesion: 0.26
Nodes (3): CircleProgressBar, CircleProgressBarView, UIView

### Community 3 - "Community 3"
Cohesion: 0.25
Nodes (7): LWAppDelegate, -applicationDidBecomeActive, -applicationDidEnterBackground, -applicationdidFinishLaunchingWithOptions, -applicationWillEnterForeground, -applicationWillResignActive, -applicationWillTerminate

### Community 4 - "Community 4"
Cohesion: 0.29
Nodes (3): CircleProgressBarUIKitExample, UIKitViewController, UIViewController

### Community 5 - "Community 5"
Cohesion: 0.36
Nodes (5): CircleProgressBarExample, SwiftUIExampleView1, SwiftUIExampleView2, SwiftUIExampleView3, View

### Community 6 - "Community 6"
Cohesion: 0.4
Nodes (4): LWViewController, -btnAction, -scheduleTimer, -viewDidLoad

### Community 7 - "Community 7"
Cohesion: 0.4
Nodes (3): LWMaskProgressView_Previews, LWMaskProgressViewSwiftUI, PreviewProvider

## Knowledge Gaps
- **18 isolated node(s):** `-showMaskProgressViewinwithTextprogressdismissBlock`, `-dismissMaskProgressViewin`, `-initWithTextprogress`, `-textBtn`, `-circleProgressBar` (+13 more)
  These have ≤1 connection - possible missing edges or undocumented components.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `LWMaskProgressViewSwiftUI` connect `Community 7` to `Community 1`, `Community 5`?**
  _High betweenness centrality (0.300) - this node is a cross-community bridge._
- **Why does `LWMaskProgressView` connect `Community 0` to `Community 2`, `Community 7`?**
  _High betweenness centrality (0.296) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `CircleProgressBarView` (e.g. with `.example_circleProgressBar()` and `.setupViews()`) actually correct?**
  _`CircleProgressBarView` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `-showMaskProgressViewinwithTextprogressdismissBlock`, `-dismissMaskProgressViewin`, `-initWithTextprogress` to the rest of the system?**
  _18 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.13 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.14 - nodes in this community are weakly interconnected._