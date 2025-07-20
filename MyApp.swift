import SwiftUI

@main

struct MyApp: App {
    init() {
        let font = UIFont.preferredFont(forTextStyle: .footnote)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: font.pointSize, weight: .bold),
                .foregroundColor: UIColor.white
            ], for: .normal
        )

        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                .foregroundColor: UIColor.white
            ], for: .normal
        )
        

        // Set scroll indicator color to white
        UIScrollView.appearance().indicatorStyle = .white
        
        // Set segement control apperance to purple for full customization
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("PurpleColor"))
        UISegmentedControl.appearance().tintColor = UIColor.white
        let segmentedControl = UISegmentedControl(items: ["Encode", "Decode"])
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 300, height:200 )
  
           

    }


  
    var body: some Scene{
        WindowGroup {
            MainView()
        }
   
    }
}
