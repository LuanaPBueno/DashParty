//
//  narrativePassingView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct NarrativePassingView: View {
    
    var multipeerSession : MPCSession!
    @ObservedObject var hubManager = HUBPhoneManager.instance
    @State private var navigate: Bool = false
    @State private var isActive = false

    var body: some View {

            VStack {
             
                Spacer()
                
                Text("FOLLOW THE STORY ON THE BIG SCREEN!")
                    .multilineTextAlignment(.center)
                    .font(.custom("TorukSC-Regular", size: 30))
                    .padding(40)
                
    
                HStack {
                    Spacer()
                    Button {
                        if hubManager.actualPage > 0 {
                            hubManager.actualPage -= 1
                        }
                    } label: {
                        Image("backNarrativeButton")
                    }
                    Spacer()
                    Button {
                        hubManager.actualPage = hubManager.narrativeText.count
                        navigate = true
                        HUBPhoneManager.instance.passToTutorialView = true
                        
                        DispatchQueue.main.async {
                                self.hubManager.objectWillChange.send()
                            }
                            
                    } label: {
                        Image("skipNarrativeButton")
                    }
                    Spacer()
                    Button {
                        if hubManager.actualPage < hubManager.narrativeText.count - 1 {
                            hubManager.actualPage += 1
                        } else {
                            navigate = true
                            HUBPhoneManager.instance.passToTutorialView = true
                            
                            DispatchQueue.main.async {
                                    self.hubManager.objectWillChange.send()
                                }
                        }
                    } label: {
                        Image("passNarrativeButton")
                    }
                    Spacer()
                }
                 
                Spacer()
            }

            NavigationLink(
                destination: TutorialPassingView(multipeerSession: multipeerSession),
                isActive: $navigate,
                label: { EmptyView() }
            )
        
    }
}

#Preview{
    NarrativePassingView( )
}
