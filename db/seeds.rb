# A Setting record must be created for the system to run.
Setting.create
Section.create title: 'This is section 1'
section = Section.create title: 'This is section 2'

Forum.create(
  title: 'This is forum 1',
  description: 'This is the forum description.',
  section: section
)

Forum.create(
  title: 'This is forum 2',
  description: 'This is the forum description.',
  section: section
)

User.create(
  username: 'admin',
  password: '123456',
  password_confirmation: '123456',
  email: 'admin@admin.com',
  role: :admin,
  terms_and_conditions: true
)
