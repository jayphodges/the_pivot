start_time = Time.now
puts "Creating Categories"
guitar = Category.create!(title: "Guitar")
bass = Category.create!(title: "Bass")
amps = Category.create!(title: "Amps and Effects")
drums = Category.create!(title: "Drums")
keyboards = Category.create!(title: "Keyboards")
dj = Category.create!(title: "DJ")
woodwind = Category.create!(title: "Woodwind")
percussion = Category.create!(title: "Percussion")
stringed = Category.create!(title: "String")
brass = Category.create!(title: "Brass")
categories = Category.pluck(:title)
puts "Created #{Category.all.count} categories"
# businesses
puts "Creating Stores"
store_names = ["Hooked On Sonics", "We Got The Music (In Us)", "Musically Yours", "Music And Stuff ", "Sonic Boomland", "Neverending Music",
"Music Mania", "The Muse's Outlet", "Get Your Music Hear", "Muselicious", "In The Muse", "Sonar Eclipse", "Musephoria", "In The Groove",
"Musicalifragilisticexpialidocious", "You Are What You Hear", "Musiastic", "Taste The Music", "Museorama", "We Are Music"]

store_names.each do |name|
  puts "Creating Store: #{name}"
  Store.create(name: name, status: 1)
end
puts "Created #{Store.all.count} stores"

puts "Creating curated Items"
store1 = Store.first
store2 = Store.second

sam = User.create(username: 'sam', password: 'sam', full_name: 'sam lim', address: 'sams incubator')
joel = User.create(username: 'joel', password: 'joel', full_name: 'joel lindow', address: 'joels daycare')
randy = User.create(username: 'randy', password: 'randy', full_name: 'randy springer', address: 'randys campervan')
aaron = User.create(username: 'aaron', password: 'aaron', full_name: 'aaron hursh', address: 'aarons beard-grooming den')
admin = User.create(username: 'admin', password: 'admin', full_name: 'admin admin', address: 'admins administrator space of admin')

puts "Created #{User.count} of 5 users"

randy_order1 = randy.orders.create(status: 0, created_at: DateTime.strptime("08/24/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)
randy_order2 = randy.orders.create(status: 0, created_at: DateTime.strptime("07/23/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)

joel_order1 = joel.orders.create(status: 0, created_at: DateTime.strptime("06/17/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)
joel_order2 = joel.orders.create(status: 0, created_at: DateTime.strptime("05/12/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)

sam_order1 = sam.orders.create(status: 0, created_at: DateTime.strptime("08/13/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)
sam_order2 = sam.orders.create(status: 0, created_at: DateTime.strptime("08/15/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)

aaron_order1 = aaron.orders.create(status: 0, created_at: DateTime.strptime("03/21/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)
aaron_order2 = aaron.orders.create(status: 0, created_at: DateTime.strptime("05/16/2017 8:00", "%m/%d/%Y %H:%M"), store: store1)

puts "Created #{Order.count} of 8 orders"
puts "Creating curated OrdersItems"
randy_order1.items.create(store: store1, title: "Gibson", description: "When the double-cutaway SG was unveiled as the (temporary) replacement for the original single-cutaway Les Paul in 1961 it quickly proved itself far more than just a stand-in. An overnight success, this innovative guitar quickly became a favorite with rock, blues and jazz players and more. The flagship of the SG range, the SG Standard 2017 T represents a superb blend of historic looks, tone, contemporary versatility and playability. Its iconic asymmetrical double-horned body styling and smaller 'teardrop' pickguard harken back to the originals of the early ’60s, and the Classic ’57 humbuckers likewise take you straight back to those hallowed PAF tones. When uncompromising performance matters, locking Grover kidney-button tuners, a slim-taper neck and rosewood fingerboard with rolled binding, Gibson's finest modern aluminum Tune-O-Matic bridge and stop bar tailpiece with elegant chrome plating provide a stylish and modern SG playing experience. The SG Standard 2017 T is delivered in a classic Gibson hardshell case with a Gibson multi-tool, a premium leather strap and a polishing cloth.",
													price: 1300.0, category_id: guitar.id, image: File.open(Rails.root.join('app/assets/images', 'gibson_sg.png')))
OrdersItem.where(item_id: 1).update(unit_price: 1300.0)
randy_order1.items.create(store: store1, title: "Martin", description: "The custom 6-string X Series Custom DX1 Dreadnought Acoustic Guitar features a D-14 dreadnought body designed to produce a powerful, well-balanced tone that is perfect for live performance and in the studio. Pairing the Sitka spruce top with the mahogany HPL back and sides, this X Series Custom DX1 has a big, punchy tone, with all the sustain you have come to expect from a Martin guitar. The mortise-and-tenon neck joint ensures solid construction of the guitar, with optimal resonant tone, while eliminating drop-off in the finer dynamics.",
													price: 550.99, category_id: guitar.id, image: File.open(Rails.root.join('app/assets/images', 'martin.png')))
OrdersItem.where(item_id: 2).update(unit_price: 550.99)
randy_order1.items.create(store: store1, title: "Fender", description: "Inspired by the Pacific Ocean, the lustrous FSR Standard Telecaster HH Sea Foam Pearl is a tribute to the Telecaster guitar’s origin in California. With its unique aesthetic style, this is the perfect instrument for the stage—the one-of-a-kind finish shines under the spotlight with the glow of a moonlight ocean. Its exceptional style, thick voice and easy playability are sure to please those who like their music like the sea—mysterious and deep.",
													price: 550.50, category_id: guitar.id, image: File.open(Rails.root.join('app/assets/images', 'tele.png')))
OrdersItem.where(item_id: 3).update(unit_price: 550.50)
randy_order2.items.create(store: store1, title: "Epiphone", description: "Epiphone's history and association with Les Paul dates way back to the days when Les, working at the Epiphone factory on 14th St. in New York, created the world's first electric guitar. Over the years, Les continued to work closely with Epiphone by reviewing new product ideas and offering suggestions. The Epiphone Les Paul Quilt Top PRO electric guitar combines the best of Les Paul's original design with new features that set this Epiphone guitar apart. Case sold separately.",
													price: 599.99, category_id: guitar.id, image: File.open(Rails.root.join('app/assets/images', 'epiphone.png')))
OrdersItem.where(item_id: 4).update(unit_price: 599.99)
randy_order2.items.create(store: store1, title: "Schecter", description: "The Schecter Stiletto Stealth 5-string is a dark vision of your low end filled future. It's all black exterior will either have you running for the hills or reaching for the volume knob. Its combination of a solid basswood body and powerful Schecter pickups creates plenty of sustain and a myriad of killer bass tones, no matter what sound you're looking for. Plus, its thin maple neck with rosewood fretboard and curvaceous, lightweight body make your job easier, delivering exceptional playability in addition to earth-shaking tone.",
													price: 449.0, category_id: bass.id, image: File.open(Rails.root.join('app/assets/images', 'schecter.png')))
OrdersItem.where(item_id: 5).update(unit_price: 449.0)
randy_order2.items.create(store: store1, title: "ESP", description: "The LTD RB-1004 electric bass rocks a swamp ash body, burled maple solid top, a thin U-shape maple/walnut neck, 34 scale and 22 extra-jumbo frets on a maple fingerboard. And an Aguilar AG 4J-­HC bridge pickup & AG 4P-60 neck pickup push all your earth-rumbling notes down the signal path. A Gotoh bridge makes sure your notes have the maximum sustain imaginable, while the Grover tuners keep everything cinched down and in-tune through heavy crunches and string-stretching licks.",
													price: 1250.0, category_id: bass.id, image: File.open(Rails.root.join('app/assets/images', 'esp.png')))
OrdersItem.where(item_id: 6).update(unit_price: 1250.0)

sam_order1.items.create(store: store1, title: "Squier", description: "The Squier Vintage Modified Jaguar Bass Special SS features include a sleek offset-waist body and ultra-slim 30-scale maple neck, with the added one-two punch of a booming split-single-coil Precision Bass middle pickup paired with a growling Jazz Bass single-coil bridge pickup. More than just a student model, the Jaguar Bass Special SS is perfect for players of all kinds who appreciate the comfort of a short-scale instrument.",
													price: 199.95, category_id: bass.id, image: File.open(Rails.root.join('app/assets/images', 'squier.png')))
OrdersItem.where(item_id: 7).update(unit_price: 199.95)
sam_order1.items.create(store: store1, title: "Yamaha", description: "Designed by Yamaha and Nathan East, bassist for Eric Clapton and Phil Collins. For years the Yamaha BB Series basses have defined the best in bass technology, building a reputation for their excellent tone and sustain, comfortable feel, and quiet performance. This new BB model carries on the tradition with a slim-line, solid alder body topped with premium maple for unsurpassed looks, comfort, and tone. A thru-body maple and mahogany neck offers the ultimate in tone and stability, while its ebony fretboard has a smooth violin-type feel. Active electronics include 2 Alnico V-Stack pickups and a Nathan East NE1 parametric EQ for maximum sound-shaping capability. Die-cast gold with white tuners. Includes hardshell case.",
													price: 2500.0, category_id: bass.id, image: File.open(Rails.root.join('app/assets/images', 'yamaha.png')))
OrdersItem.where(item_id: 8).update(unit_price: 2500.0)
sam_order1.items.create(title: "Champion", description: "Simple to use and versatile enough for any style of guitar playing, there's a Champion amp that's right for you whether you're looking for your first practice amp or affordable stage gear. The 20W Champion 20 features a single 8 Special Design speaker, with great amp voices and effects that make it easy to dial up just the right sound - from jazz to country, blues to metal and more.",
													price: 50.0, category_id: amps.id, image: File.open(Rails.root.join('app/assets/images', 'champion.png')))
OrdersItem.where(item_id: 9).update(unit_price: 50.0)
sam_order2.items.create(store: store1, title: "Boss Distortion", description: "From screaming loud to whisper soft, the Boss DS-1 Distortion Pedal can faithfully reproduce the dynamics of your playing style. Level and distortion controls give you complete command of the amount of signal processing. Tone knob lets you tailor EQ right on the unit. The Boss DS-1 Distortion Pedal is a tough stompbox that can take whatever your boot can dish out. Includes 5-year warranty.",
													price: 99.99, category_id: amps.id, image: File.open(Rails.root.join('app/assets/images', 'boss-distortion.png')))
OrdersItem.where(item_id: 10).update(unit_price: 99.99)
sam_order2.items.create(store: store1, title: "Honeytone", description: "The Danelctro HoneyTone N-10 Guitar Mini Amp cranks like a little hot rod has a great clean or overdriven sound. The HoneyTone amp also boasts a real leather handle, belt clip, headphone jack, Volume, Tone, and Overdrive controls. The HoneyTone N-10 amp is powered by 9-volt battery (included) or a Danelectro DA-1 adapter.",
													price: 20.99, category_id: amps.id, image: File.open(Rails.root.join('app/assets/images', 'honeytone.png')))
OrdersItem.where(item_id: 11).update(unit_price: 20.99)
sam_order2.items.create(store: store1, title: "Orange", description: "The Orange Crush 35RT 35W guitar combo brings the legendary Orange sound to the rehearsal room. Sharing the Crush 20RT's twin-channel design, digital reverb and chromatic tuner, the Crush 35's larger size and bigger output section delivers even greater punch and volume. Complete with a transparent, fully buffered effects loop this amp goes way beyond the call of the traditional practice amplifier. And, with Oranges CabSim technology, you get an emulated 4x12 cab tone through the headphone output to give you huge sound even when youre practicing silently.",
													price: 259.0, category_id: amps.id, image: File.open(Rails.root.join('app/assets/images', 'orange.png')))
OrdersItem.where(item_id: 12).update(unit_price: 259.0)

joel_order1.items.create(store: store1, title: "Sabian", description: "Artisan Elite are the dark side of Artisan. The extensive multi-peen hammering results in tone that is undoubtedly lower-pitched, drier and more complex than regular Artisan Hats. The unique lathing also results in a very solid foot and contributes to the added complexity. With their traditional Artisan cup and weight (Medium-light top over a Medium-heavy bottom), the 14” Artisan Elite hats are versatile and remain a great choice for more mainstream sounds. ",
													price: 599.75, category_id: drums.id, image: File.open(Rails.root.join('app/assets/images', 'sabian.png')))
OrdersItem.where(item_id: 13).update(unit_price: 599.75)
joel_order1.items.create(store: store2, title: "Pearl", description: "Featuring 4-ply Maple reinforcement rings, Masters Maple Reserve is a natural choice for the most discerning musical pallet. This classic integration increases shell stability and tonal control, delivering rich, sustained lows and lively sonic punch. The MRV Series uses Premium North American Maple veneers from our exclusive Masterworks supply vault, the thin, 4-ply shell configuration (with reinforcement rings).",
													price: 5500.50, category_id: drums.id, image: File.open(Rails.root.join('app/assets/images', 'pearl.png')))
OrdersItem.where(item_id: 14).update(unit_price: 5500.50)
joel_order1.items.create(store: store2, title: "World Drums", description: "Built in the legendary Gon Bops shape, this Alex Acu±a series tumba drum is made from select North American ash. This Gon Bops drum boasts the same contour crown hoops and hardware as the California Series. Designed with Alex to offer exceptional warmth, clarity, and versatility, these conga drums are perfect for both studio and stage.",
													price: 450.0, category_id: drums.id, image: File.open(Rails.root.join('app/assets/images', 'world.png')))
OrdersItem.where(item_id: 15).update(unit_price: 450.0)
joel_order2.items.create(store: store2, title: "Tambourine", description: "Shake, rattle and roll with this traditional rhythm instrument. 5 bright-toned jingle pairs with clear plastic heads. Excellent for classroom use.",
													price: 3.99, category_id: drums.id, image: File.open(Rails.root.join('app/assets/images', 'tamborine.png')))
OrdersItem.where(item_id: 16).update(unit_price: 3.99)
joel_order2.items.create(store: store2, title: "Roland", description: "The Roland RD-2000 is a dream come true for the performing keyboardist. It features dual sound engines that power Roland's best acoustic and electric pianos ever, plus the finest action they have ever put into a stage piano. There’s a massive selection of top-quality ensemble sounds to cover any musical task, as well as two wave expansion slots for adding even more sounds. And with its innovative modern interface, the RD-2000 is the perfect master controller for working with today’s software-based instruments—taking this industry-standard stage piano series to new levels of inspiration and creativity.",
													price: 2499.0, category_id: keyboards.id, image: File.open(Rails.root.join('app/assets/images', 'roland.png')))
OrdersItem.where(item_id: 17).update(unit_price: 2499.0)
joel_order2.items.create(store: store2, title: "Korg", description: "Korg’s Professional Arrangers are among some of the most popular keyboards available, and now the Korg Pa4X continues on the series with improved sound quality and expressiveness, more extensive arranger functionality, and an upgraded interface including a larger color touch screen for fast access in any live situation. The Pa4x is loaded with high-capcity PCM sounds, that’s ten times the amount found in the Pa3X, including a stereo grand piano with full-key sampling plus string and damper resonance akin to the Kronos2. There’s also a 7” TFT color display, almost 1.5” bigger than the Pa3X, with improved sensitivity and tilt ability.",
													price: 3799.99, category_id: keyboards.id, image: File.open(Rails.root.join('app/assets/images', 'korg.png')))
OrdersItem.where(item_id: 18).update(unit_price: 3799.99)

aaron_order1.items.create(store: store2, title: "Moog", description: "The masterminds at Moog are rediscovering their past with the reintroduction of the Moog Synthesizer IIIc Modular system. Built using all-original documentation, art, and circuit board files, each Synthesizer IIIc features 36 hand-stuffed, hand-soldered modules, including ten 901-Series audio oscillators, the 984 Matrix Mixer, and the 905 Spring Reverb. It's been 50 years since the introduction of the first Synthesizer IIIc, but its triumphant return is certainly something to get excited about. However, production is highly limited, only 25 units will be produced and sold worldwide.",
													price: 35000.99, category_id: keyboards.id, image: File.open(Rails.root.join('app/assets/images', 'moog.png')))
OrdersItem.where(item_id: 19).update(unit_price: 35000.99)
aaron_order1.items.create(store: store2, title: "Keyboard Lab", description: "This keyboard package centers around the LC4 Music lab teaching system, and using the Yamaha DGX-660 keyboard as both the instructor hub and the student stations. This is a popular configuration for the LC-4 system.",
													price: 11000.0, category_id: keyboards.id, image: File.open(Rails.root.join('app/assets/images', 'keyboard_lab.png')))
OrdersItem.where(item_id: 20).update(unit_price: 11000.0)
aaron_order1.items.create(store: store2, title: "Pioneer Thing", description: "The Pioneer DDJ-RZX is a 4-channel professional controller for mobile DJs and anyone who wants to bring videos into their performances. Designed to make the most of the new rekordbox video Plus Pack for rekordbox dj, the DDJ-RZX builds on Pioneer's heritage of making video DJ equipment like the DVJ-1000 and SVM-1000. It features three touch screens for viewing track information and applied pad effects. Video previewing and monitoring is sharp on the 7 in. screens and they give access to all the key features in both rekordbox dj and the new rekordbox video Plus Pack, included with the DDJ-RZX.",
													price: 2949.95, category_id: dj.id, image: File.open(Rails.root.join('app/assets/images', 'pioneer.png')))
OrdersItem.where(item_id: 21).update(unit_price: 2949.95)
aaron_order2.items.create(store: store2, title: "Traktor", description: "The fifth edition in Native Instruments TRAKTOR Series, the KONTROL S5 is a portable 4-deck professional DJ controller that is built and ready for Stems, NI' multi-channel audio format for creative-style DJing. The S5 is loaded with professional features that have the ability to maximize your performance like two high-resolution, full-color deck displays that distinctly show key software views and pop-up panels that take your focus off of the computer and onto connecting with the crowd. The S5 is also loaded with touch-sensitive controls that can instantly trigger pop-up views, panels, playback, and quick access to two customizable FX units with over 30 studio quality effects plus Macro FX. The touch strips on the S5 provide tactile control over track position, pitch bend, and more, all of which adds to the S5' touch-and-see workflow delivering a unique, multi-sensory DJ experience.",
													price: 799.50, category_id: dj.id, image: File.open(Rails.root.join('app/assets/images', 'traktor.png')))
OrdersItem.where(item_id: 22).update(unit_price: 799.50)
aaron_order2.items.create(store: store2, title: "Gemini", description: "The MDJ-900 is aimed at the demanding professional DJ, boasting a large 8 in. touch-sensitive jog wheel and packed with tons of high-end features. This cutting-edge digital media player is all about ease-of-use, letting you mix effortlessly without the need for external software.",
													price: 299.60, category_id: dj.id, image: File.open(Rails.root.join('app/assets/images', 'gemini.png')))
OrdersItem.where(item_id: 23).update(unit_price: 299.60)
aaron_order2.items.create(store: store2, title: "Numark", description: "The Numark NV DJ controller and Dashboard display bundle adds a visual element to your DJ mixes. NV reimagines the hardware-software experience for the professional DJ. And what better way to enhance the performance of the NV then with the real-time visual feedback of Serato DJ via Dashboards three vibrant, 4.3 full-color screens. Get them both with just one purchase and be on your way to mastering digital mixes.",
													price: 998.0, category_id: dj.id, image: File.open(Rails.root.join('app/assets/images', 'numark.png')))
OrdersItem.where(item_id: 24).update(unit_price: 998.0)

puts "Created #{Item.count} of 24 items with #{OrdersItem.count} join rows"
puts "Curated items complete"

# Comment out after this part for a faster loading partial data set

# Users
until User.count == 997 do
  first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	full_name = "#{first_name} #{last_name}"
  username = "#{full_name.gsub(/\s+/, "").downcase}"
	address = Faker::Address.street_address
  User.create(username: username, password: "password", full_name: full_name, address: address)
  puts "Created #{full_name}'s account"
end

def adjective
  ['Small', 'Ergonomic', 'Rustic', 'Intelligent', 'Gorgeous', 'Incredible', 'Fantastic', 'Practical', 'Sleek', 'Awesome', 'Enormous', 'Mediocre', 'Synergistic', 'Heavy Duty', 'Lightweight', 'Aerodynamic', 'Durable'].sample
end

def material
  ['Steel', 'Wooden', 'Concrete', 'Plastic', 'Cotton', 'Granite', 'Rubber', 'Leather', 'Silk', 'Wool', 'Linen', 'Marble', 'Iron', 'Bronze', 'Copper', 'Aluminum', 'Paper'].sample
end

def dj_names
 name = []
 5.times do
 	name << Faker::App.name
 end
 name.uniq
end

def amp_names
	name = []
  5.times do
  	name << Faker::App.name
  end
  name.uniq
end

def music
	{
	"Guitar": ["Electric Guitar", "Acoustic Guitar", "Ukelele"], "Bass": ["Bass Guitar", "Bass"], "Drums": ["Drums"], "DJ": dj_names, "Amps and Effects": amp_names,
	"Keyboards": ["Organ", "Piano"], "Woodwind": ["Flute", "Clarinet", "Piccolo", "Clarinet", "Recorder", "Bassoon", "Oboe"],
	"Percussion": ["Cymbals", "Triangle", "Chimes", "Glockenspiel", "Timpani", "Bells", "Xylophone", "Tam-tam"], "String": ["Cello", "Harp", "Violin", "Viola", "Cello", "Dulcimer"],
	"Brass": ["Saxophone", "Trumpet", "Tuba", "French Horn", "Cornet", "Bugle", "Trombone"]
 }
end

# 10 categories
# 50 items per category

Category.all.each do |category|
  until category.items.count == 50 do
    insturment = music[category.title.to_sym]
    name = "#{adjective} #{material} #{insturment.sample}"
    description = Faker::Lorem.paragraph
    price = rand(200..2000)
		store = Store.all.sample
    item = Item.create(title: name, description: description, price: price, category: category, store: store, image: File.open(Rails.root.join("app/assets/images", "#{category.title.parameterize.underscore}.jpg")))
    puts "Creating #{category.title}: Item: #{item.title}"
  end
end


def weighed_number(weights)
  raise 'Probabilities must sum up to 1' unless weights.values.inject(&:+) == 1.0
  u = 0.0
  ranges = Hash[weights.map{ |v, p| [u += p, v] }]
  u = rand
  ranges.find{ |p, _| p > u }.last
end

# 10-20 orders per registered customer
User.all.each do |user|
  puts "Adding Orders to #{user.full_name} ID: #{user.id}"
	random = weighed_number({1 => 0.25, 2 => 0.3, 3 => 0.2, 4 => 0.15, 5 => 0.1})
	(random * 5).times do |order|
		t1 = Time.parse("2012-11-16 12:00:00")
		t2 = Time.parse("2018-09-15 12:00:00")
		store = Store.all.sample
		created = Order.create(user_id: user.id, status: weighed_number({0 => 0.2, 1 => 0.1, 2 => 0.1, 3 => 0.6 }), created_at: rand(t1..t2), updated_at: Time.now, store: store)
		(random).times do |add_item|
      item = Item.all.sample
			created.items << item
      OrdersItem.last.update(unit_price: item.price)
		end
	end
end

# 1 business manager per business with the following data:
# Username: josh@turing.io
# Password: password
josh = User.create(username: 'josh@turing.io', password: 'password', full_name: 'Josh Mejia', address: 'Somewhere in the Turing Basement')
josh.roles << Role.find_by(name: "business manager")
# 1 business admin per business, one with the following data:
# Username: ian@turing.io
# Password: password
ian = User.create(username: 'ian@turing.io', password: 'password', full_name: 'Ian Douglas', address: 'Somewhere in the Turing Basement')
ian.roles << Role.find_by(name: "business admin")
# 1 platform administrators
# Username: cory@turing.io
# Password: password
cory = User.create(username: 'cory@turing.io', password: 'password', full_name: 'Cory Westerfield', address: 'Somewhere in the Turing Basement')
cory.roles << Role.find_by(name: "platform admin")

puts "Seeding completed after #{((Time.now - start_time)/60).round(2)} minutes"
