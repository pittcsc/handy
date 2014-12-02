# Organizations
csc = Organization.create!(name: 'Pitt CSC')

# Users
joel = User.create!(email: 'joel@example.com', password: 'secret')

# Accesses
csc.accesses.create!(user: joel)

# Members
nina = Member.create!(name: 'Nina Kilback', email: 'nina@example.com', phone: '+15559647454')
josh = Member.create!(name: 'Josh Collins', email: 'josh@example.com', phone: '+15550788295')
will = Member.create!(name: 'Will Quigley', email: 'will@example.com', phone: '+15558189705')
annie = Member.create!(name: 'Annie Prosacco', email: 'annie@example.com', phone: '+15552102930')
lydia = Member.create!(name: 'Lydia Crist', email: 'lydia@example.com', phone: '+15555275228')
jared = Member.create!(name: 'Jared Moore', email: 'jared@example.com', phone: '+15557570576')
harvey = Member.create!(name: 'Harvey Hilpert', email: 'harvey@example.com', phone: '+15555596301')
carolyn = Member.create!(name: 'Carolyn Miller', email: 'carolyn@example.com', phone: '+15553411297')
rashad = Member.create!(name: 'Rashad Lockman', email: 'rashad@example.com', phone: '+15556254118')
sima = Member.create!(name: 'Sima Hettinger', email: 'sima@example.com', phone: '+15554871077')

# Events
meeting = csc.events.create!(name: 'Meeting', date: 1.week.ago)
workshop = csc.events.create!(name: 'Workshop', date: 2.weeks.from_now)

# Attendances
meeting.attendances.create!(member: nina)
meeting.attendances.create!(member: harvey)
meeting.attendances.create!(member: carolyn)
meeting.attendances.create!(member: will)
