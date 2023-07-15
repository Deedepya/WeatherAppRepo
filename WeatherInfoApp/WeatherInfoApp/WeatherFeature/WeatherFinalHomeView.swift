//
//  WeatherFinalHomeView.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 21/06/23.
//

import SwiftUI

struct WeatherFinalHomeView: View {

    @StateObject var weatherVm = WeatherViewModel()
    @State var citySearchText = ""
    let fontSize: CGFloat = 16
    
    var body: some View {
        NavigationStack {
            VStack {
               WeatherInfoView(fontSize: fontSize, currentWeather: $weatherVm.weather)
                Spacer()
            }.background(.white)
                .border(.green)
                .overlay {
                    if weatherVm.showLoader {
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .background(.thinMaterial)
                    }
                }
        }
        .searchable(text: $citySearchText) {
            ForEach(weatherVm.citiesList) { city in
                Text(city.name)
                    .onTapGesture {
                        print("jkl")
                        //weatherVm.citiesList = []
                    }
            }
        }
        .onChange(of: citySearchText) { citySearchText in
            let results = weatherVm.originalList
            weatherVm.citiesList = results.filter({ city in
                return city.name.lowercased().contains(citySearchText)
            })
        }
    }
}

struct WeatherFinalHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherFinalHomeView()
    }
}

//---other related views

struct WeatherInfoView: View {
    
    var fontSize: CGFloat
    @Binding var currentWeather: CurrentWeatherInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(currentWeather.cityName)
                .font(.title)
                .frame(minHeight: 150)
                .border(.green)
                .padding(.bottom, 20)
            
            mainWeatherInfoView()
            
            Rectangle()
                .fill(.gray)
                .frame(height: 2)
                .padding([.top, .bottom], 20)
            
            ScrollView {
                VStack(alignment: .leading) {
                    weatherParamView(title: AppStrings.humidity, value: currentWeather.humidity)
                    weatherParamView(title: AppStrings.pressure, value: currentWeather.pressure)
                    weatherParamView(title: AppStrings.visibility, value: currentWeather.visibility)
                    weatherParamView(title: AppStrings.mintemp, value: currentWeather.minTemp)
                    weatherParamView(title: AppStrings.maxTemp, value: currentWeather.maxTemp)
                }
            }
        }
        .padding(20)
        .border(.yellow)
    }
    
    private func mainWeatherInfoView() -> some View {
        HStack {
            VStack {
                Text("56 F")
                    .font(.title)
                    .frame(minHeight: 50)
                    .border(.green)
                Text("Feels like 55 F")
                    .font(.system(size: fontSize))
                    .border(.green)
            }
            Spacer()
            iconViewInfo()
        }
    }
    
    private func iconViewInfo() -> some View {
        VStack {
            if !currentWeather.skyImageUrl.isEmpty {
                AsynchImageViewer(imageUrlStr: currentWeather.skyImageUrl)
//                AsyncImage(url: URL(string: currentWeather.skyImageUrl)) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxHeight: 40)
//                        .border(.green)
//                } placeholder: {
//                    ProgressView()
//                        .frame(maxHeight: 40)
//                        .border(.green)
//                }
            } else {
                Image(systemName: "message.circle")
                    .frame(maxHeight: 40)
                    .border(.green)
            }
            
            Text("overcast Cloud")
                .font(.system(size: fontSize))
                .border(.green)
        }
    }
    
    private func weatherParamView(title: String, value: Double) -> some View {
        return VStack {
            Text(title)
            Spacer()
            Text("\(value)")
        }
        .font(.system(size: fontSize))
        .border(.green)
        .frame(height: 45)
        .padding([.top], 10)
    }
}
