//  FAYHomeView.swift
//  FayiOS

import SwiftUI

struct FAYHomeView: View {
    
    @State private var selectedTab: Tabs = .appointments
    private var user: FayUser
    
    init(user: FayUser) {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "FAYNeutral")
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Manrope-Regular", size: 12)!], for: .normal)
        
        self.user = user
    }
                
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Tab(value: tab) {
                    switch tab {
                    case .appointments:
                        FAYAppointmentsView(user: user)
                    default:
                        Text("\(tab.title) Coming soon!")
                            .padding()
                    }
                } label: {
                    VStack {
                        Image(selectedTab == tab ? tab.selectedIconName : tab.iconName)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Text(tab.title)
                    } //vstack
                } //tab
            } //foreach
        } //tabview
        .tint(Color.brandPrimary)
    } //body
}

fileprivate enum Tabs: String, CaseIterable, Identifiable {
    
    case appointments
    case chat
    case journal
    case profile
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .appointments:
            return "Appointments"
        case .chat:
            return "Chat"
        case .journal:
            return "Journal"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .appointments:
            return "Calendar"
        case .chat:
            return "Chats"
        case .journal:
            return "Notebook text"
        case .profile:
            return "User"
        }
    }
    
    var selectedIconName: String {
        switch self {
        case .appointments:
            return "Calendar_selected"
        case .chat:
            return "Chats"
        case .journal:
            return "Notebook text"
        case .profile:
            return "User"
        }
    }
}

#Preview {
    FAYHomeView(user: FayUser(userName: "john"))
}
