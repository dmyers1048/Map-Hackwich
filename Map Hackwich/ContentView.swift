//
//  ContentView.swift
//  Map Hackwich
//
//  Created by Devan Myers on 2/3/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var places = [Place]()
    @State private var startPosition = MapCameraPosition.userLocation(fallback: .automatic)
    @State private var mapRegion = MKCoordinateRegion()
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View
    {
        Map(position: $startPosition)
        {
                    UserAnnotation()
                    ForEach(places)
            { place in
                        Annotation(place.mapItem.name!, coordinate: place.mapItem.placemark.coordinate)
                {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                }
            }
        }
        .onMapCameraChange { context in
                    mapRegion = context.region
                    performSearch(item: "Pizza")
                }

    }
    func performSearch(item: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = item
        searchRequest.region = mapRegion
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let response = response {
                places.removeAll()
                                for mapItem in response.mapItems {
                                    places.append(Place(mapItem: mapItem))
                }

            }
        }
    }
}

struct Place: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}

#Preview {
    ContentView()
}

