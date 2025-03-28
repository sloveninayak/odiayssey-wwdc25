import SwiftUI
struct ContentView: View {
    var body: some View {
        NavigationView {
            WelcomePage()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

import AVFoundation

// 1. Welcome Page
struct WelcomePage: View {
    @State private var FlutePlayer: AVAudioPlayer? 
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
        
        if let url = Bundle.main.url(forResource: "Flute123", withExtension: "mp3") {
            do {
                FlutePlayer = try AVAudioPlayer(contentsOf: url)
                FlutePlayer?.numberOfLoops = -1 
            } catch {
                print("Error loading flute audio: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.red.opacity(0.5), .pink.opacity(0.1)]),
                center: .center,
                startRadius: 10,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing : 20){
                Text("Odiayssey!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.pink.opacity(0.4))
                
                Text("A Journey Through Flavours, Faith & Festivities!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Image("OdishaMaps")
                    .resizable()
                    .scaledToFit()
                    .frame(width:200, height: 200)
                    .padding()
                
                NavigationLink(destination: PuriDetailsPage()) {
                    Text("Come on, Let's Feast!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.pink.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .onAppear {
                FlutePlayer?.play()
            }
            .onDisappear {
                FlutePlayer?.stop()
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}


// 2. Puri Details Page
struct PuriDetailsPage: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.5), Color.orange.opacity(0.2)]),
                center: .center,
                startRadius: 20,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20){
                    Image("PuriMaps")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                    
                    Text("Welcome To Puri!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.pink.opacity(0.6))
                    
                    Text("""
                    Puri is a coastal city in Odisha, India, known for its golden beaches, the sacred Jagannath Temple, and its vibrant culture. It is a major pilgrimage site. Puri is also known for its traditional Odissi dance, exquisite handicrafts, and delectable cuisine, including the famous Mahaprasad offered at the Jagannath Temple.
                    
                    The city's spiritual essence and rich heritage make it a hub of devotion, art, and history!
                    """)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding()
                    
                    NavigationLink(destination: RathYatraInfoPage()) {
                        Text("Know about Rath Yatra and Puri Jagannath Temple")
                            .font(.headline)
                            .padding()
                            .background(Color.pink.opacity(0.4))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            playMusic()
        }
        .onDisappear {
            stopMusic()
        }
    }
    
    
    func playMusic() {
        if let soundURL = Bundle.main.url(forResource: "Flutemusic", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 
                audioPlayer?.play()
            } catch {
                print("Error: Could not play the audio file.")
            }
        } else {
            print("Audio file not found.")
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
    }
}

//.3 RATH YATRA INFO
    struct RathYatraInfoPage: View {
    var body: some View {
        ScrollView {
                VStack(spacing: 20) {
                Image("LotusImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
                
                Text("About Rath Yatra")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink.opacity(0.5))
                
                Text("""
                Rath Yatra, also known as the Festival of Chariots, is an annual festival celebrated in Puri, Odisha. It involves the grand procession of Lord Jagannath, Balabhadra, and Subhadra on beautifully decorated chariots. 
                The journey begins from the Jagannath Temple to the Gundicha Temple, covering a distance of around 3 kilometers. 
                
                People gather in large numbers to pull the chariots with ropes, marking their devotion and participation in this sacred festival. The rhythmic chants, the energy of the crowd, and the sheer scale of procession make it one of the most mesmerizing spiritual experiences in the world.
                
                More than a festival, Rath Yatra is a celebration of inclusivity, where people from all walks of life come together in joy!
                """)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()
                
                NavigationLink(destination: ChariotSliderPage()) {
                    Text("Start the Rath Yatra Journey")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .background(
            RadialGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.4), Color.orange.opacity(0.2)]),
                center: .center,
                startRadius: 20,
                endRadius: 500
            )
            .ignoresSafeArea()
        )
    }
}

// 4. CHARIOT SLIDER PAGE
import SwiftUI

struct ChariotSliderPage: View {
    @State private var sliderValue: Double = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.4), Color.orange.opacity(0.2)]),
                center: .center,
                startRadius: 20,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Rath Yatra Journey")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink.opacity(0.4))
                    .padding(.top, 20)
                
                VStack(spacing: 20) {
                    HStack {
                        VStack {
                            Image("TempleImage") 
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                            Text("Temple")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Image("AuntImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            Text("Aunt's House")
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 4)
                                .foregroundColor(.gray.opacity(0.5))
                                .cornerRadius(2)
                            
                            Image("ChariotImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .offset(x: CGFloat(sliderValue) * (geometry.size.width - 100))
                                .animation(.easeInOut(duration: 0.5), value: sliderValue)
                        }
                        .frame(height: 50)
                    }
                    .frame(height: 50)
                    .padding(.horizontal)
                }
                
                Slider(value: $sliderValue, in: 0...1)
                    .padding(.horizontal)
                    .accentColor(.red)
                
                Text(sliderValue == 1.0 ? "The chariot has reached Aunt's House!" : "Slide the chariot to complete the Rath Yatra journey!")
                    .font(.footnote)
                    .foregroundColor(sliderValue == 1.0 ? .green : .gray)
                    .padding(.bottom, 20)
                
                
                Text("Pulled by lakhs using thick ropes, the mighty chariot rolls forward, carrying centuries of devotion on its massive wooden wheels!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                NavigationLink(destination: MahaprasadPage()) {
                    Text("Get to Know About Mahaprasad")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink.opacity(0.4))
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
            }
            .padding()
        }
        .navigationTitle("Let's start the Rath Yatra")
    }
}


//.5 MAHAPRASAD

struct MahaprasadPage: View {
    let dishes = [
        ("Pakhala", "A fermented rice dish served with water, curd, and green chilies. Often enjoyed with fried vegetables, roasted potatoes, or fish. It is a cooling dish, perfect for hot summers and is a staple in Odia households.", "PakhalaImage"),
        ("Dalma", "A wholesome lentil curry cooked with vegetables and mild spices. Typically made with toor dal or moong dal and flavoured with cumin and ginger.", "DalmaImage"),
        ("Poda Pitha", "A traditional Oriya sweet dish made with rice, jaggery, and coconut, baked to perfection. The slightly burnt edges add a unique smoky flavor, making it a festive favourite during Raja Festival.", "PodaPithaImage"),
        ("Chhena Poda", "A baked sweet dish made with fresh paneer and caramelized sugar. Known as the 'Cheesecake of Odisha'.", "ChhenaPodaImage"),
        ("Rasabali", "A dessert made with fried cheese patties soaked in sweetened milk. This delicacy is offered to Lord Jagannath and is cherished for its melt-in-the-mouth goodness.", "RasabaliImage"),
        ("Malpua", "A sweet pancake made with flour, sugar, and coconut, deep-fried and served with syrup. It is often enriched with cardamom and fennel seeds, making it a popular festive treat.", "MalpuaImage"),
        ("Khaja", "A crispy and flaky sweet made with wheat flour, sugar, and ghee. Famous for its layered texture, it is a key offering in Puri temples.", "KhajaImage")
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.red.opacity(0.3)]),
                center: .center,
                startRadius: 20,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Text("Mahaprasad Dishes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink.opacity(0.3))
                    .shadow(radius: 5)
                
                Text("""
Mahaprasad is a sacred offering at the Jagannath Temple in Puri. It is prepared using traditional methods, it consists of a variety of vegetarian dishes cooked in earthen pots using wood-fire stoves. The unique process of stacking pots on top of each other, where the topmost pot cooks first, adds to its mystique.

The 56-dish offering **Chappan Bhog**, includes rice, dal, vegatables, sweets and many more. It is a symbol of unity- a meal that people, irrespective of caste or background, share together. Here are some of the few dishes. Slide down and click on them to know more!
""")
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(dishes.indices, id: \.self) { index in
                            NavigationLink(
                                destination: DishDetailPage(dish: dishes[index].0, recipe: dishes[index].1, imageName: dishes[index].2)
                            ) {
                                VStack {
                                    Image(dishes[index].2)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                    
                                    Text(dishes[index].0)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.pink.opacity(0.4))
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                NavigationLink(destination: PuriSeaBeachPage()) {
                    Text("Learn About Puri Sea Beach")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink.opacity(0.4))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .onAppear {
            playTablaMusic()
        }
        .onDisappear {
            stopMusic()
        }
        .navigationTitle("Click one the dishes to know more!")
    }
    
    func playTablaMusic() {
        if let soundURL = Bundle.main.url(forResource: "tablamusic", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 
                audioPlayer?.play()
            } catch {
                print("Error: Could not play the tabla audio file.")
            }
        } else {
            print("Tabla audio file not found.")
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
    }
}

struct DishDetailPage: View {
    let dish: String
    let recipe: String
    let imageName: String
    
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(dish)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink.opacity(0.3))
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding()
                
                Text(recipe)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .navigationBarTitle(dish, displayMode: .inline)
        .onAppear {
            playTablaMusic()
        }
        .onDisappear {
            stopMusic()
        }
    }
    
    func playTablaMusic() {
        if let soundURL = Bundle.main.url(forResource: "tablamusic", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 
                audioPlayer?.play()
            } catch {
                print("Error: Could not play the tabla audio file.")
            }
        } else {
            print("Tabla audio file not found.")
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
    }
}

//.6 PURI BEACH 

struct PuriSeaBeachPage: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    func playSeaShoreMusic() {
        if let url = Bundle.main.url(forResource: "seashore_music", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 
                audioPlayer?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.2), Color.cyan.opacity(0.4)]),
                center: .top,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Another Hidden Gem")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.cyan.opacity(0.5))
                
                Image("BeachImage") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                ScrollView {
                    Text("""
Puri Sea Beach is a pristine, untouched gem along the Bay of Bengal. Its golden sands stretch endlessly, offering breathtaking views of the crashing waves. The sea is a home to variety of fish, crabs, lobster, and prawns, making it a paradise for seafood lovers.

Olive Ridley Turtles nest on the nearby beaches, making it a must-visit spot for wildlife enthusiasts. Visitors can also enjoy camel and horse rides along the shore. The beach is lively with local vendors selling shell jewelry and traditional handicrafts. Adventurers can try jet skiing, parasailing, or banana boat rides along the shore.
""")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                NavigationLink(destination: CustomizePakhalaPage()) {
                    Text("Now let's make some Pakhala")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.cyan.opacity(0.5))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarTitle("Puri Sea Beach", displayMode: .inline)
        .onAppear {
            playSeaShoreMusic()
        }
        .onDisappear {
            audioPlayer?.stop()
        }
    }
}

struct PuriSeaBeachPage_Previews: PreviewProvider {
    static var previews: some View {
        PuriSeaBeachPage()
    }
}

//.7 PAKHALA GAME

struct CustomizePakhalaPage: View {
    @State private var selectedPakhala: String = "Plain Pakhala"
    @State private var image: String = "PakhalaImage"
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.cyan.opacity(0.4)]),
                center: .center,
                startRadius: 50,
                endRadius: 600
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create Your Pakhala Dish")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.cyan.opacity(0.7))
                        .padding(.top, 40)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Steps to Prepare Pakhala:")
                            .font(.headline)
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("1. Ferment the rice by soaking cooked rice in water for 6-8 hours or overnight.")
                        Text("2. Add fresh water and a pinch of salt to the fermented rice.")
                        Text("3. Enhance the flavor with green chilies, curry leaves, and mustard seeds.")
                        
                        Text("Different Variants:")
                            .font(.headline)
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("- **Nimbu Pakhala:** Add fresh lemon juice for a tangy taste.")
                        Text("- **Dahi Pakhala:** Mix fresh curd (yogurt) for a creamy texture.")
                    }
                    .padding()
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    .padding(.horizontal)
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.top, 10)
                    
                    Text("Here's your \(selectedPakhala)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.cyan.opacity(0.7))
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            selectedPakhala = "Nimbu Pakhala"
                            image = "NimbuPakhalaImage"
                        }) {
                            Text("Add Lemon")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 150, height: 50)
                                .background(Color.cyan.opacity(0.5))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            selectedPakhala = "Dahi Pakhala"
                            image = "DahiPakhalaImage"
                        }) {
                            Text("Add Curd")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 150, height: 50)
                                .background(Color.cyan.opacity(0.5))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.top, 10)
                    
                    Text("Pakhala is not just food, it's an emotion!")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: GiftPage()) {
                        Text("A Suprise!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color.cyan.opacity(0.4))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .navigationBarTitle("Let's Cook!", displayMode: .inline)
        }
    }
}


//8. PATTACHITRA PAGE
struct GiftPage: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Here's a Gift for You!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink.opacity(0.6))
                    .padding(.top, 40)
                
                Image("PattachitraImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.top, 10)
                
                Text("My Pattachitra-inspired illustration blends elephants, lotus, and fish - symbolizing strength, enlightment, and prosperity.")
                    .font(.headline)
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.top, 10)
                
                Text("""
                Pattachitra is a traditional painting style from Odisha, India. These paintings are characterized by intricate designs, mythological themes, and natural colors. The name "Pattachitra" is derived from the Sanskrit words "Patta" (cloth) and "Chitra" (painting), meaning paintings on cloth.
                
                Elephants symbolize strength, wisdom, and prosperity. Lotus represents rising above challenges, just as a lotus blooms in muddy waters. Fish symbolizes flow, freedom, and adaptability.
                
                This ancient art form has been practiced for centuries and is known for its vibrant colors, detailed borders.
                """)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.horizontal)
                
                NavigationLink(destination: CreditsPage()) {
                    Text("All done!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(Color.yellow.opacity(0.2).ignoresSafeArea())
        .navigationBarTitle("Back", displayMode: .inline)
    }
}

//9. CREDITS
struct CreditsPage: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Credits")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue.opacity(0.8))
                    .padding(.top, 40)
                
                Image("CreditsImage") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.top, 10)
                
                Text("""
                Hi, I'm **Sloveni**, a 20-year-old from Odisha. I’m a passionate tech enthusiast who loves blending culture with modern technology.
                
                I crafted this entire experience-- from the illustrations and text to every interaction, to showcase the rich heritage of Odisha. Through this app, I aim to bring to life the essence of Odia culture, the magnificence of Rath Yatra, and the deep-rooted traditions that make puri truly special.
                
                All the sound effects used, including flute, tabla, and seashore, are free to use and are royalty-free. 
                
                By merging storytelling with technology, I hope to keep these traditions alive, making them accessible to a new generation. This is more than an app- it's a heartfelt tribute to my roots. I hope this experience leaves you with a sense of wonder and curiousity about Odisha's vibrant culture!
                
                **Illustrations & Design:**
                - Procreate
                - Apple Pencil
                
                **Music Credits:**
                - AVFoundation
                - Pixabay
                """)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(Color.gray.opacity(0.2).ignoresSafeArea())
        .navigationBarTitle("Credits", displayMode: .inline)
    }
}
