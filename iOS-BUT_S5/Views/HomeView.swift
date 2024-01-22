//
//  HomeView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject var storeViewModel = StoreViewModel(service: StoreService())
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.637863, longitude: 6.858801), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @State private var selectedStore: Store?

    var body: some View {
        ZStack {
            switch storeViewModel.state {
                case .success(data: let stores):
                    Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: .constant(.follow), annotationItems: stores) {store in

                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(store.latitude), longitude: CLLocationDegrees(store.longitude))) {
                            Text(store.name)
                                .font(.caption)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(10)
                                .opacity(0.8)
                            
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                .imageScale(.large)
                        }
                        // TODO faire un onTapGesture pour attribuer à selectedStore la veleur de la pin sélectionnée
                    }
                    .sheet(item: $selectedStore) {store in
                        // TODO appeler ton composant voir détail store avec le store en paramètre
                    }
                case .loading:
                    ProgressView()
                default:
                    Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: .constant(.follow))
            }
        }
        .task {
            await storeViewModel.getStores()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


