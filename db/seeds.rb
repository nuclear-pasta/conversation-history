users = [
  { email: 'user1@example.com', password: 'password1' },
  { email: 'user2@example.com', password: 'password2' },
  { email: 'staff@example.com', password: 'password', staff: true }
]

users.each { |user_data| User.create(user_data) }

projects = [
  { name: 'Project 1', state: 'draft' },
  { name: 'Project 2', state: 'submitted' },
  { name: 'Project 3', state: 'approved' }
]

projects.each do |project_data|
  project = Project.new(project_data)
  project.save
end

comments = [
  { content: 'Comment 1', author: User.first, subject: Project.first },
  { content: 'Comment 2', author: User.last, subject: Project.first }
]

comments.each { |comment_data| Comment.create(comment_data) }

staff_user = User.find_by(email: 'staff@example.com')
project = Project.first

PaperTrail.request.whodunnit = staff_user.id

project.submit!
project.approve!

project.paper_trail.save_with_version

PaperTrail.request.whodunnit = nil

